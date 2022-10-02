local ns = 'cange.lualine.init'
local found_lualine, lualine = pcall(require, 'lualine')
if not found_lualine then
  return
end
local found_icons, icons = pcall(require, 'cange.utils.icons')
if not found_icons then
  print('[' .. ns .. '] "cange.utils.icons" not found')
  return
end
-- config
lualine.setup({
  options = {
    component_separators = { left = '⏽', right = '⏽' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_b = {
      { 'branch', icon = icons.git.Repo },
      'diff',
      'diagnostics',
    },
    lualine_c = {
      {
        'filename',
        path = 1, -- 1: Relative path
        symbols = icons.lualine,
      },
    },
    lualine_x = { 'filetype' },
    lualine_y = { 'encoding' },
    lualine_z = {
      'progress',
      'location',
    },
  },
})
