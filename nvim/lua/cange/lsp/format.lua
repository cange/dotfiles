---@class Cange.lsp.Format

---@type Cange.lsp.Format
local m = {}

local ns = "cange.lsp.format"
m.autoformat = Cange.get_config("lsp.format_on_save") or false

local function toggle()
  m.autoformat = not m.autoformat
  local label = m.autoformat and "ENABLED" or "DISABLED"
  Cange.log.info(label .. " format on save", ns)
end

function m.format()
  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.bo[buf].filetype
  local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 1

  Cange.log.info('Auto format', ns)

  vim.lsp.buf.format({
    timeout_ms = 10000,
    async = false, -- wait until done and save then    bufnr = buf,
    filter = function(client)
      -- stylua: ignore
      if have_nls then return client.name == "null-ls" end
      return client.name ~= "null-ls"
    end,
  })
end

---Auto formats codebase on save if format toggle is active
---@param client table
---@param bufnr number
function m.on_attach(client, bufnr)
  -- stylua: ignore
  if not client.supports_method("textDocument/formatting") then return end

  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    group = vim.api.nvim_create_augroup("cange_lsp_auto_format", { clear = true }),
    callback = function()
      if m.autoformat then
        m.format()
      end
    end,
  })
end

-- Allows to enable/disable auto formatting on save within a session
vim.api.nvim_create_user_command("LspToggleFormatOnSave", toggle, {})

return m
