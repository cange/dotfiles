local ok, telescope = pcall(require, 'telescope')
if not ok then return end

-- local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local keymap = vim.keymap.set
local picker_opts = {
  theme = 'dropdown',
  previewer = false,
}
telescope.setup({
  defaults = {
    mappings = {
      i = {
        ['<C-n>'] = actions.cycle_history_next,
        ['<C-p>'] = actions.cycle_history_prev,
      },
    },
  },
  pickers = {
    find_files = picker_opts,
    grep_string = picker_opts,
  }
})

keymap('n', '<leader>p', function() builtin.find_files() end)
keymap('n', '<leader>h', function() builtin.help_tags() end)
keymap('n', '<leader>lv', function() builtin.live_grep() end)
keymap('n', '<leader>gs', function() builtin.grep_string() end)
keymap('n', '<leader>g', function() builtin.git_commits() end)

-- extension: file browser
local function buffer_dir()
  return vim.fn.expand('%:p:h')
end

telescope.load_extension('file_browser')
keymap('n', '<leader>s', function()
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
