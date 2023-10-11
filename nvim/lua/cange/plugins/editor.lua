local i = Cange.get_icon

return {
  { -- File explorer
    "nvim-tree/nvim-tree.lua",
    -- desc = "File Tree Explorer",
    keys = {
      { "<leader>\\", "<cmd>NvimTreeToggle<CR>", desc = "File Tree Explorer" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "nightly",
    config = function()
      require("nvim-tree").setup({
        live_filter = {
          prefix = i("ui.Search") .. "  ",
        },
        -- project plugin related
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
        -- common
        renderer = {
          indent_markers = {
            enable = true,
          },
          icons = {
            show = {
              folder_arrow = false,
            },
            git_placement = "after",
            glyphs = {
              default = i("documents.File"),
              bookmark = i("ui.Bookmark"),
              symlink = i("documents.SymlinkFile"),
              folder = {
                arrow_closed = i("ui.ChevronRight"),
                arrow_open = i("ui.ChevronDown"),
                default = i("documents.Folder"),
                empty = i("documents.EmptyFolder"),
                empty_open = i("documents.EmptyOpenFolder"),
                open = i("documents.OpenFolder"),
                symlink = i("documents.SymlinkFolder"),
                symlink_open = i("documents.SymlinkFolder"),
              },
              git = i("git_states"),
            },
          },
        },
        diagnostics = {
          enable = true,
          icons = {
            error = i("diagnostics.Error"),
            warning = i("diagnostics.Warn"),
            hint = i("diagnostics.Hint"),
            info = i("diagnostics.Info"),
          },
        },
      })

      vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
        group = vim.api.nvim_create_augroup("before_file_tree_explorer_close", { clear = true }),
        desc = "Close file tree explorer",
        command = "NvimTreeClose",
      })
    end,
  },

  { -- Distraction-free coding
    "folke/zen-mode.nvim",
    opts = {
      window = {
        backdrop = 0.9, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        width = 1, -- width of the Zen window
        height = 1, -- height of the Zen window
      },
    },
  },

  { -- bookmark buffers
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function() require("telescope").load_extension("harpoon") end,
  },

  { -- small automated session manager
    "rmagatti/auto-session",
    config = function(_, opts)
      -- better experience with the plugin overall using this config for sessionoptions is recommended.
      vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
      require("auto-session").setup(opts)
    end,
    opts = {
      log_level = vim.log.levels.INFO,
      auto_session_suppress_dirs = { "~/", "~/workspace" }, -- Suppress session create/restore if in one of the list of dirs
    },
  },

  { -- font icon set
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    config = function()
      require("nvim-web-devicons").setup()
      require("cange.utils.icons").setup()
    end,
  },

  { -- keymaps
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = {
        spelling = {
          enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 8, -- how many suggestions should be shown in the list?
        },
      },
      icons = {
        breadcrumb = i("ui.ArrowRight"),
        group = i("ui.Plus") .. " ",
        separator = "",
      },
      window = {
        border = Cange.get_config("ui.border"),
        margin = { 4, 8, 4, 8 }, -- extra window margin [top, right, bottom, left]
        padding = { 0, 0, 2, 0 }, -- extra window padding [top, right, bottom, left]
        winblend = vim.opt.winblend:get(),
      },
      layout = {
        width = { min = 32, max = 56 }, -- min and max width of the columns
        spacing = 4, -- spacing between columns
      },
      ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    },
    config = function(_, opts)
      local wk = require("which-key")

      wk.setup(opts)

      wk.register(require("cange.utils.keymaps").whichkey_mappings(), {})
    end,
  },
}
