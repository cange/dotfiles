return {
  { -- File explorer
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "nightly",
    config = function()
      local icon = Cange.get_icon
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
              git = icon("git_states"),
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
        on_attach = function(bufnr)
          local api = require("nvim-tree.api")
          local opts = function(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end
          -- stylua: ignore start
          vim.keymap.set('n', '<BS>',  api.node.navigate.parent_close,     opts('Close Directory'))
          vim.keymap.set('n', '<C-r>', api.fs.rename_sub,                  opts('Rename: Omit Filename'))
          vim.keymap.set('n', '<C-t>', api.node.open.tab,                  opts('Open: New Tab'))
          vim.keymap.set('n', '<CR>',  api.node.open.edit,                 opts('Open'))
          vim.keymap.set('n', 'D',     api.fs.trash,                       opts('Trash'))
          vim.keymap.set('n', 'F',     api.live_filter.clear,              opts('Clean Filter'))
          vim.keymap.set('n', 'H',     api.tree.toggle_hidden_filter,      opts('Toggle Dotfiles'))
          vim.keymap.set('n', 'I',     api.tree.toggle_gitignore_filter,   opts('Toggle Git Ignore'))
          vim.keymap.set('n', 'R',     api.tree.reload,                    opts('Refresh'))
          vim.keymap.set('n', 'W',     api.tree.collapse_all,              opts('Collapse'))
          vim.keymap.set('n', '[c',    api.node.navigate.git.prev,         opts('Prev Git'))
          vim.keymap.set('n', '[d',    api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
          vim.keymap.set('n', ']c',    api.node.navigate.git.next,         opts('Next Git'))
          vim.keymap.set('n', ']d',    api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
          vim.keymap.set('n', 'a',     api.fs.create,                      opts('Create'))
          vim.keymap.set('n', 'c',     api.fs.copy.node,                   opts('Copy'))
          vim.keymap.set('n', 'd',     api.fs.remove,                      opts('Delete'))
          vim.keymap.set('n', 'f',     api.live_filter.start,              opts('Filter'))
          vim.keymap.set('n', 'g?',    api.tree.toggle_help,               opts('Help'))
          vim.keymap.set('n', 'h',     api.node.open.horizontal,           opts('Open: Horizontal Split'))
          vim.keymap.set('n', 'o',     api.node.open.edit,                 opts('Open'))
          vim.keymap.set('n', 'p',     api.fs.paste,                       opts('Paste'))
          vim.keymap.set('n', 'q',     api.tree.close,                     opts('Close'))
          vim.keymap.set('n', 'r',     api.fs.rename,                      opts('Rename'))
          vim.keymap.set('n', 'v',     api.node.open.vertical,             opts('Open: Vertical Split'))
          vim.keymap.set('n', 'x',     api.fs.cut,                         opts('Cut'))
          vim.keymap.set('n', 'y',     api.fs.copy.relative_path,          opts('Copy Relative Path'))
          -- stylua: ignore end
        end,
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
