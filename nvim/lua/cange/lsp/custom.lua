local lsp = _G.bulk_loader('lsp', {
  { 'nvim-navic', 'nvim_navic' },
  { 'cmp_nvim_lsp', 'cmp_nvim_lsp' },
})

local function attach_navic(client, bufnr)
  vim.g.navic_silence = true
  lsp.nvim_navic.attach(client, bufnr)
end

local function attach_keymaps(_, bufnr)
  local function keymap(mode, lhs, rhs)
    local opts = { noremap = true, silent = true }
    -- See `:help nvim_buf_set_keymap()` for more information
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
  end

  keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>')
  keymap('n', 'gD', '<cmd>Telescope lsp_declarations<CR>')
  keymap('n', 'gI', '<cmd>Telescope lsp_implementations<CR>')
  keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>')
  keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')

  -- Use LSP as the handler for formatexpr.
  vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')
  -- keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  -- keymap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>')
  -- keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  -- keymap('n', '<A-a>', '<cmd>lua vim.lsp.buf.code_action()<cr>')

  -- keymap('n', '<M-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  -- keymap('n', '<leader>f', '<cmd>lua vim.diagnostic.open_float()<CR>')
  -- keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded' })<CR>')
  -- keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next({ border = 'rounded' })<CR>')
  -- keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>')
end


M = {}

function M.capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = lsp.cmp_nvim_lsp.update_capabilities(capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  return capabilities
end

---Keymapping for lspconfig on_attach options
-- @param _ any
-- @param bufnr integer buffer
function M.on_attach(client, bufnr)
  attach_navic(client, bufnr)
  attach_keymaps(client, bufnr)
end

return M
