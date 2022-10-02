-- Reloads this file whenever a 'json' file saved in snippet directory to
-- enable change immediately
vim.cmd([[
  augroup cmp_autoreload
  autocmd!
  autocmd BufWritePost ~/dotfiles/nvim/snippets/**/*.json source ~/dotfiles/nvim/after/plugin/cmp.rc.lua
  augroup end
]])

local found_cmp, cmp = pcall(require, 'cmp')
if not found_cmp then
  return
end

local found_config, config = pcall(require, 'cange.cmp.config')
if not found_config then
  print('[cmp.init] "cange.cmp.config" not found')
  return
end
local function keymap(lhs, rhs)
  vim.keymap.set({ 'i', 's' }, lhs, rhs, { noremap = true, silent = true })
end

local mapping = cmp.mapping
-- config
keymap('<C-[>', '<Plug>luasnip-prev-choice')
keymap('<C-]>', '<Plug>luasnip-next-choice')
keymap('<C-up>', '<Plug>luasnip-prev-choice')
keymap('<C-down>', '<Plug>luasnip-next-choice')

local settings = vim.tbl_extend('keep', config.props, {
  mapping = {
    ['<C-Space>'] = mapping(mapping.complete(), { 'i', 'c' }),
    ['<C-a>'] = mapping(mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-s>'] = mapping(mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<CR>'] = mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<ESC>'] = mapping({
      i = mapping.abort(),
      c = mapping.close(),
    }),
    ['<C-e>'] = mapping({
      i = mapping.abort(),
      c = mapping.close(),
    }), -- Accept currently selected item. If none selected, `select` first item.
    ['<down>'] = mapping(config.next_item, { 'i', 's' }),
    ['<Tab>'] = mapping(config.next_item, { 'i', 's' }),
    ['<up>'] = mapping(config.prev_item, { 'i', 's' }),
    ['<S-Tab>'] = mapping(config.prev_item, { 'i', 's' }),
  },
})

cmp.setup(settings)
