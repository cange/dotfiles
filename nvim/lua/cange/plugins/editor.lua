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

  { -- Extensible UI notifications and LSP progress messages.
    "j-hui/fidget.nvim",
    opts = {},
  },

  { -- Distraction-free coding
    "folke/zen-mode.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      window = {
        width = 160, -- width of the Zen window
        height = 1, -- height of the Zen window
      },
    },
    keys = {
      { "<leader>z", "<cmd>ZenMode<CR>", desc = "Toggle Zen Mode" },
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
    keys = {
      { "<leader>m", '<cmd>lua R("harpoon.ui").toggle_quick_menu()<CR>', desc = "Show ⇁ marks" },
      { "<leader>sm", "<cmd>Telescope harpoon marks<CR>", desc = "Search ⇁ marks" },
      { "<leader>a", '<cmd>lua R("harpoon.mark").add_file()<CR>', desc = "Add ⇁ mark" },
      { "[m", '<cmd>lua R("harpoon.ui").nav_prev()<CR>', desc = "Prev ⇁ mark" },
      { "]m", '<cmd>lua R("harpoon.ui").nav_next()<CR>', desc = "Next ⇁ mark" },
      { "m1", '<cmd>lua R("harpoon.ui").nav_file(1)<CR>', desc = "⇁ to 1st mark" },
      { "m2", '<cmd>lua R("harpoon.ui").nav_file(2)<CR>', desc = "⇁ to 2nd mark" },
      { "m3", '<cmd>lua R("harpoon.ui").nav_file(3)<CR>', desc = "⇁ to 3rd mark" },
      { "m4", '<cmd>lua R("harpoon.ui").nav_file(4)<CR>', desc = "⇁ to 4th mark" },
    },
  },

  { -- small automated session manager
    "rmagatti/auto-session",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("auto-session").setup({ auto_session_suppress_dirs = { "~/", "~/workspace" } }) -- Suppress session create/restore if in one of the list of dirs
      require("telescope").load_extension("session-lens")

      -- INFO: plugin is not working which lazy `keys` option is being used
      vim.keymap.set("n", "<leader>eR", "<cmd>SessionRestore<CR>", { desc = "Recent session" })
      vim.keymap.set("n", "<leader>eX", "<cmd>SessionDelete<CR>", { desc = "Delete session" })
      vim.keymap.set("n", "<leader>es", "<cmd>SessionSave<CR>", { desc = "Save session" })
      vim.keymap.set("n", "<leader>ss", "<cmd>Telescope session-lens<CR>", { desc = "Recent Sessions" })

      -- better experience with the plugin overall using this config for sessionoptions is recommended.
      vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
    end,
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
    },
    config = function(_, opts)
      local wk = require("which-key")

      wk.setup(opts)
      wk.register({ ["<leader>c"] = { name = "Code/Copilot" } })
      wk.register({ ["<leader>g"] = { name = "Git" } })
      wk.register({ ["<leader>s"] = { name = "Search" } })
      wk.register({ ["<leader>e"] = { name = "Editor" } })
    end,
  },
}
