return {
  { -- File explorer
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "nightly",
    config = function()
      local icon = Cange.get_icon
      local function git_icons()
        local icons = icon("git_states")
        ---@diagnostic disable-next-line: param-type-mismatch
        for name, _ in pairs(icons) do
          icons[name] = icon("git_states." .. name)
        end
        return icons
      end

      local api = require("nvim-tree.api")
      local Event = api.events.Event
      local toggle_help_key = "<leader>/"
      local callback = require("nvim-tree.config").nvim_tree_callback

      -- enable help toggle when tree open
      api.events.subscribe(Event.TreeOpen, function()
        vim.keymap.set("n", toggle_help_key, function()
          api.tree.toggle_help()
        end)
      end)

      api.events.subscribe(Event.TreeClose, function()
        vim.keymap.set("n", toggle_help_key, "<Nop>")
      end)

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
              git = git_icons(),
            },
          },
        },
        diagnostics = {
          enable = true,
          icons = {
            error = icon("diagnostics.Error"),
            warning = icon("diagnostics.Warning"),
            hint = icon("diagnostics.Hint"),
            info = icon("diagnostics.Information"),
          },
        },
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
        view = {
          mappings = {
            list = {
              { key = "v", cb = callback("vsplit") },
              { key = "h", cb = callback("split") },
            },
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
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").load_extension("harpoon")
    end,
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
    config = function()
      require("fidget").setup({ text = { spinner = "dots" } })
    end,
  },

  { -- font icon set
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup()
      require("cange.utils.icons").setup()
    end,
  },
}
