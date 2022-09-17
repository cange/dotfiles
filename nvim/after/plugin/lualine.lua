local found_lualine, lualine = pcall(require, 'lualine')
if not found_lualine then
  return
end

local found_icons, icons = pcall(require, 'cange.icons')
if not found_icons then
  print('[lualine] "cange.icons" not found')
  return
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
    },
  },
})
