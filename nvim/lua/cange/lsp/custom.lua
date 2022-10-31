local ns = "[cange.lsp.custom]"
local found_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not found_cmp then
  print(ns, '"cmp_nvim_lsp" not found')
  return
end

local found_winbar, winbar = pcall(require, "cange.core.winbar")
if not found_winbar then
  print(ns, '"cange.core.winbar" not found')
  return
end

local function attach_keymaps(client, bufnr)
  -- Use LSP as the handler for formatexpr.
  vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  ---Preconfigured keymap
  ---@param lhs string
  ---@param rhs string|function
  ---@param desc? string
  local function keymap(lhs, rhs, desc)
    local mode = "n"
    desc = desc or ""
    local opts = { desc = desc, noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  keymap("K", vim.lsp.buf.hover, "LSP Hover")
  keymap("gD", vim.lsp.buf.declaration, "LSP Go to Declaration")
  keymap("gI", "<cmd>Telescope lsp_implementations<CR>", "LSP Go to Implementation")
  keymap("gT", vim.lsp.buf.type_definition, "LSP Go to Type")
  keymap("gd", vim.lsp.buf.definition, "LSP Go to Definition")
  keymap("gj", vim.diagnostic.goto_next, "LSP Next Issue")
  keymap("gk", vim.diagnostic.goto_prev, "LSP Previous Issue")
  keymap("gs", vim.lsp.buf.signature_help, "LSP Symbol Info")
  keymap("qf", vim.lsp.buf.code_action, "LSP QuickFix issue")
  keymap("<leader>wd", "<cmd>Telescope lsp_document_symbols<CR>", "LSP Show Symbols")
  keymap("<leader>rn", vim.lsp.buf.rename, "LSP Rename Symbol")
  keymap("<leader>dr", "<cmd>Telescope lsp_references<CR>")
  keymap("<leader>dd", "<cmd>Telescope diagnostics<CR>", "LSP List of Issues")

  -- typescript specific keymaps (e.g. rename file and update imports)
  if client.name == "tsserver" then
    keymap("qfa", "<cmd>TypescriptFixAll<CR>", "LSP Fix All Issues")
    keymap("<leader>rf", "<cmd>TypescriptRenameFile<CR>", "LSP Rename file and update imports")
    keymap("<leader>oi", "<cmd>TypescriptOrganizeImports<CR>", "LSP Organize imports")
    keymap("<leader>ru", "<cmd>TypescriptRemoveUnused<CR>", "LSP remove unused variables")
  end
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
