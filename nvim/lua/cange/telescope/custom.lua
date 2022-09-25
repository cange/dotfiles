local found_telescope, _ = pcall(require, 'telescope')
if not found_telescope then
  print('[telescope.custom] "telescope" not found')
  return
end
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')
local actions_state = require('telescope.actions.state')
local found_icons, icons = pcall(require, 'cange.icons')
if not found_icons then
  print('[icons.custom] "cange.icons" not found')
  return
end

local M = {}

function M.browse_nvim()
  builtin.find_files({
    cwd = '~/.config/nvim',
    previewer = false,
    prompt_title = icons.ui.Gear .. ' NeoVim Config',
    shorten_path = false,
  })
end

function M.diagnostics_log()
  builtin.diagnostics(themes.get_ivy({
    bufnr = 0,
    initial_mode = 'normal',
    no_listed = true, -- if true show only listed buffersw
    previewer = false,
    prompt_title = icons.misc.Stethoscope .. ' Diagnostics Log',
  }))
end

function M.browse_workspace()
  builtin.find_files({
    cwd = '~/workspace/',
    hidden = true,
    prompt_title = icons.misc.Workspace .. ' Workspace',
    shorten_path = false,
  })
end

-- File browser
function M.file_browser()
  local path = '%:p:h'
  local opts = {
    cwd = vim.fn.expand(path),
    path = path,
    sorting_strategy = 'ascending',
    scroll_strategy = 'cycle',
    layout_config = {
      prompt_position = 'top',
    },
    attach_mappings = function(_, map)
      map('n', 'yy', function()
        vim.fn.setreg('+', entry.value)
      end)

      return true
    end,
  }

  require('telescope').extensions.file_browser.file_browser(opts)
end

return M
