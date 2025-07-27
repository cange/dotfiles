local M = {}

M._diagnostics = { virtual_types = { TEXT = "virtual_text", LINE = "virtual_lines" } }

local function toggle_diagnostics_virtual_type()
  local types = M._diagnostics.virtual_types
  local current_type = vim.g.user_diagnostics_virtual_type or User.get_config("lsp.diagnostics.virtual_type")
  local new_state = current_type ~= types.TEXT and types.TEXT or types.LINE
  Notify.info(new_state, { title = "Change diagnostic inline text" })
  vim.g.user_diagnostics_virtual_type = new_state
  require("user.lsp").update_diagnostics()
end

local function restart_all_clients()
  local bufnr = vim.api.nvim_get_current_buf()
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    local blacklist = { "copilot" }
    if client.attached_buffers[bufnr] and not vim.tbl_contains(blacklist, client.name) then
      vim.cmd("LspRestart " .. client.name)
    end
  end
end

function M.set_keymaps()
  -- stylua: ignore start
  local keymaps = {
    { "<Leader>e4", "<cmd>LspInfo<CR>",                desc = "LSP info"  },
    { "<Leader>dD", toggle_diagnostics_virtual_type,   desc = "[diag] Toggle type"  },
    {
      "<Leader>di",
      function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 })) end,
      desc = "Toggle inlay hints",
    },

    { "gd", "<cmd>Telescope lsp_definitions<CR>",       desc = "Go to Definition" },
    { "gD", vim.lsp.buf.declaration,                    desc = "Go to Declaration" },
    { "gR", restart_all_clients,                        desc = "Restart all LSP Clients"  },

    -- default overrides
    { "grn", vim.lsp.buf.rename,                        desc = "Rename Symbol" },
    { "gra", vim.lsp.buf.code_action,                   desc = "Code Actions" },
    { "grr", "<cmd>Telescope lsp_references<CR>",       desc = "Find All References" },
    { "gri", "<cmd>Telescope lsp_implementations<CR>",  desc = "Find Implementation" },
    { "gO",  "<cmd>Telescope lsp_document_symbols<CR>", desc = "Lists all symbols" },
    { "<C-s>", vim.lsp.buf.signature_help,              desc = "Show signature" },
  }
  -- stylua: ignore end

  for _, keys in pairs(keymaps) do
    vim.keymap.set("n", keys[1], keys[2], { desc = keys.desc, noremap = true, silent = true, buffer = bufnr })
  end
end

function M.update_diagnostics()
  local type = M._diagnostics.virtual_types
  vim.g.user_diagnostics_virtual_type = vim.g.user_diagnostics_virtual_type
    or User.get_config("lsp.diagnostics.virtual_type")
  local virtual_type = vim.g.user_diagnostics_virtual_type

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
    virtual_text = virtual_type == type.TEXT and { current_line = true } or false,
    virtual_lines = virtual_type ~= type.TEXT,
  })
end

return M
