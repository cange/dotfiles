local ns = "[cange.lsp.lspconfig]"
local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_ok then
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

  -- See `:help K` for why this keymap
  keymap("K", vim.lsp.buf.hover, "Hover symbol info")
  keymap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
  -- NOTE: more keys defined in `cange/keymaps.lua`
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
  local ok, config = pcall(require, "cange.lsp.server_configurations." .. server_name)
  if ok then
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
    virtual_text = Cange.get_config("lsp.diagnostic_virtual_text"),
  })
end

return M
