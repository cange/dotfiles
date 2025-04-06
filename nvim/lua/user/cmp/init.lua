-- Reloads this file whenever a 'json' file saved in snippet directory to
-- enable change immediately
local cmp_ok, cmp = pcall(require, "cmp")
local luasnip_ok, luasnip = pcall(require, "luasnip")
local cmp_utils_ok, cmp_utils = pcall(require, "user.cmp.utils")
if not cmp_ok then error('"cmp" not found') end
if not luasnip_ok then error('"luasnip" not found') end
if not cmp_utils_ok then error('"user.cmp.utils" not found') end

local mapping = {
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

local M = {}
M.opts = {
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
  }, {
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
    format = cmp_utils.format,
  },
  window = {
    completion = {
      col_offset = -3, -- align abbr text with kind icons in prefix
    },
  },
}

return M
