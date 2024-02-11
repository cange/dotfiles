local i = Cange.get_icon

return {
  { -- File explorer
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    keys = {
      { "<leader>\\", "<cmd>NvimTreeToggle<CR>", desc = "File Tree Explorer" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
          indent_markers = { enable = true },
          icons = {
            show = { folder_arrow = false },
            diagnostics_placement = "after",
            git_placement = "signcolumn",
            modified_placement = "signcolumn",
            symlink_arrow = i("documents.SymlinkFile"),
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

  { -- bookmark buffers
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    branch = "harpoon2",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    opts = {
      settings = {
        save_on_toggle = true, -- any time the ui menu is closed then sync
      },
    },
    config = function(_, opts)
      require("harpoon"):setup(opts)
      require("telescope").load_extension("harpoon")
    end,
    keys = function()
      local harpoon = require("harpoon")
      return {
        { "<leader>a", function() harpoon:list():append() end, desc = "Add ⇁ mark" },
        { "<leader>m", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Show ⇁ marks" },
        { "<leader>sm", "<cmd>Telescope harpoon marks<CR>", desc = "Search ⇁ marks" },
        { "<leader>1", function() harpoon:list():select(1) end, desc = "⇁ to 1st mark" },
        { "<leader>2", function() harpoon:list():select(2) end, desc = "⇁ to 2nd mark" },
        { "<leader>3", function() harpoon:list():select(3) end, desc = "⇁ to 3rd mark" },
        { "<leader>4", function() harpoon:list():select(4) end, desc = "⇁ to 4th mark" },
        { "[m", function() harpoon:list():prev() end, desc = "Prev ⇁ mark" },
        { "]m", function() harpoon:list():next() end, desc = "Next ⇁ mark" },
      }
    end,
  },

  { -- small automated session manager
    "rmagatti/auto-session",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      -- Suppress session create/restore if in one of the list of dirs
      require("auto-session").setup({ auto_session_suppress_dirs = { "~/", "~/workspace" } })
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
        breadcrumb = "",
        group = i("ui.ChevronRight") .. " ",
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
      wk.register({ ["<leader>b"] = { name = "Buffers" } })
      wk.register({ ["<leader>c"] = { name = "Code/Copilot" } })
      wk.register({ ["<leader>e"] = { name = "Editor" } })
      wk.register({ ["<leader>g"] = { name = "Git" } })
      wk.register({ ["<leader>s"] = { name = "Search" } })
      wk.register({ ["<leader>t"] = { name = "Troubleshooting" } })
    end,
  },

  -- Highlight the word under the cursor
  { "RRethy/vim-illuminate", event = { "BufReadPost", "BufNewFile" } },

  -- multi search and replace
  { "mg979/vim-visual-multi", event = "VeryLazy" },

  { -- allows to surround sections parentheses, brackets, quotes, XML tags, and more
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function(_, opts) require("nvim-surround").setup(opts) end,
  },

  { -- comment toggle
    "numToStr/Comment.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
  },

  { -- highlight TODO, FIXME, etc in comments
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    opts = {
      keywords = {
        NOTE = { icon = " ", color = "hint", alt = { "INFO", "DEPRECATED" } },
      },
    },
  },

  { -- contextual comment in embedded language files like Vue.JS
    "JoosepAlviste/nvim-ts-context-commentstring",
    commit = "6c30f3c", -- lock until `vim.g.skip_ts_context_commentstring_module = true` works
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },

  { -- text case converter (camel case, etc.,
    "johmsalas/text-case.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("textcase").setup()
      require("telescope").load_extension("textcase")
    end,
    keys = {
      { "cc", "<cmd>TextCaseOpenTelescopeQuickChange<CR>", desc = "Change Case", mode = { "v", "n" } },
    },
  },

  { -- close brackets, quotes etc
    "windwp/nvim-autopairs",
    lazy = true,
    event = { "InsertEnter" },
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true, -- enable Tree-Sitter
        ts_config = {
          lua = { "string" }, -- it will not add a pair on that treesitter node
          javascript = { "template_string" },
        },
      })

      -- make autopairs and completion work together
      -- If you want insert `(` after select function or method item
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local ok, cmp = pcall(require, "cmp")
      if not ok then return end

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  { -- Markdown preview
    "toppair/peek.nvim",
    event = "InsertEnter",
    build = "deno task --quiet build:fast",
    opts = { -- https://github.com/toppair/peek.nvim
      auto_load = true, -- whether to automatically load preview when entering another markdown buffer
      close_on_bdelete = true, -- close preview window on buffer delete
      syntax = true, -- enable syntax highlighting, affects performance
      theme = "dark", -- 'dark' or 'light'
      update_on_change = true,
      app = "browser", -- open in target 'webview', 'browser'
      -- relevant if update_on_change is true
      throttle_at = 200000, -- start throttling when file exceeds this amount of bytes in size
      throttle_time = "auto", -- minimum amount of time in milliseconds that has to pass before starting new render
    },
    keys = {
      {
        "<leader>M",
        function()
          local method = require("peek").is_open() and "close" or "open"
          Log:info(method, "Markdown Preview")
          require("peek")[method]()
        end,
        desc = "Toggle Markdown Preview",
      },
    },
  },

  { -- search jump to any vertical/horizontal location
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "o", "x" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },

  { -- smooth scrolling
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function() require("neoscroll").setup() end,
  },

  { -- Hex color highlighter
    "NvChad/nvim-colorizer.lua",
    opts = {
      filetypes = {
        "*", -- highlight all files by default
        "!lazy", -- exclude from highlighting.
      },
    },
  },
}
