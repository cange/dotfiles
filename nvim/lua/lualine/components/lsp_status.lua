local M = require("lualine.component"):extend()
local active = Cange.get_icon("ui.Eye") .. " LSP"
local inactive = Cange.get_icon("ui.EyeClosed") .. " LSP"
local blacklist = { "null-ls", "copilot" }
local label = inactive
local state = inactive
local old_ft = nil

function M:update_status()
  if not rawget(vim, "lsp") then return inactive end

  local new_ft = vim.fn.expand("%:e")
  -- PERF: avoid redundant detection when same filetype and is already active
  if old_ft == new_ft and state ~= inactive then return label end
  old_ft = new_ft

  for _, client in ipairs(vim.lsp.get_active_clients()) do
    local blacklisted = vim.tbl_contains(blacklist, client.name)
    if client.attached_buffers[vim.api.nvim_get_current_buf()] and not blacklisted then
      label = (vim.o.columns > 100 and "%#St_LspStatus#" .. active .. ": " .. client.name) or active
      state = active
      goto continue
    else
      label = inactive
    end
  end
  ::continue::
  return label
end

return M
