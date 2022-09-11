local found_lualine, lualine = pcall(require, 'lualine')
if not found_lualine then return end

local found_auto_session, auto_session = pcall(require, 'auto-session-library')
  if not found_auto_session then
  vim.notify('lualine: "auto-session-library" could not be found')
  return
end

lualine.setup({
  sections = {
    lualine_c = { auto_session.current_session_name }
  }
})
