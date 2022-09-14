local found_lualine, lualine = pcall(require, 'lualine')
if not found_lualine then
  return
end

local found_icons, icons = pcall(require, 'cange.icons')
if not found_icons then
  vim.notify('lualine: "cange.icons" could not be found')
  return
end
local found_auto_session, auto_session = pcall(require, 'auto-session-library')
if not found_auto_session then
  vim.notify('lualine: "auto-session-library" could not be found')
  return
end

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
      b = { bg = color.green.dim, fg = color.b0 },
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
  sections = {
    lualine_c = {
      {
        'filename',
        -- file_status = true, -- Displays file status (readonly status, modified status)
        -- newfile_status = false, -- Display new file status (new file means no write after created)
        path = 1,
        -- 0: Just the filename
        -- 1: Relative path
        -- 2: Absolute path
        -- 3: Absolute path, with tilde as the home directory

        shorting_target = 40, -- Shortens path to leave 40 spaces in the window
        -- for other components. (terrible name, any suggestions?)
        symbols = icons.lualine,
      },
      -- lualine_d = { auto_session.current_session_name() },
    },
  },
  options = { theme = theme },
})
