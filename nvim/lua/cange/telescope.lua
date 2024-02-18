local ok, telescope = pcall(require, "telescope")
if not ok then
  error('[cange.telescope] "telescope" not found')
  return
end
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")
local i = Cange.get_icon

local M = {}

---Keep track of the active extension and folders for `live_grep`
local live_grep_filters = {
  ---@type nil|string
  file_extension = nil,
}

---Run `live_grep` with the active filters (extension and folders)
---@param current_input string
local function run_live_grep(current_input)
  builtin.live_grep({
    additional_args = live_grep_filters.file_extension
      and function() return { "-g", live_grep_filters.file_extension } end,
    default_text = current_input,
  })
end

---Ask for a file extension and filtering by it
---@param prompt_bufnr number
M.file_extension_filter_input = function(prompt_bufnr)
  local current_picker = action_state.get_current_picker(prompt_bufnr)

  vim.ui.input({ default = "*.", prompt = "File type: " }, function(input)
    if input == nil then return end

    live_grep_filters.file_extension = input
    actions._close(prompt_bufnr, current_picker.initial_mode == "insert")
    run_live_grep(action_state.get_current_line())
  end)
end

---Wapper over `live_grep` to first reset active filters
function M.live_grep()
  live_grep_filters.file_extension = nil

  builtin.live_grep()
end

function M.browse_nvim()
  builtin.find_files({
    cwd = "~/.config/nvim",
    previewer = false,
    prompt_title = i("ui.Neovim") .. " Neovim",
  })
end

function M.browse_snippets()
  builtin.find_files({
    cwd = "~/.config/snippets",
    previewer = true,
    prompt_title = i("ui.Library") .. " Snippets",
  })
end

function M.diagnostics_log()
  builtin.diagnostics(themes.get_ivy({
    bufnr = 0,
    initial_mode = "normal",
    no_listed = true, -- if true, shows only listed buffers
    previewer = false,
    prompt_title = i("ui.Stethoscope") .. " Diagnostics Log",
  }))
end

function M.browse_workspace()
  builtin.find_files({
    cwd = "~/workspace/",
    hidden = true,
    prompt_title = i("documents.Briefcase") .. " Workspace",
    shorten_path = false,
  })
end

function M.file_browser()
  local path = "%:p:h"
  telescope.extensions.file_browser.file_browser({
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
  })
end

return M
