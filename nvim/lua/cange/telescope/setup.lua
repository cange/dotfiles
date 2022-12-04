local ns = "[cange.telescope.setup]"
local found_telescope, telescope = pcall(require, "telescope")
if not found_telescope then
  print(ns, '"telescope" not found')
  return
end
local actions = require("telescope.actions")
local themes = require("telescope.themes")
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
    entry_prefix = "    ",
    prompt_prefix = " " .. Cange.get_icon("ui", "Search") .. " ",
    selection_caret = " " .. Cange.get_icon("ui", "ChevronRight") .. " ",
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
        ["<C-c>"] = actions.close,
      },
    },
  },
  extensions = {
    ["ui-select"] = { --https://github.com/nvim-telescope/telescope-ui-select.nvim#telescope-setup-and-configuration
      themes.get_cursor(),
    },
  },
  pickers = {
    buffers = default_opts,
    colorscheme = default_opts,
    find_files = vim.tbl_extend("force", default_opts, {
      -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
      find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
    }),
    grep_string = default_opts,
    live_grep = { theme = "ivy" },
    help_tags = { theme = "ivy" },
    lsp_declarations = lsp_opts,
    lsp_definitions = lsp_opts,
    lsp_references = lsp_opts,
    quickfix = default_opts,
  },
})
