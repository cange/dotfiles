local ns = "[cange.lsp.utils]"
local found_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not found_cmp then
  print(ns, '"cmp_nvim_lsp" not found')
  return
end

local function on_attach_keymaps(client, bufnr)
  -- Use LSP as the handler for formatexpr.
  vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
  local format = require("cange.lsp.format").format
  ---Preconfigured keymap
  ---@param lhs string
  ---@param rhs string|function
  ---@param desc? string
  local function keymap(lhs, rhs, desc)
    local mode = "n"

    desc = desc and "LSP: " .. desc or ""
    local opts = { desc = desc, noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set(mode, lhs, rhs, opts)
  end

  keymap("gd", vim.lsp.buf.definition, "Goto Definition")
  keymap("gr", "<cmd>Telescope lsp_references<CR>", "Goto References")
  keymap("gI", vim.lsp.buf.implementation, "Goto Implementation")
  keymap("gD", vim.lsp.buf.declaration, "Goto Declaration")
  keymap("gT", vim.lsp.buf.type_definition, "Go to Type")
  keymap("gj", vim.diagnostic.goto_next, "Next Issue")
  keymap("gk", vim.diagnostic.goto_prev, "Previous Issue")
  keymap("gs", vim.lsp.buf.signature_help, "Symbol Info")
  keymap("qf", vim.lsp.buf.code_action, "Quick Fix")
  keymap("<leader>rn", vim.lsp.buf.rename, "Rename")
  keymap("<leader>ds", "<cmd>Telescope lsp_document_symbols", "Document Symbols")
  keymap("<leader>ds", "<cmd>Telescope diagnostics<CR>", "LSP List of Issues")

  -- Lesser used LSP functionality
  keymap("<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace Add Folder")
  keymap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder")
  keymap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")

  -- See `:help K` for why this keymap
  keymap("K", vim.lsp.buf.hover, "Hover Documentation")
  keymap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- typescript specific keymaps (e.g. rename file and update imports)
  if client.name == "tsserver" then
    print('keymaps: for js')
    keymap("qfa", "<cmd>TypescriptFixAll<CR>", "LSP Fix All Issues")
    keymap("<leader>rf", "<cmd>TypescriptRenameFile<CR>", "LSP Rename file and update imports")
    keymap("<leader>oi", "<cmd>TypescriptOrganizeImports<CR>", "LSP Organize imports")
    keymap("<leader>ru", "<cmd>TypescriptRemoveUnused<CR>", "LSP remove unused variables")
  end
end

---@class Cange.lsp.Utils

---@type Cange.lsp.Utils
local m = {}

function m.capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  return capabilities
end

---Keymapping for lspconfig on_attach options
---@param client table
---@param bufnr integer buffer
function m.on_attach(client, bufnr)
  local navic_ok, navic = pcall(require, "nvim-navic")
  if navic_ok and client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
  on_attach_keymaps(client, bufnr)
  require("cange.lsp.format").on_attach(client, bufnr)
end

return m
