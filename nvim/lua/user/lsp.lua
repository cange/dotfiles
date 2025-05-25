local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_ok then error('"cmp_nvim_lsp" not found') end

local M = {}

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

M._diagnostics = { virtual_types = { TEXT = "virtual_text", LINE = "virtual_lines" } }

local function toggle_diagnostics_virtual_type()
  local types = M._diagnostics.virtual_types
  local current_type = vim.g.user_diagnostics_virtual_type or User.get_config("lsp.diagnostics.virtual_type")
  local new_state = current_type ~= types.TEXT and types.TEXT or types.LINE
  Notify.info(new_state, { title = "Change diagnostic inline text" })
  vim.g.user_diagnostics_virtual_type = new_state
  require("user.lsp").update_diagnostics()
end

local function lsp_restart_all()
  local bufnr = vim.api.nvim_get_current_buf()
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    local blacklist = { "copilot" }
    if client.attached_buffers[bufnr] and not vim.tbl_contains(blacklist, client.name) then
      vim.cmd("LspRestart " .. client.name)
    end
  end
end

-- stylua: ignore start
M.keymaps = {
  { "<Leader>e4", "<cmd>LspInfo<CR>",                desc = "LSP info"  },
  { "<Leader>,l", toggle_format_on_save,             desc = "Toggle Format on Save"  },
  { "<Leader>tc", toggle_diagnostics_virtual_type,   desc = "Toggle diagnostic inline text"  },
  {
    "<Leader>ci",
    function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 })) end,
    desc = "Toggle inlay hints",
  },

  { "gd", "<cmd>Telescope lsp_definitions<CR>",       desc = "Go to Definition" },
  { "gD", vim.lsp.buf.declaration,                    desc = "Go to Declaration" },
  { "gR", lsp_restart_all,                            desc = "Restart all LSP Clients"  },

  -- default overrides
  { "grn", vim.lsp.buf.rename,                        desc = "Rename Symbol" },
  { "gra", vim.lsp.buf.code_action,                   desc = "Code Actions" },
  { "grr", "<cmd>Telescope lsp_references<CR>",       desc = "Find All References" },
  { "gri", "<cmd>Telescope lsp_implementations<CR>",  desc = "Find Implementation" },
  { "gO",  "<cmd>Telescope lsp_document_symbols<CR>", desc = "Lists all symbols" },
  { "<C-s>", vim.lsp.buf.signature_help,              desc = "Show signature" },
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
