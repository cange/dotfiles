---@class Cange.cmp

-- Reloads this file whenever a 'json' file saved in snippet directory to
-- enable change immediately
local ns = "[cange.cmp.init]"
local cmp = require("cmp")
local luasnip = require("luasnip")
local found_cmp_utils, cmp_utils = pcall(require, "cange.cmp.utils")
if not found_cmp_utils then
  print(ns, '"cange.cmp.utils" not found')
  return
end

-- Setup
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- enable Insert mode completion

require("luasnip.loaders.from_vscode").lazy_load({ paths = Cange.get_config("snippets.path") })
-- require("luasnip.loaders.from_vscode").lazy_load() -- community snippets (create noise)

local prev_item_handler = function(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    fallback()
  end
end
local next_item_handler = function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.expandable() then
    luasnip.expand()
  elseif luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  elseif cmp_utils.has_words_before() then
    fallback()
  else
    fallback()
  end
end

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<C-a>"] = cmp.mapping.scroll_docs(-4),
    ["<C-s>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),

    -- Choice
    ["<C-n>"] = cmp.mapping(function()
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      else
        cmp.mapping.select_next_item()
      end
    end, { "i" }),
    ["<C-p>"] = cmp.mapping(function()
      if luasnip.choice_active() then
        luasnip.change_choice(-1)
      else
        cmp.mapping.select_prev_item()
      end
    end, { "i" }),

    ["<C-e>"] = cmp.mapping.close(),
    ["<C-c>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<C-j>"] = cmp.mapping(next_item_handler, { "i", "s" }),
    ["<C-k>"] = cmp.mapping(prev_item_handler, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(prev_item_handler, { "i", "s" }),
    ["<Tab>"] = cmp.mapping(next_item_handler, { "i", "s" }),
  }),
  sources = {
    { name = "cmp_tabnine", keyword_length = 3, max_item_count = 5 },
    { name = "luasnip", keyword_length = 2, max_item_count = 5 },
    { name = "nvim_lsp", keyword_length = 3 },
    { name = "nvim_lua", keyword_length = 3 },
    { name = "buffer", keyword_length = 3, max_item_count = 3 },
    { name = "path", keyword_length = 3, max_item_count = 3 },
  },
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
})

-- https://github.com/hrsh7th/cmp-cmdline

-- `/` cmdline setup.
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- `:` cmdline setup.
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
