-- Reloads this file whenever a 'json' file saved in snippet directory to
-- enable change immediately
local ns = "[cange.cmp.init]"
local cmp_ok, cmp = pcall(require, "cmp")
local luasnip_ok, luasnip = pcall(require, "luasnip")
local cmp_utils_ok, cmp_utils = pcall(require, "cange.cmp.utils")
if not cmp_ok then
  print(ns, '"cmp" not found')
  return
end
if not luasnip_ok then
  Log:warn('"luasnip" not found', { title = ns })
  return
end
if not cmp_utils_ok then
  Log:warn('"cange.cmp.utils" not found', { title = ns })
  return
end

require("luasnip.loaders.from_vscode").lazy_load({ paths = Cange.get_config("snippets.path") })

local M = {}

M.opts = {
  completion = {
    completeopt = "menu,menuone",
  },

  mapping = {
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-a>"] = cmp.mapping.scroll_docs(-4),
    ["<C-s>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<C-h>"] = cmp.mapping(function()
      if luasnip.choice_active() then
        luasnip.change_choice(-1)
      else
        cmp.mapping.select_prev_item()
      end
    end, { "i", "s" }),
    ["<C-l>"] = cmp.mapping(function()
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      else
        cmp.mapping.select_next_item()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = "nvim_lsp", max_item_count = 5 },
    { name = "luasnip", max_item_count = 3 },
    { name = "path", max_item_count = 2, keyword_length = 2 },
    { name = "nvim_lua", max_item_count = 2 },
    { name = "nvim_lsp_signature_help" },
    { name = "buffer", max_item_count = 2, keyword_length = 3 },
    { name = "copilot" },
    { name = "cmp_tabnine" },
  },
  snippet = {
    expand = function(args) require("luasnip").lsp_expand(args.body) end,
  },
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
  formatting = {
    fields = { -- order within a menu item
      "menu",
      "abbr",
      "kind",
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
