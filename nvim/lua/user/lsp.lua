local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_ok then error('"cmp_nvim_lsp" not found') end

---@return table
local function capabilities()
  local caps = cmp_nvim_lsp.default_capabilities()
  caps.textDocument.completion.completionItem.snippetSupport = true

  return caps
end

local function toggle_format_on_save()
  local new_state = not User.get_config("lsp.format_on_save")
  Notify.info(new_state and "enabled" or "disabled", { title = "Auto format on save" })
  User.set_config("lsp.format_on_save", new_state)
  require("user.lsp").update_format_on_save()
end

local M = {}

-- stylua: ignore start
M.keymaps = {
  { "<leader>ca", vim.lsp.buf.code_action,                          desc = "Code Actions" },
  { "<leader>cr", "<cmd>LspRestart;<CR>",                           desc = "LSP Restart"  },
  { "<leader>e4", "<cmd>LspInfo<CR>",                               desc = "LSP info"  },
  { "<leader>,l", toggle_format_on_save,                            desc = "Toggle Format on Save"  },
  { "<leader>r", vim.lsp.buf.rename,                                desc = "Rename Symbol" },
  {
    "<leader>ci",
    function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 })) end,
    desc = "Toggle inlay hints",
  },

  { "gd", "<cmd>Telescope lsp_definitions<CR>",                     desc = "Go to Definition" },
  { "gD", vim.lsp.buf.declaration,                                  desc = "Go to Declaration" },
  { "gI",  "<cmd>Telescope lsp_implementations<CR>",                desc = "Find Implementation" },

  -- default overrides
  { "gO", "<cmd>Telescope lsp_document_symbols<CR>",                desc = "Find Symbol in current buffer" },
  { "grr", "<cmd>Telescope lsp_references<CR>",                     desc = "Find All References" },
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

function M.update_diagnostics()
  vim.diagnostic.config({
    float = {
      source = "if_many", -- Or "always"
    },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = Icon.diagnostics.Error,
        [vim.diagnostic.severity.HINT] = Icon.diagnostics.Hint,
        [vim.diagnostic.severity.WARN] = Icon.diagnostics.Warn,
        [vim.diagnostic.severity.INFO] = Icon.diagnostics.Info,
      },
    },
    virtual_text = { current_line = true },
  })
end

function M.update_format_on_save()
  local ok, conform = pcall(require, "conform")
  if not ok then return end
  local opts = { format_on_save = nil }
  if User.get_config("lsp.format_on_save") then
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
