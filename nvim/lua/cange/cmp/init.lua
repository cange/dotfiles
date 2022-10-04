-- Reloads this file whenever a 'json' file saved in snippet directory to
-- enable change immediately
local ns = 'cange.cmp.init'
local found_cmp, cmp = pcall(require, 'cmp')
if not found_cmp then
  return
end
local found_luasnip, luasnip = pcall(require, 'luasnip')
if not found_luasnip then
  print('[' .. ns .. '] "luasnip" not found')
  return
end
local found_config_luasnip, config_luasnip = pcall(require, 'cange.cmp.luasnip')
if not found_config_luasnip then
  print('[' .. ns .. '] "cange.cmp.luasnip" not found')
  return
end
local found_utils, utils = pcall(require, 'cange.utils')
if not found_utils then
  print('[' .. ns .. '] "cange.utils" not found')
  return
end
local found_cmp_utils, cmp_utils = pcall(require, 'cange.cmp.utils')
if not found_cmp_utils then
  print('[' .. ns .. '] "cange.cmp.utils" not found')
  return
end
local function menu_item_format(entry, vim_item)
  local source_types = utils.icons.cmp_source
  local name = entry.source.name
  if vim.tbl_contains(vim.tbl_keys(source_types), name) then
    vim_item.menu = source_types[name].icon
    vim_item.menu_hl_group = 'Comment' -- assign appropriate theme color
  end
  vim_item.kind = utils.icons.cmp_kind[vim_item.kind]
  return vim_item
end

--config
config_luasnip.setup()
local keymap = utils.keymap
keymap({ 'i', 's' }, '<C-[>', '<Plug>luasnip-prev-choice')
keymap({ 'i', 's' }, '<C-]>', '<Plug>luasnip-next-choice')

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-s>'] = cmp.mapping.scroll_docs(4),
    ['<C-a>'] = cmp.mapping.scroll_docs(-4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-c>'] = cmp.mapping.abort(),
    ['<ESC>'] = cmp.mapping(cmp.mapping.abort(), { 'i', 'c' }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confi
    ['<S-CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confi

    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif cmp_utils.jumpable(1) then
        luasnip.jump(1)
      elseif cmp_utils.has_words_before() then
        fallback()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    {
      name = 'luasnip',
      keyword_length = 2,
      max_item_count = 5,
      option = { use_show_condition = false },
    },
    { name = 'buffer', keyword_length = 3, max_item_count = 5 },
    { name = 'nvim_lsp', keyword_length = 3, max_item_count = 9 },
    { name = 'cmp_tabnine', keyword_length = 3, max_item_count = 3 },
    { name = 'nvim_lua', keyword_length = 3, max_item_count = 5 },
    { name = 'path', keyword_length = 3, max_item_count = 3 },
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
      'kind',
      'abbr',
      'menu',
    },
    format = menu_item_format,
  },
  window = {
    completion = {
      col_offset = -3, -- align abbr text with kind icons in prefix
    },
  },
})
