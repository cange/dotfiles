local ok, telescope = pcall(require, 'telescope')
if not ok then return end

-- local actions = require('telescope.actions')
local themes = require('telescope.themes')
local map = vim.keymap.set
telescope.setup()

local builtin = require('telescope.builtin')

map('n', '<leader>p', function() builtin.find_files({
    theme = 'dropdown',
    hidden = true,
  })
end)

map('n', '<leader>f', function() builtin.grep_string() end)

map('n', '<leader>g', function()
  themes.get_cursor()
  builtin.git_files()
end)

map('n', '<leader>h', function() builtin.help_tags() end)
map('n', '<leader>r', function() builtin.resume() end)
map('n', '<leader>f', function() builtin.live_grep() end)

-- extension: file browser
local function buffer_dir()
  return vim.fn.expand('%:p:h')
end

telescope.load_extension('file_browser')
map('n', '<leader>s', function()
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
