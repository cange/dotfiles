-- Reloads this file whenever a 'json' file saved in snippet directory to
-- enable change immediately
local ns = "[cange.cmp.init]"
local found_cmp, cmp = pcall(require, "cmp")
local found_luasnip, luasnip = pcall(require, "luasnip")
local found_cmp_utils, cmp_utils = pcall(require, "cange.cmp.utils")
if not found_cmp then
  print(ns, '"cmp" not found')
  return
end
if not found_luasnip then
  print(ns, '"luasnip" not found')
  return
end
if not found_cmp_utils then
  print(ns, '"cange.cmp.utils" not found')
  return
end

-- Setup
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- enable Insert mode completion

require("luasnip.loaders.from_vscode").lazy_load({ paths = Cange.get_config("snippets.path") })

local function prev_item_handler(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    fallback()
  end
end
local function next_item_handler(fallback)
  if cmp.visible() and cmp_utils.has_words_before() then
    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
  elseif luasnip.expandable() then
    luasnip.expand()
  elseif luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  elseif cmp_utils.has_words_before() then
    cmp.complete()
  else
    fallback()
  end
end
local function prev_choice_handler()
  if luasnip.choice_active() then
    luasnip.change_choice(-1)
  else
    cmp.mapping.select_prev_item()
  end
end
local function next_choice_handler()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  else
    cmp.mapping.select_next_item()
  end
end

-- stylua: ignore start
local sources =cmp.config.sources({
  { name = "nvim_lsp",    group_index = 1,    max_item_count = 5 },
  { name = "luasnip",     group_index = 2,    max_item_count = 3 },
  { name = "copilot",     group_index = 4 },
  { name = "cmp_tabnine", group_index = 6,    max_item_count = 2 },
  { name = "path",                            max_item_count = 2, keyword_length = 2 },
  { name = "nvim_lua",                        max_item_count = 2 },
  { name = "nvim_lsp_signature_help" },
  { name = "buffer",                          max_item_count = 2, keyword_length = 3 },
})
-- stylua: ignore end

local M = {}

M.opts = {
  mapping = cmp.mapping.preset.insert({
    ["<C-a>"] = cmp.mapping.scroll_docs(-4),
    ["<C-s>"] = cmp.mapping.scroll_docs(4),

    ["<C-j>"] = cmp.mapping(next_item_handler, { "i", "s" }),
    ["<C-k>"] = cmp.mapping(prev_item_handler, { "i", "s" }),
    ["<Tab>"] = cmp.mapping(next_item_handler, { "i", "s" }),

    ["<C-h>"] = cmp.mapping(prev_choice_handler, { "i", "s" }),
    ["<C-l>"] = cmp.mapping(next_choice_handler, { "i", "s" }),

    ["<C-c>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      -- https://github.com/zbirenbaum/copilot-cmp#clear_after_cursor
      select = false,
    }),
    ["<C-space>"] = cmp.mapping.complete(),
  }),
  sources = sources,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
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
