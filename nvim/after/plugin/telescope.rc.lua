local loaded, telescope = pcall(require, 'telescope')

if (not loaded) then return end

-- local actions = require('telescope.actions')
local themes = require('telescope.themes')

telescope.setup()

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>p', function() builtin.find_files({
    theme = 'dropdown',
    no_ignore = false,
    hidden = true,
  })
end)

vim.keymap.set('n', '<leader>f', function() builtin.grep_string({
    theme = 'cursor',

  })
end)

vim.keymap.set('n', '<leader>g', function()
  themes.get_cursor()
  builtin.git_files()
end)

vim.keymap.set('n', '<leader>h', function() builtin.help_tags() end)
vim.keymap.set('n', '<leader>r', function() builtin.resume() end)

-- extension: file browser
local function buffer_dir()
  return vim.fn.expand('%:p:h')
end

telescope.load_extension('file_browser')
vim.keymap.set('n', '<leader>s', function()
  -- local fb_actions = require 'telescope'.extensions.file_browser.actions
  telescope.extensions.file_browser.file_browser({
    theme = 'ivy',
    -- disables netrw and use telescope-file-browser in its place
    hijack_netrw = true,
    mappings = {
      -- your custom insert mode mappings
      -- ['i'] = {},
      -- your custom normal mode mappings
      -- ['n'] = {},
    },
    path = '%:p:h',
    cwd = buffer_dir(),
    respect_gitignore = false,
    grouped = true,
  })
end)
