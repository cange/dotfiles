local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_ok then
  vim.notify('lspconfig not found')
  return
end

local function on_attach(_, bufnr)
  -- Set up attach options
  local keymap = vim.api.nvim_buf_set_keymap
  local opts = { noremap = true, silent = true }
  keymap(bufnr, 'n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
  keymap(bufnr, 'n', 'gD', '<cmd>Telescope lsp_declarations<CR>', opts)
  keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  keymap(bufnr, 'n', 'gI', '<cmd>Telescope lsp_implementations<CR>', opts)
  keymap(bufnr, 'n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
  keymap(bufnr, 'n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  keymap(bufnr, 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  keymap(bufnr, 'n', '<A-f>', '<cmd>Format<cr>', opts)
  keymap(bufnr, 'n', '<A-a>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

  -- keymap(bufnr, 'n', '<M-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  -- keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded' })<CR>', opts)
  -- keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next({ border = 'rounded' })<CR>', opts)
  -- keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
end

-- Set up lsp cmp (completion)
local cmp_lsp_ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_lsp_ok then return end

local capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local lsp_opts = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
}

local providers_ok, providers = pcall(require, 'cange.lsp.providers')
if not providers_ok then
  vim.notify 'lspconfig: LSP provider could not be found'
  return
end

-- iterate through provider push settings if given and initiate them
for _, provider in pairs(providers.lsp) do
  local settings_ok, settings = pcall(require, 'cange.lsp.providers.' .. provider)

  if settings_ok then
    lsp_opts = vim.tbl_deep_extend('force', settings, lsp_opts)
  end

  lspconfig[provider].setup(lsp_opts)
end
