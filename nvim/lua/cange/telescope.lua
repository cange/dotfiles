local ns = "[cange.telescope]"
local found_telescope, telescope = pcall(require, "telescope")
if not found_telescope then
  print(ns, '"telescope" not found')
  return
end
local builtin = require("telescope.builtin")
local actions_state = require("telescope.actions.state")
local themes = require("telescope.themes")
-- config
local M = {}

function M.browse_nvim()
  local opts = {
    cwd = "~/.config/nvim",
    previewer = false,
    prompt_title = Cange.get_icon("ui.Gear") .. " NeoVim Config",
    shorten_path = false,
  }

  builtin.find_files(opts)
end

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
      local current_picker = actions_state.get_current_picker(prompt_bufnr)

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