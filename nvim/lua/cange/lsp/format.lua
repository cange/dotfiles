---@type CangeLsp.Format
local M = {}

local ns = "cange.lsp.format"
M.autoformat = Cange.get_config("lsp.format_on_save") or false

local function toggle()
  M.autoformat = not M.autoformat
  local label = M.autoformat and "ENABLED" or "DISABLED"
  Cange.log_info(label .. " format on save", ns)
end

function M.format()
  local nls = require("null-ls")
  local nls_src = require("null-ls.sources")
  local available_formatters = nls_src.get_available(vim.bo.filetype, nls.methods.FORMATTING)

  Cange.log_info("Auto format", ns)

  vim.lsp.buf.format({
    async = true,
    bufnr = vim.api.nvim_get_current_buf(),
    timeout_ms = 10000,
    filter = function(client)
      if #available_formatters > 0 then
        return client.name == "null-ls"
      end
      return client.supports_method("textDocument/formatting")
    end,
  })
end

---Auto formats codebase on save if format toggle is active
---@param bufnr number
function M.attach(bufnr)
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    group = vim.api.nvim_create_augroup("cange_lsp_auto_format", { clear = true }),
    callback = function()
      if M.autoformat then
        M.format()
      end
    end,
  })
end

-- Allows to enable/disable auto formatting on save within a session
vim.api.nvim_create_user_command("LspToggleFormatOnSave", toggle, {})

return M
