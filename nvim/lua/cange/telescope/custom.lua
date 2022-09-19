local telescope = BULK_LOADER('telescope', {
  { 'telescope.actions', 'actions' },
  { 'telescope.actions.state', 'actions_state' },
  { 'telescope.builtin', 'builtin' },
})
local utils = BULK_LOADER('telescope', { { 'cange.icons', 'icons' } })

local M = {}
--[[
lua require('plenary.reload').reload_module("my_user.tele")
nnoremap <leader>en <cmd>lua require('my_user.tele').edit_neovim()<CR>
--]]
function M.browse_nvim()
  telescope.builtin.find_files({
    cwd = '~/.config/nvim',
    previewer = false,
    prompt_title = utils.icons.ui.Gear .. ' NeoVim Config',
    shorten_path = false,
  })
end

function M.browse_workspace()
  telescope.builtin.find_files({
    cwd = '~/workspace/',
    hidden = true,
    prompt_title = utils.icons.misc.Workspace .. ' Workspace',
    shorten_path = false,
  })
end

-- File browser
function M.file_browser()
  local opts

  opts = {
    sorting_strategy = 'ascending',
    scroll_strategy = 'cycle',
    layout_config = {
      prompt_position = 'top',
    },

    attach_mappings = function(prompt_bufnr, map)
      local current_picker = telescope.actions_state.get_current_picker(prompt_bufnr)

      local modify_cwd = function(new_cwd)
        local finder = current_picker.finder

        finder.path = new_cwd
        finder.files = true
        current_picker:refresh(false, { reset_prompt = true })
      end

      map('i', '-', function()
        modify_cwd(current_picker.cwd .. '/..')
      end)

      map('i', '~', function()
        modify_cwd(vim.fn.expand('~'))
      end)

      map('n', 'yy', function()
        local entry = telescope.actions_state.get_selected_entry()
        vim.fn.setreg('+', entry.value)
      end)

      return true
    end,
  }

  require('telescope').extensions.file_browser.file_browser(opts)
end

return M
