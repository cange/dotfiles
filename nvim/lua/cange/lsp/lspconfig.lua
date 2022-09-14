local found, lspconfig = pcall(require, 'lspconfig')
if not found then
  return
end

local function lsp_on_attach(_, bufnr)
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
local found_cmp_lsp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if not found_cmp_lsp then
  return
end

local function lsp_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = cmp_lsp.update_capabilities(capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return capabilities
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local lsp_opts = {
  on_attach = lsp_on_attach,
  capabilities = lsp_capabilities(),
  flags = lsp_flags,
}

local found_settings, editor_settings = pcall(require, 'cange.settings.editor')
if not found_settings then
  vim.notify('lspconfig: "cange.settings.lsp" could not be found')
  return
end

-- iterate through provider push settings if given and initiate them
for _, provider in pairs(editor_settings.lsp.providers.language_servers) do
  local found_provider_opts, provider_opts = pcall(require, 'cange.lsp.providers.' .. provider)

  if found_provider_opts then
    lsp_opts = vim.tbl_deep_extend('force', provider_opts, lsp_opts)
  end

  lspconfig[provider].setup(lsp_opts)
end
