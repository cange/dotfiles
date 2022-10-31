local ns = "[cange.lsp.auto_format]"
local function notify(msg, level)
  level = level or vim.log.levels.INFO
  vim.notify(msg, level, {
    title = ns,
  })
end
local found_utils, utils = pcall(require, "cange.utils")
if not found_utils then
  print(ns, '"cange.utils" not found')
  return
end

---@class cange.lsp.AutoFormat
---@field group_name string Handle name for auto group
---@field is_active boolean Formatting is enabled if true
---@field bufnr (nil|integer) Identifier of the current used buffer or nil if not taken

local M = {
  bufnr = nil,
  is_active = utils.get_config("lsp.format_on_save") or false,
  group_name = "cange_lsp_auto_format",
}

---@private
---Enables active flag
function M.enable()
  M.is_active = true
  M.on_save()
  notify("Enabled auto format on save")
end

---@private
---Disables active flag
function M.disable()
  M.is_active = false
  local found_command, _ = pcall(vim.api.nvim_get_autocmds, { group = M.group_name })
  if not found_command then
    return
  end

  vim.api.nvim_del_augroup_by_name(M.group_name)
  notify("Disabled auto format on save")
end

---Auto formats codebase on save if format toggle is active
---@param bufnr? integer Identifier of buffer what should be formatted
function M.on_save(bufnr)
  if M.is_active == false then
    return
  end
  M.bufnr = bufnr or M.bufnr
  local group = vim.api.nvim_create_augroup(M.group_name, { clear = true })

  vim.api.nvim_clear_autocmds({ group = group, buffer = M.bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    buffer = M.bufnr,
    callback = function()
      vim.lsp.buf.format({
        filter = function(client)
          return client.name == "null-ls"
        end,
        bufnr = M.bufnr,
        async = false, -- wait until done and save then
      })
    end,
  })
end

---Allows to enable/disable auto formatting on save within a session
vim.api.nvim_create_user_command("CangeLSPToggleAutoFormat", function()
  if M.is_active then
    M.disable()
  else
    M.enable()
  end
end, {})

return M
