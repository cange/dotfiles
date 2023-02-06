local ns = "[cange.lsp.auto_format]"

---@class Cange.lsp.AutoFormatToggle
---@field group_name string Handle name for auto group
---@field is_active boolean Formatting is enabled if true

---@type Cange.lsp.AutoFormatToggle
local m = {}

m.is_active = Cange.get_config("lsp.format_on_save") or false
m.group_name = "cange_lsp_auto_format"

---Enables active flag
local function auto_format_on()
  m.is_active = true
  Cange.log.info("On save is ON", ns)
end

---Disables active flag
local function auto_format_off()
  m.is_active = false
  local found_command, _ = pcall(vim.api.nvim_get_autocmds, { group = m.group_name })
  if not found_command then
    return
  end

  vim.api.nvim_del_augroup_by_name(m.group_name)
  Cange.log.info("On save is OFF", ns)
end

---Auto formats codebase on save if format toggle is active
---@param bufnr? integer|nil Identifier of buffer what should be formatted
function m.on_save(bufnr)
  bufnr = bufnr or nil

  local group = vim.api.nvim_create_augroup(m.group_name, { clear = true })
  vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    group = group,
    callback = function()
      if m.is_active == false then
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
  if m.is_active then
    auto_format_off()
  else
    auto_format_on()
  end
  -- apply state
  Cange.reload("cange.lsp")
end, {})

return m
