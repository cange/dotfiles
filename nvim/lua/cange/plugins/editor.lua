return {
  { -- File explorer
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "nightly",
    config = function()
      local icon = Cange.get_icon
      local git_icons = icon("git_states")
      ---@diagnostic disable-next-line: param-type-mismatch
      for name, _ in pairs(git_icons) do
        git_icons[name] = icon("git_states." .. name)
      end
      require("nvim-tree").setup({
        live_filter = {
          prefix = icon("ui.Search") .. "  ",
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
              default = icon("documents.File"),
              bookmark = icon("ui.Bookmark"),
              symlink = icon("documents.SymlinkFile"),
              folder = {
                arrow_closed = icon("ui.ChevronRight"),
                arrow_open = icon("ui.ChevronDown"),
                default = icon("documents.Folder"),
                empty = icon("documents.EmptyFolder"),
                empty_open = icon("documents.EmptyOpenFolder"),
                open = icon("documents.OpenFolder"),
                symlink = icon("documents.SymlinkFolder"),
                symlink_open = icon("documents.SymlinkFolder"),
              },
              git = git_icons,
            },
          },
        },
        diagnostics = {
          enable = true,
          icons = {
            error = icon("diagnostics.Error"),
            warning = icon("diagnostics.Warn"),
            hint = icon("diagnostics.Hint"),
            info = icon("diagnostics.Info"),
          },
        },
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
      })
    end,
  },

  { -- Distraction-free coding
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup({
        window = {
          backdrop = 0.9, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
          -- height and width can be:
          -- * an absolute number of cells when > 1
          -- * a percentage of the width (0.9 = 90%) / height of the editor when <= 1
          -- * a function that returns the width or the height
          width = 1, -- width of the Zen window
          height = 1, -- height of the Zen window
          -- by default, no options are changed for the Zen window
          -- uncomment any of the options below, or add other vim.wo options you want to apply
          options = {
            -- signcolumn = "no", -- disable signcolumn
            -- number = false, -- disable number column
            -- relativenumber = false, -- disable relative numbers
            -- cursorline = false, -- disable cursorline
            -- cursorcolumn = false, -- disable cursor column
            -- foldcolumn = "0", -- disable fold column
            -- list = false, -- disable whitespace characters
          },
        },
        plugins = {
          gitsigns = { enabled = false }, -- true disables git signs
        },
        -- callback where you can add custom code when the Zen window opens
        -- on_open = function(win) end,
        -- callback where you can add custom code when the Zen window closes
        -- on_close = function() end,
      })

      vim.keymap.set({ "n", "i" }, "<leader>z", ":ZenMode<CR>", { desc = "Toggle Zen Mode" })
    end,
  },

  { -- bookmark buffers
    "ThePrimeagen/harpoon",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  { -- extends auto-session through Telescope
    "rmagatti/session-lens",
    dependencies = {
      "rmagatti/auto-session",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("session-lens").setup({
        path_display = { "shorten" },
        previewer = true,
        prompt_title = "Sessions",
      })
      require("telescope").load_extension("session-lens")
    end,
  },
  {
    "rmagatti/auto-session", -- small automated session manager
    dependencies = { "rmagatti/session-lens" },
    config = function()
      -- better experience with the plugin overall using this config for sessionoptions is recommended.
      vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

      require("auto-session").setup({
        log_level = "info",
        auto_restore_enabled = nil,
        auto_save_enabled = nil,
        auto_session_enable_last_session = false, -- Loads the last loaded session if session for cwd does not exist
        auto_session_enabled = true,
        auto_session_suppress_dirs = { "~/", "~/workspace" }, -- Suppress session create/restore if in one of the list of dirs
        auto_session_use_git_branch = nil, -- Use the git branch to differentiate the session name
      })
    end,
  },

  { -- shows LSP initialization progress
    "j-hui/fidget.nvim",
    config = function() require("fidget").setup({ text = { spinner = "dots" } }) end,
  },

  { -- font icon set
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup()
      require("cange.utils.icons").setup()
    end,
  },

  { -- keymaps
    "folke/which-key.nvim",
    config = function()
      local wk = require("which-key")

      wk.setup({
        plugins = {
          spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 8, -- how many suggestions should be shown in the list?
          },
        },
        icons = {
          breadcrumb = Cange.get_icon("ui.ArrowRight"),
          separator = Cange.get_icon("ui.ChevronRight"),
          group = Cange.get_icon("ui.PlusSmall") .. " ",
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
      })

      wk.register(require("cange.utils.keymaps").whichkey_mappings(), {})
    end,
  },
}
