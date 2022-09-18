local M = {}

local action_state = require('telescope.actions.state')
local builtin = require('telescope.builtin')
local icons = require('cange.icons')
--[[
lua require('plenary.reload').reload_module("my_user.tele")
nnoremap <leader>en <cmd>lua require('my_user.tele').edit_neovim()<CR>
--]]
function M.find_neovim()
  local opts_with_preview, opts_without_preview

  opts_with_preview = {
    prompt_title = icons.ui.Gear .. ' NeoVim Config',
    shorten_path = false,
    cwd = '~/.config/nvim',

    -- layout_strategy = 'flex',
    layout_config = {
      prompt_position = 'top',
      horizontal = {
        width = { padding = 0.15 },
      },
    },

    mappings = {
      i = {
        ['<C-y>'] = false,
      },
    },

    attach_mappings = function(_, map)
      map('i', '<c-y>', set_prompt_to_entry_value)
      map('i', '<M-c>', function(prompt_bufnr)
        actions.close(prompt_bufnr)
        vim.schedule(function()
          builtin.find_files(opts_without_preview)
        end)
      end)

      return true
    end,
  }

  opts_without_preview = vim.deepcopy(opts_with_preview)
  opts_without_preview.previewer = false

  builtin.find_files(opts_with_preview)
end

-- File browser
function M.file_browser()
  local file_browser = telescope.load_extension('file_browser')
  local opts

  opts = {
    sorting_strategy = 'ascending',
    scroll_strategy = 'cycle',
    layout_config = {
      prompt_position = 'top',
    },

    attach_mappings = function(prompt_bufnr, map)
      local current_picker = action_state.get_current_picker(prompt_bufnr)

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
        local entry = action_state.get_selected_entry()
        vim.fn.setreg('+', entry.value)
      end)

      return true
    end,
  }

  require('telescope').extensions.file_browser.file_browser(opts)
end

function M.find_workspace()
  builtin.find_files({
    shorten_path = false,
    cwd = '~/workspace/',
    prompt = '~ workspace  ~',
    hidden = true,

    layout_strategy = 'horizontal',
    layout_config = {
      view_width = 0.55,
    },
  })
end

return M
