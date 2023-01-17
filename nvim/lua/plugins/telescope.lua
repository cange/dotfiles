return {
  -- Fuzzy Finder
  "nvim-telescope/telescope.nvim", -- fuzzy finder over lists
  dependencies = {
    "BurntSushi/ripgrep", -- telescope live grep suggestions
    "nvim-lua/plenary.nvim", -- common lua functions - https://github.com/nvim-lua/plenary.nvim
    "nvim-telescope/telescope-file-browser.nvim", -- browser extension
    "nvim-telescope/telescope-project.nvim", -- switch between projects
    "nvim-telescope/telescope-ui-select.nvim", -- improved select UI
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- improves search performance
    "nvim-telescope/telescope-live-grep-args.nvim", -- enables passing arguments to the grep command
    { "ThePrimeagen/harpoon", dependencies = "nvim-lua/plenary.nvim" }, -- bookmark buffers
  },
  config = function()
    -- local ns = "[plugins.telescope]"
    local actions = require("telescope.actions")
    local telescope = require("telescope")
    local themes = require("telescope.themes")
    local custom_pickers = require("cange.telescope")
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
        prompt_prefix = " " .. Cange.get_icon("ui.Search") .. " ",
        selection_caret = " " .. Cange.get_icon("ui.ChevronRight") .. " ",
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
        project = default_opts,
      },
      pickers = {
        buffers = default_opts,
        colorscheme = default_opts,
        find_files = vim.tbl_extend("force", default_opts, {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
        }),
        grep_string = default_opts,
        help_tags = { theme = "ivy" },
        lsp_declarations = lsp_opts,
        lsp_definitions = lsp_opts,
        lsp_references = lsp_opts,
        quickfix = default_opts,
        live_grep = {
          path_display = { "shorten" },
          theme = "ivy",
          mappings = {
            i = {
              ["<C-f>"] = custom_pickers.actions.set_extension,
            },
          },
        },
      },
    })

    -- extensions
    telescope.load_extension("fzf")
    telescope.load_extension("harpoon")
    telescope.load_extension("notify")
    telescope.load_extension("project")
    telescope.load_extension("textcase")
    telescope.load_extension("ui-select")
  end,
}
