local user = {}
---@see cmp.FormattingConfig
function user.format(entry, vim_item)
  local maxwidth = 80
  local src_icons = {
    buffer = Icon.ui.Database,
    luasnip = Icon.ui.Library,
    nvim_lsp = Icon.plugin.LSP,
    nvim_lua = Icon.extensions.Lua,
    path = Icon.ui.Path,
  }
  local src_name = entry.source.name
  local is_multiline = false

  -- Show filetype icons for path source
  if vim.tbl_contains({ "path" }, entry.source.name) then
    local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
    if icon then
      vim_item.kind = icon
      vim_item.kind_hl_group = hl_group
      return vim_item
    end
  end

  ---@diagnostic disable-next-line: param-type-mismatch
  local kinds = Icon.cmp_kinds or {}
  local kind_icon = kinds[vim_item.kind] or Icon.cmp_kinds[is_multiline and "MultiLine" or "SingleLine"]

  vim_item.kind = kind_icon
  vim_item.abbr = vim_item.abbr:sub(1, maxwidth)
  vim_item.menu = vim.tbl_contains(vim.tbl_keys(src_icons), src_name) and src_icons[src_name] or vim_item.menu

  return vim_item
end

function user.mapping(cmp, luasnip)
  return {
    -- items
    select_next_item = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s" }),
    select_prev_item = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s" }),
    -- choices within snippet
    select_next_snippet_choice = cmp.mapping(function(fallback)
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      else
        fallback() -- required to exit when in insert mode
      end
    end, { "i", "s" }),
    select_prev_snippet_choice = cmp.mapping(function(fallback)
      if luasnip.choice_active() then
        luasnip.change_choice(-1)
      else
        fallback() -- required to exit when in insert mode
      end
    end, { "i", "s" }),
    apply_item_and_select_next = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      end
      cmp.abort()
      fallback()
    end, { "i", "s" }),
  }
end

local better_vue = {
  is_in_start_tag = function()
    local node = vim.treesitter.get_node()
    if not node then return false end
    local node_to_check = { "start_tag", "self_closing_tag", "directive_attribute" }
    return vim.tbl_contains(node_to_check, node:type())
  end,

  on_menu_closed = function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.b[bufnr]._vue_ts_cached_is_in_start_tag = nil
  end,
}

better_vue.sources_entry_filter = function(entry, ctx)
  -- better vue support https://github.com/vuejs/language-tools/discussions/4495
  -- Use a buffer-local variable to cache the result of the Treesitter check
  local bufnr = ctx.bufnr
  local cached_is_in_start_tag = vim.b[bufnr]._vue_ts_cached_is_in_start_tag

  if cached_is_in_start_tag == nil then vim.b[bufnr]._vue_ts_cached_is_in_start_tag = better_vue.is_in_start_tag() end

  -- If not in start tag, return true
  if vim.b[bufnr]._vue_ts_cached_is_in_start_tag == false then return true end
  if ctx.filetype ~= "vue" then return true end

  local cursor_before_line = ctx.cursor_before_line
  local label = entry.completion_item.label

  if cursor_before_line:sub(-1) == "@" then
    return label:match("^@")
  elseif cursor_before_line:sub(-1) == ":" then
    return label:match("^:") and not label:match("^:on%-")
  else
    return true
  end
end

return {
  { -- code completion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    lazy = true,
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip", -- snippet completions
      "hrsh7th/cmp-buffer", -- source for buffer words
      "hrsh7th/cmp-cmdline", -- cmdline completions
      "hrsh7th/cmp-nvim-lsp", -- source for neovim’s built-in LSP
      "hrsh7th/cmp-nvim-lsp-signature-help", -- displaying function signatures
      "hrsh7th/cmp-nvim-lua", -- Neovim's Lua API
      "hrsh7th/cmp-path", -- path completions
      "chrisgrieser/cmp-nerdfont",
      "windwp/nvim-autopairs",
    },
    config = function()
      local cmp = require("cmp")
      local max_count = 16
      local mapping = user.mapping(cmp, require("luasnip"))

      cmp.setup({
        completion = {
          completeopt = "menu,menuone",
        },
        mapping = {
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-[>"] = mapping.select_prev_snippet_choice,
          ["<C-]>"] = mapping.select_next_snippet_choice,
          ["<C-h>"] = mapping.select_prev_snippet_choice,
          ["<C-l>"] = mapping.select_next_snippet_choice,
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-CR>"] = mapping.apply_item_and_select_next,
          -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
          ["<ESC>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
          ["<Tab>"] = mapping.select_next_item,
          ["<S-Tab>"] = mapping.select_prev_item,
          ["<down>"] = mapping.select_next_item,
          ["<up>"] = mapping.select_prev_item,
        },
        sources = cmp.config.sources({
          { name = "luasnip", priority = 1 },
          {
            name = "nvim_lsp",
            priority = 2,
            max_item_count = 10,
            entry_filter = better_vue.sources_entry_filter,
          },
          { name = "buffer", priority = 3 },
          { name = "path", priority = 4 },
          { name = "nvim_lsp_signature_help" },
          { name = "nerdfont", priority = 99 },
        }),
        snippet = {
          expand = function(args) require("luasnip").lsp_expand(args.body) end,
        },
        experimental = { ghost_text = { hl_group = "CmpGhostText" } },
        formatting = {
          fields = { -- order within a menu item
            "kind",
            "abbr",
            "menu",
          },
          format = user.format,
        },
        window = {
          completion = {
            col_offset = -2, -- align abbr text with kind icons in prefix
          },
        },
      })

      cmp.event:on("menu_closed", better_vue.on_menu_closed)

      -- If you want insert `(` after select function or method item
      cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

      -- https://github.com/hrsh7th/cmp-cmdline
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer", max_item_count = max_count },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path", max_item_count = max_count },
        }, {
          { name = "cmdline", max_item_count = max_count },
        }),
      })
    end,
  },

  { -- snippets
    "L3MON4D3/LuaSnip",
    lazy = true,
    init = function() require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.fn.expand("~/.config/snippets") }) end,
  },
}
