return {
  -- Fuzzy Finder
  "nvim-telescope/telescope.nvim", -- fuzzy finder over lists
  dependencies = {
    "BurntSushi/ripgrep", -- telescope live grep suggestions
    "ThePrimeagen/harpoon", -- bookmark buffers
    "nvim-lua/plenary.nvim", -- common lua functions - https://github.com/nvim-lua/plenary.nvim
    "nvim-telescope/telescope-file-browser.nvim", -- browser extension
    "nvim-telescope/telescope-project.nvim", -- switch between projects
    "nvim-telescope/telescope-ui-select.nvim", -- improved select UI
    "tsakirist/telescope-lazy.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- improves search performance
  },
  config = function()
    local actions = require("telescope.actions")
    local telescope = require("telescope")
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
          "smart",
          "absolute",
        },
        entry_prefix = "    ",
        layout_config = {
          horizontal = {
            preview_width = 80,
            prompt_position = "top",
          },
          bottom_pane = {
            prompt_position = "bottom",
          },
        },
        mappings = {
          i = {
            ["<C-s>"] = actions.cycle_history_next,
            ["<C-a>"] = actions.cycle_history_prev,
            ["<C-c>"] = actions.close,
          },
        },
        prompt_prefix = " " .. Cange.get_icon("ui.Search") .. "  ",
        scroll_strategy = "cycle",
        selection_caret = " " .. Cange.get_icon("ui.ChevronRight") .. "  ",
        sorting_strategy = "ascending",
        winblend = vim.opt.winblend:get(),
      },
      extensions = {
        ["ui-select"] = { --https://github.com/nvim-telescope/telescope-ui-select.nvim#telescope-setup-and-configuration
          require("telescope.themes").get_cursor(),
        },
        project = default_opts,
      },
      pickers = {
        buffers = default_opts,
        colorscheme = { enable_preview = true, theme = "dropdown" },
        current_buffer_fuzzy_find = { theme = "ivy" },
        highlights = { theme = "ivy" },
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
          previewer = false,
          theme = "dropdown",
        },
        git_branches = default_opts,
        grep_string = default_opts,
        help_tags = { theme = "ivy" },
        keymaps = { theme = "ivy" },
        lsp_declarations = lsp_opts,
        lsp_definitions = lsp_opts,
        lsp_references = lsp_opts,
        live_grep = {
          theme = "ivy",
          mappings = {
            i = {
              ["<C-f>"] = custom_pickers.actions.set_extension,
            },
          },
        },
        oldfiles = { theme = "ivy" },
        quickfix = default_opts,
      },
    })

    -- extensions
    telescope.load_extension("fzf")
    telescope.load_extension("project")
    telescope.load_extension("ui-select")
    telescope.load_extension("lazy")
  end,
}
