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
local code_icon = Cange.get_icon("ui.Code", { right = 1 })
M.show_diagnostic_virtual_text = Cange.get_config("lsp.diagnostic_virtual_text") or false
local telescope_builtin = function(method) require("telescope.builtin")[method]({ reuse_win = true }) end
-- stylua: ignore start
M.keymaps = {
  { "<leader>ca", vim.lsp.buf.code_action,                          desc = code_icon .. "Code Actions" },
  { "<leader>cd", require("cange.lsp.toggle").virtual_text,         desc = "Toggle Inline Virtual Text" },
  { "<leader>cr", "<cmd>LspRestart;<CR>",                           desc = "LSP Restart" },
  { "<leader>e4", "<cmd>LspInfo<CR>",                               desc = "LSP info" },
  { "<leader>el", require("cange.lsp.toggle").format_on_save,       desc = "Toggle Format on Save" },
  { "<leader>r", vim.lsp.buf.rename,                                desc = code_icon .. "Rename Symbol" },
  { "[d", vim.diagnostic.goto_prev,                                 desc = code_icon .. "Prev Diagnostic" },
  { "]d", vim.diagnostic.goto_next,                                 desc = code_icon .. "Next Diagnostic" },
  { "gD", "<cmd>Telescope lsp_type_definitions<CR>",                desc = code_icon .. "Find Type Definition" },
  { "gD", vim.lsp.buf.declaration,                                  desc = code_icon .. "Go to Symbol Declaration" },
  { "gI", function() telescope_builtin('lsp_implementations') end,  desc = code_icon .. "Find Implementation" },
  { "gd", vim.lsp.buf.definition,                                   desc = code_icon .. "Go to Definition" },
  { "gi", vim.lsp.buf.implementation,                               desc = code_icon .. "Go to Implementation" },
  { "gr", "<cmd>Telescope lsp_references<CR>",                      desc = code_icon .. "Find All References" },
  { "gs", "<cmd>Telescope lsp_document_symbols<CR>",                desc = code_icon .. "Find Symbol in current buffer" },
  { "gy", function() telescope_builtin('lsp_type_definitions') end, desc = code_icon .. "Find Type Definition" },
  { "<C-k>", vim.lsp.buf.signature_help,                            desc = code_icon .. "LSP Signature Documentation" },
}
-- stylua: ignore end

M.server_config = {
  on_attach = function(_, bufnr)
    -- enable formatting for ranges
    vim.api.nvim_set_option_value("formatexpr", "v:lua.vim.lsp.formatexpr()", { buf = bufnr })

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
