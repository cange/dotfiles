local found, telescope = pcall(require, 'telescope')
if not found then
  return
end

local actions = require('telescope.actions')
local keymap_opts = { noremap = true, silent = true }
local picker_opts = {
  theme = 'dropdown',
  previewer = false,
}
telescope.setup({
  defaults = {
    path_display = {
      'shorten',
      'absolute',
    },
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
  },
})

-- File browser
local file_browser = telescope.load_extension('file_browser')

local function browse_files()
  local function buffer_dir()
    return vim.fn.expand('%:p:h')
  end

  file_browser.file_browser({
    theme = 'dropdown',
    hijack_netrw = true, -- true disables netrw and uses the file browser here
    hidden = true, -- show hidden files when this is true
    cwd = buffer_dir(),
    grouped = true,
    path = '%:p:h',
    respect_gitignore = false,
  })
end

--
-- additional keybindings assignment
--
vim.keymap.set('n', 'fb', browse_files, keymap_opts)
