local lsp = Cange.bulk_loader('lsp', {
  -- { 'nvim-navic', 'nvim_navic' },
  { 'cmp_nvim_lsp', 'cmp_nvim_lsp' },
})

local function attach_navic(client, bufnr)
  vim.g.navic_silence = true
  -- lsp.nvim_navic.attach(client, bufnr)
end

local function attach_keymaps(_, bufnr)
  -- Use LSP as the handler for formatexpr.
  vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')

  local function keymap(lhs, rhs)
    local mode = 'n'
    local opts = { noremap = true, silent = true }
    -- See `:help nvim_buf_set_keymap()` for more information
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
  end

  keymap('<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  keymap('K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  keymap('gI', '<cmd>Telescope lsp_implementations<CR>')
  keymap('gT', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  keymap('gd', '<cmd>Telescope lsp_definitions<CR>')
  keymap('gf', '<cmd>lua vim.diagnostic.open_float()<CR>')
  keymap('gl', '<cmd>lua vim.diagnostic.setloclist()<CR>')
  keymap('gr', '<cmd>Telescope lsp_references<CR>')
  keymap('gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
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
