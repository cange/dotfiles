local ns = "[cange.telescope]"
local found_telescope, telescope = pcall(require, "telescope")
if not found_telescope then
  print(ns, '"telescope" not found')
  return
end
local Path = require("plenary.path")
local action_set = require("telescope.actions.set")
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local conf = require("telescope.config").values
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")
local scan = require("plenary.scandir")
local themes = require("telescope.themes")
local transform_mod = require("telescope.actions.mt").transform_mod

-- config
local os_sep = Path.path.sep
local M = {}

---Keep track of the active extension and folders for `live_grep`
local live_grep_filters = {
  ---@type nil|string
  extension = nil,
  ---@type nil|string[]
  directories = nil,
}

---Run `live_grep` with the active filters (extension and folders)
local function run_live_grep(current_input)
  -- TODO: Resume old one with same options somehow
  require("telescope.builtin").live_grep({
    additional_args = live_grep_filters.extension and function()
      return { "-g", "*." .. live_grep_filters.extension }
    end,
    search_dirs = live_grep_filters.directories,
    default_text = current_input,
  })
end

-- Inspired by https://github.com/JoosepAlviste/dotfiles/blob/master/config/nvim/lua/j/plugins/telescope_custom_pickers.lua
M.actions = transform_mod({
  ---Ask for a file extension and open a new `live_grep` filtering by it
  set_extension = function(prompt_bufnr)
    local current_picker = action_state.get_current_picker(prompt_bufnr)
    local current_input = action_state.get_current_line()
    local input_ops = {
      completion = "file",
      default = "*.",
      prompt = "Include file type of: ",
    }

    vim.ui.input(input_ops, function(input)
      if input == nil then
        return
      end

      live_grep_filters.extension = input

      actions._close(prompt_bufnr, current_picker.initial_mode == "insert")
      run_live_grep(current_input)
    end)
  end,

  ---Ask the user for a folder and olen a new `live_grep` filtering by it
  set_folders = function(prompt_bufnr)
    local current_picker = action_state.get_current_picker(prompt_bufnr)
    local current_input = action_state.get_current_line()
    local data = {}

    scan.scan_dir(vim.loop.cwd(), {
      hidden = true,
      only_dirs = true,
      respect_gitignore = true,
      on_insert = function(entry)
        table.insert(data, entry .. os_sep)
      end,
    })
    table.insert(data, 1, "." .. os_sep)
    actions._close(prompt_bufnr, current_picker.initial_mode == "insert")
    pickers
      .new({}, {
        prompt_title = "Folders for Live Grep",
        finder = finders.new_table({ results = data, entry_maker = make_entry.gen_from_file({}) }),
        previewer = conf.file_previewer({}),
        sorter = conf.file_sorter({}),
        attach_mappings = function(current_prompt_bufnr)
          action_set.select:replace(function()
            local mappings_current_picker = action_state.get_current_picker(current_prompt_bufnr)
            local dirs = {}
            local selections = mappings_current_picker:get_multi_selection()

            if vim.tbl_isempty(selections) then
              table.insert(dirs, action_state.get_selected_entry().value)
            else
              for _, selection in ipairs(selections) do
                table.insert(dirs, selection.value)
              end
            end

            live_grep_filters.directories = dirs
            actions.close(prompt_bufnr)
            run_live_grep(current_input)
          end)
          return true
        end,
      })
      :find()
  end,
})

---Search with the neovim folder only
function M.browse_nvim()
  local opts = {
    cwd = "~/.config/nvim",
    previewer = false,
    prompt_title = Cange.get_icon("ui.Gear") .. " NeoVim Config",
    shorten_path = false,
  }

  builtin.find_files(opts)
end

---Align diagnostics dialogue UI
function M.diagnostics_log()
  builtin.diagnostics(themes.get_ivy({
    bufnr = 0,
    initial_mode = "normal",
    no_listed = true, -- if true show only listed buffersw
    previewer = false,
    prompt_title = Cange.get_icon("ui.Stethoscope") .. " Diagnostics Log",
  }))
end

function M.browse_workspace()
  builtin.find_files({
    cwd = "~/workspace/",
    hidden = true,
    prompt_title = Cange.get_icon("ui.Workspace") .. " Workspace",
    shorten_path = false,
  })
end

-- File browser
function M.file_browser()
  local path = "%:p:h"
  local opts = {
    cwd = vim.fn.expand(path),
    path = path,
    attach_mappings = function(prompt_bufnr, keymap)
      local current_picker = action_state.get_current_picker(prompt_bufnr)

      local modify_cwd = function(new_cwd)
        local finder = current_picker.finder

        finder.path = new_cwd
        finder.files = true
        current_picker:refresh(false, { reset_prompt = true })
      end

      -- navigate up in dir tree
      keymap("i", "-", function()
        modify_cwd(current_picker.cwd .. "/..")
      end)
      -- up to user root
      keymap("i", "~", function()
        modify_cwd(vim.fn.expand("~"))
      end)

      return true
    end,
  }

  telescope.extensions.file_browser.file_browser(opts)
end

return M
