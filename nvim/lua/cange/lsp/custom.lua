local ns = "cange.lsp.custom"
local found_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not found_cmp then
  print("[" .. ns .. '] "cmp_nvim_lsp" not found')
  return
end

local found_winbar, winbar = pcall(require, "cange.winbar")
if not found_winbar then
  print("[" .. ns .. '] "cange.winbar" not found')
  return
end

local function attach_keymaps(_, bufnr)
  -- Use LSP as the handler for formatexpr.
  vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  local function keymap(lhs, rhs, desc)
    local mode = "n"
    desc = desc or ""
    local opts = { desc = desc, noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  keymap("K", vim.lsp.buf.hover, "hover (LSP)")
  keymap("gD", vim.lsp.buf.declaration, "go to declaration (LSP)")
  keymap("gI", "<cmd>Telescope lsp_implementations<CR>", "go to implementation (LSP)")
  keymap("gT", vim.lsp.buf.type_definition, "Go to type (LSP)")
  keymap("gd", vim.lsp.buf.definition, "Go to definition (LSP)")
  keymap("gj", vim.diagnostic.goto_next, "Go to next issue (LSP)")
  keymap("gk", vim.diagnostic.goto_prev, "Go to previous issue (LSP)")
  keymap("gs", vim.lsp.buf.signature_help, "info about symbol (LSP)")
  keymap("gq", vim.lsp.buf.code_action, "QuickFix issue (LSP)")
  keymap("<leader>wd", "<cmd>Telescope lsp_document_symbols<CR>", "show symbols (LSP)")
  keymap("<leader>rn", vim.lsp.buf.rename, "rename symbol (LSP)")
  keymap("<leader>dr", "<cmd>Telescope lsp_references<CR>")
  keymap("<leader>dd", "<cmd>Telescope diagnostics<CR>", "List of issues")
end

---@module 'cange.lsp.custom'
local M = {}

function M.capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  return capabilities
end

---Keymapping for lspconfig on_attach options
-- @param client any
-- @param bufnr integer buffer
function M.on_attach(client, bufnr)
  winbar.attach(client, bufnr)
  attach_keymaps(client, bufnr)
end

return M
