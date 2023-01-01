local ns = "[cange.lsp.auto_format]"

---@class LSPAutoFormatToggle
---@field group_name string Handle name for auto group
---@field is_active boolean Formatting is enabled if true

---@type LSPAutoFormatToggle
local M = {
  is_active = Cange.get_config("lsp.format_on_save") or false,
  group_name = "cange_lsp_auto_format",
}

---Enables active flag
local function auto_format_on()
  M.is_active = true
  vim.notify("On save is ON", vim.log.levels.INFO, { title = ns })
end

---Disables active flag
local function auto_format_off()
  M.is_active = false
  local found_command, _ = pcall(vim.api.nvim_get_autocmds, { group = M.group_name })
  if not found_command then
    return
  end

  vim.api.nvim_del_augroup_by_name(M.group_name)
  vim.notify("On save is OFF", vim.log.levels.INFO, { title = ns })
end

---Auto formats codebase on save if format toggle is active
---@param bufnr? integer|nil Identifier of buffer what should be formatted
function M.on_save(bufnr)
  bufnr = bufnr or nil

  local group = vim.api.nvim_create_augroup(M.group_name, { clear = true })
  vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    group = group,
    callback = function()
      if M.is_active == false then
        return
      end
      vim.lsp.buf.format({
        bufnr = bufnr,
        async = false, -- wait until done and save then
        timeout_ms = 10000,
      })
    end,
  })
end

---Allows to enable/disable auto formatting on save within a session
vim.api.nvim_create_user_command("LspToggleFormatOnSave", function()
  if M.is_active then
    auto_format_off()
  else
    auto_format_on()
  end
  -- apply state
  Cange.reload("cange.lsp")
end, {})

return M
