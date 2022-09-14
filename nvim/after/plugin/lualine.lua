local found_lualine, lualine = pcall(require, 'lualine')
if not found_lualine then
  return
end

local found_auto_session, auto_session = pcall(require, 'auto-session-library')
if not found_auto_session then
  vim.notify('lualine: "auto-session-library" could not be found')
  return
end

local current_sections = lualine.get_config().sections
local theme = lualine.get_config().options.theme

local found_theme, theme_palette = pcall(require, 'nightfox.palette')
if found_theme then
  local color = theme_palette.load(vim.g.colors_name)
  -- vim.pretty_print(color.green)
  -- vim.pretty_print(vim.tbl_keys(color))
  theme = {
    normal = {
      a = { bg = color.bg4, fg = color.fg2, gui = 'bold' },
      b = { bg = color.bg3, fg = color.fg0 },
      c = { bg = color.bg0, fg = color.fg1 },
    },
    insert = {
      a = { bg = color.green.bright, fg = color.bg1, gui = 'bold' },
    },
    visual = {
      a = { bg = color.pink.bright, fg = color.bg1, gui = 'bold' },
    },
    replace = {
      a = { bg = color.red.base, fg = color.fg3, gui = 'bold' },
    },
    command = {
      a = { bg = color.yellow.base, fg = color.fg3, gui = 'bold' },
    },
    inactive = {
      a = { bg = color.bg1, fg = color.bg4, gui = 'bold' },
    },
  }
end
lualine.setup({
  sections = vim.tbl_extend('keep', current_sections, { lualine_d = { auto_session.current_session_name } }),
  options = {
    -- theme = vim.tbl_extend('keep', theme, current_theme),
    theme = theme,
  },
})
