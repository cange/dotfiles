local user = {}
---@see cmp.FormattingConfig
function user.format(entry, vim_item)
  local maxwidth = 80
  local src_icons = {
    buffer = Icon.ui.Database,
    copilot = Icon.plugin.Copilot,
    luasnip = Icon.ui.Library,
    nvim_lsp = Icon.ui.Globe,
    nvim_lua = Icon.extensions.Lua,
    path = Icon.ui.Path,
  }
  local src_name = entry.source.name
  local cmp_item = entry.completion_item or {}
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

  if src_name == "copilot" then
    is_multiline = ((cmp_item.documentation or {}).value or ""):find(".*\n.+\n.+\n") ~= nil
  end

  ---@diagnostic disable-next-line: param-type-mismatch
  local kinds = Icon.cmp_kinds or {}
  local kind_icon = kinds[vim_item.kind] or Icon.cmp_kinds[is_multiline and "MultiLine" or "SingleLine"]

  vim_item.kind = kind_icon .. " "
  vim_item.abbr = vim_item.abbr:sub(1, maxwidth)
  vim_item.menu = vim.tbl_contains(vim.tbl_keys(src_icons), src_name) and src_icons[src_name] .. " " or vim_item.menu

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
      "hrsh7th/cmp-nvim-lua", -- Neovim's Lua API
      "hrsh7th/cmp-path", -- path completions
      "chrisgrieser/cmp-nerdfont",
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
          ["<C-a>"] = cmp.mapping.scroll_docs(-4),
          ["<C-x>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = mapping.apply_item_and_select_next,
          -- Accept currently selected item. Set `select` to `false` to only confirm
          -- explicitly selected items.
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            -- Accept currently selected item. Set `select` to `false` to only
            -- confirm explicitly selected items.
            select = true,
          }),
          ["<ESC>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
          ["<Tab>"] = mapping.select_next_item,
          ["<down>"] = mapping.select_next_item,
          ["<S-Tab>"] = mapping.select_prev_item,
          ["<up>"] = mapping.select_prev_item,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp", max_item_count = 10 },
          { name = "luasnip" },
          { name = "copilot" },
          { name = "path" },
          { name = "nerdfont" },
          { name = "buffer" },
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
            col_offset = -3, -- align abbr text with kind icons in prefix
          },
        },
      })

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
