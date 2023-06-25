local ns = "[cange.lsp.lspconfig]"
local found_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not found_cmp then
  print(ns, '"cmp_nvim_lsp" not found')
  return
end

local function keymaps(client, bufnr)
  -- Use LSP as the handler for formatexpr.
  vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
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

  keymap("<leader>rn", vim.lsp.buf.rename, "Rename")

  -- See `:help K` for why this keymap
  keymap("K", vim.lsp.buf.hover, "Hover Documentation")
  keymap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- typescript specific keymaps (e.g. rename file and update imports)
  if client.name == "tsserver" then
    Log:info("ENABLED keymaps for JS/TS ", ns)
    keymap("<leader>fa", "<cmd>TypescriptFixAll<CR>", "LSP Fix All Issues")
    keymap("<leader>rf", "<cmd>TypescriptRenameFile<CR>", "LSP Rename file and update imports")
    keymap("<leader>oi", "<cmd>TypescriptOrganizeImports<CR>", "LSP Organize imports")
    keymap("<leader>ru", "<cmd>TypescriptRemoveUnused<CR>", "LSP remove unused variables")
  end
end

local M = {}

M.show_diagnostic_virtual_text = Cange.get_config("lsp.diagnostic_virtual_text") or false

local function capabilities()
  local caps = cmp_nvim_lsp.default_capabilities()
  caps.textDocument.completion.completionItem.snippetSupport = true

  return caps
end

---Keymapping for lspconfig on_attach options
---@param client table
---@param bufnr integer
local function on_attach(client, bufnr)
  keymaps(client, bufnr)
  require("cange.lsp.format").attach(client, bufnr)
end

local default_config = {
  on_attach = on_attach,
  capabilities = capabilities(),
}

---Sets up individual LSP server handler
---@param server_name string
function M.setup_handler(server_name)
  local found_config, config = pcall(require, "cange.lsp.server_configurations." .. server_name)
  if found_config then
    config = vim.tbl_deep_extend("force", vim.deepcopy(default_config), config)
  else
    config = default_config
  end

  if server_name == "tsserver" then
    -- Enable LSP for TypeScript/JS
    -- https://github.com/jose-elias-alvarez/typescript.nvim#setup
    require("typescript").setup({ server = config })
  else
    require("lspconfig")[server_name].setup(config)
  end
end

---@return table
local function define_sign_icons()
  local signs = {}
  ---@diagnostic disable-next-line: param-type-mismatch
  for type, icon in pairs(Cange.get_icon("diagnostics")) do
    local hl = "DiagnosticSign" .. type
    table.insert(signs, { name = hl, text = icon })
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
  return signs
end

function M.setup_diagnostics()
  vim.diagnostic.config({
    float = {
      source = "if_many", -- Or "always"
    },
    signs = {
      active = define_sign_icons(),
    },
    virtual_text = M.show_diagnostic_virtual_text,
  })
end

function M.toggle_virtual_text()
  M.show_diagnostic_virtual_text = not M.show_diagnostic_virtual_text
  local label = M.show_diagnostic_virtual_text and "ENABLED" or "DISABLED"

  vim.diagnostic.config({ virtual_text = M.show_diagnostic_virtual_text })
  Log:info(label .. " virtual inline text", "Diagnostic")
end

return M
