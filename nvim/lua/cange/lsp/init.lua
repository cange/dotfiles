local ns = "cange.lsp.lspconfig"
local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_ok then
  print(ns, '"cmp_nvim_lsp" not found')
  return
end

---@return table
local function capabilities()
  local caps = cmp_nvim_lsp.default_capabilities()
  caps.textDocument.completion.completionItem.snippetSupport = true

  return caps
end

local M = {}

M.show_diagnostic_virtual_text = Cange.get_config("lsp.diagnostic_virtual_text") or false

-- stylua: ignore start
M.keymaps = {
  { "<leader>ca", vim.lsp.buf.code_action,                                desc = "Code actions/Quickfixes" },
  { "<leader>cd", "<cmd>lua R('cange.lsp.toggle').virtual_text()<CR>",    desc = "Toggle inline virtual text" },
  { "<leader>cr", "<cmd>LspRestart;<CR>",                                 desc = "LSP Restart" },
  { "<leader>e4", "<cmd>LspInfo<CR>",                                     desc = "LSP info" },
  { "<leader>el", "<cmd>lua R('cange.lsp.toggle').format_on_save()<CR>",  desc = "Toggle format on save" },
  { "<leader>r", vim.lsp.buf.rename,                                      desc = "LSP Rename symbol" },
  { "[d", vim.diagnostic.goto_prev,                                       desc = "Prev Diagnostic" },
  { "]d", vim.diagnostic.goto_next,                                       desc = "Next Diagnostic" },
  { "gD", vim.lsp.buf.declaration,                                        desc = "LSP Goto symbol Declaration" },
  { "gI", '<cmd>lua R("telescope.builtin").lsp_implementations({ reuse_win = true })<CR>', desc = "Goto Implementation" },
  { "gd", vim.lsp.buf.definition,                                         desc = "LSP Goto symbol Definition" },
  { "gi", vim.lsp.buf.implementation,                                     desc = "LSP List symbol Implementation" },
  { "gr", "<cmd>Telescope lsp_references<CR>",                            desc = "LSP Symbol References" },
  { "gy", '<cmd>lua R("telescope.builtin").lsp_type_definitions({ reuse_win = true })<CR>', desc = "LSP Goto Type Definition" },
  { "K", vim.lsp.buf.hover,                                               desc = "LSP Hover symbol info" },
  { "<C-k>", vim.lsp.buf.signature_help,                                  desc = "LSP Signature Documentation" },
}
-- stylua: ignore end

M.server_config = {
  on_attach = function(_, bufnr)
    -- enable formatting for ranges
    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")

    for _, keys in pairs(M.keymaps) do
      vim.keymap.set("n", keys[1], keys[2], { desc = keys.desc, noremap = true, silent = true, buffer = bufnr })
    end
  end,
  capabilities = capabilities(),
}

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

function M.update_diagnostics()
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

function M.update_format_on_save()
  local ok, conform = pcall(require, "conform")
  if not ok then return end
  local opts = { format_on_save = nil }
  if Cange.get_config("lsp.format_on_save") then
    opts = {
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 1000,
      },
    }
  end
  conform.setup(opts)
end

return M
