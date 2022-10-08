local ns = "cange.telescope.setup"
local found_telescope, telescope = pcall(require, "telescope")
if not found_telescope then
  print("[" .. ns .. '] "telescope" not found')
  return
end
local found_utils, utils = pcall(require, "cange.utils")
if not found_utils then
  print("[" .. ns .. '] "cange.utils" not found')
  return
end
local icon = utils.get_icon
local actions = require("telescope.actions")
-- config
local default_opts = {
  previewer = false,
  theme = "dropdown",
}
local lsp_opts = {
  initial_mode = "normal",
  previewer = false,
  theme = "dropdown",
}
-- setup
telescope.setup({
  defaults = {
    path_display = {
      "smart", -- shows only the difference between the displayed paths
      "absolute",
    },
    prompt_prefix = " " .. icon("ui", "Search") .. " ",
    selection_caret = " " .. icon("ui", "ChevronRight") .. " ",
    entry_prefix = "    ",
    layout_config = {
      horizontal = {
        preview_width = 80,
        prompt_position = "top",
      },
    },
    scroll_strategy = "cycle",
    sorting_strategy = "ascending",
    mappings = {
      i = {
        ["<C-s>"] = actions.cycle_history_next,
        ["<C-a>"] = actions.cycle_history_prev,
      },
    },
  },
  pickers = {
    buffers = default_opts,
    colorscheme = default_opts,
    find_files = default_opts,
    quickfix = default_opts,
    live_grep = { theme = "ivy" },
    grep_string = default_opts,
    lsp_references = lsp_opts,
    lsp_declarations = lsp_opts,
    lsp_definitions = lsp_opts,
  },
})
