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

local tabnine_found, _ = pcall(require, 'cmp_tabnine.config')
if not tabnine_found then
  print('[cmp.init] "cmp_tabnine.config" not found')
  return
end

vim.keymap.set({ 'i', 's' }, '<C-]>', '<Plug>luasnip-prev-choice')
vim.keymap.set({ 'i', 's' }, '<C-[>', '<Plug>luasnip-next-choice')

local mapping = cmp.mapping
local settings = vim.tbl_extend('keep', config.props, {
  mapping = {
    ['<C-Space>'] = mapping(mapping.complete(), { 'i', 'c' }),
    ['<C-b>'] = mapping(mapping.scroll_docs(-1), { 'i', 'c' }),
    ['<C-f>'] = mapping(mapping.scroll_docs(1), { 'i', 'c' }),
    ['<C-up>'] = mapping.select_prev_item(),
    ['<C-down>'] = mapping.select_next_item(),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<ESC>'] = mapping({
      i = mapping.abort(),
      c = mapping.close(),
    }),
    ['<C-e>'] = mapping({
      i = mapping.abort(),
      c = mapping.close(),
    }),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = mapping.confirm({ select = true }),
    ['<down>'] = mapping(config.next_item, { 'i', 's' }),
    ['<Tab>'] = mapping(config.next_item, { 'i', 's' }),
    ['<up>'] = mapping(config.prev_item, { 'i', 's' }),
    ['<S-Tab>'] = mapping(config.prev_item, { 'i', 's' }),
  },
})
return cmp.setup(settings)
