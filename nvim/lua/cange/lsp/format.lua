--#region Types

---@class LspFormatOptions
---@field async? boolean
---@field timeout_ms? integer

--#endregion

local M = {}

local ns = "cange.lsp.format"
local format_on_save = Cange.get_config("lsp.format_on_save")

-- Allows to enable/disable auto formatting on save within a session
function M.toggle_format_on_save()
  format_on_save = not format_on_save
  Cange.set_config("lsp.format_on_save", format_on_save)
  local label = format_on_save and "ENABLED" or "DISABLED"
  Log:info(label .. " format on save", ns)
end

---@param opts? LspFormatOptions
function M.format(opts)
  opts = opts or {}
  local nls = require("null-ls")
  local nls_src = require("null-ls.sources")
  local available_formatters = nls_src.get_available(vim.bo.filetype, nls.methods.FORMATTING)

  Log:info("Auto format", ns)

  vim.lsp.buf.format({
    async = opts.async == nil or true and opts.async,
    bufnr = vim.api.nvim_get_current_buf(),
    timeout_ms = opts.timeout_ms or 10000,
    filter = function(client)
      if #available_formatters > 0 then return client.name == "null-ls" end
      return client.supports_method("textDocument/formatting")
    end,
  })
end

---Auto formats codebase on save if format toggle is active
---@param bufnr number
function M.attach(client, bufnr)
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    buffer = bufnr,
    group = vim.api.nvim_create_augroup("cange_lsp_auto_format", { clear = true }),
    desc = "Auto format",
    callback = function()
      format_on_save = Cange.get_config("lsp.format_on_save")
      if not format_on_save then return end
      if client.name == "eslint" then
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint
        vim.cmd("EslintFixAll")
      else
        M.format({ async = false })
      end
    end,
  })
end

return M
