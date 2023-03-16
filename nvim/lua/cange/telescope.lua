local ns = "[cange.telescope]"
local found_telescope, telescope = pcall(require, "telescope")
if not found_telescope then
  print(ns, '"telescope" not found')
  return
end
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")
local transform_mod = require("telescope.actions.mt").transform_mod

local M = {}

---Keep track of the active extension and folders for `live_grep`
local live_grep_filters = {
  ---@type nil|string
  extension = nil,
}

---Run `live_grep` with the active filters (extension and folders)
local function run_live_grep(current_input)
  -- TODO: Resume old one with same options somehow
  builtin.live_grep({
    additional_args = live_grep_filters.extension and function() return { "-g", live_grep_filters.extension } end,
    default_text = current_input,
  })
end

-- Inspired by https://github.com/JoosepAlviste/dotfiles/blob/master/config/nvim/lua/j/plugins/telescope_custom_pickers.lua
M.actions = transform_mod({
  ---Ask for a file extension and filtering by it
  set_extension = function(prompt_bufnr)
    local current_picker = action_state.get_current_picker(prompt_bufnr)

    vim.ui.input({ default = "*.", prompt = "File type: " }, function(input)
      if input == nil then return end

      live_grep_filters.extension = input
      actions._close(prompt_bufnr, current_picker.initial_mode == "insert")
      run_live_grep(action_state.get_current_line())
    end)
  end,
})

---Wapper over `live_grep` to first reset active filters
function M.live_grep()
  live_grep_filters.extension = nil

  builtin.live_grep()
end

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
    prompt_title = Cange.get_icon("documents.Briefcase") .. " Workspace",
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
      keymap("i", "-", function() modify_cwd(current_picker.cwd .. "/..") end)
      -- up to user root
      keymap("i", "~", function() modify_cwd(vim.fn.expand("~")) end)

      return true
    end,
  }

  telescope.extensions.file_browser.file_browser(opts)
end

return M
