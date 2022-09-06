-- Reloads this file whenever a 'json' file saved in snippet directory to
-- enable change immediately
vim.cmd [[
  augroup cmp_autoreload
  autocmd!
  autocmd BufWritePost ~/dotfiles/nvim/snippets/**/*.json source ~/dotfiles/nvim/after/plugin/cmp.rc.lua
  augroup end
]]

local found_cmp, cmp = pcall(require, 'cmp')
if not found_cmp then return end

local found_config, config = pcall(require, 'cange.cmp.config')
if not found_config then
  vim.notify('cmp: "cange.cmp.config" could not be found')
  return
end

local tabnine_found, _ = pcall(require, 'cmp_tabnine.config')
if not tabnine_found then
  vim.notify('cmp: "cmp_tabnine.config" could not be found')
  return
end

return cmp.setup({
  snippet = config.snippet,
  mapping = {
    ['<C-up>'] = cmp.mapping.select_prev_item(),
    ['<C-down>'] = cmp.mapping.select_next_item(),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm { select = true },
    ['<down>'] = cmp.mapping(config.handlers.next_item, { 'i', 's' }),
    ['<Tab>'] = cmp.mapping(config.handlers.next_item, { 'i', 's' }),
    ['<up>'] = cmp.mapping(config.handlers.prev_item, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(config.handlers.prev_item, { 'i', 's' }),
  },
  formatting = config.formatting,
  sources = config.sources,
  -- sources = {
  --   { name = 'nvim_lsp' }, -- we want to LSP suggestion first
  --   { name = 'luasnip' },
  --   { name = 'buffer' },
  --   { name = 'path' },
  -- },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    documentation = cmp.config.window.bordered(),
  },
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
})
