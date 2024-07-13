local icons = require("cange.icons")

return {
  { -- file explorer to execute bulk file/directory operations (renaming)
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      columns = { "icon" },
      view_options = {
        show_hidden = true,
      },
    },
    keys = {
      { "-", "<cmd>Oil --float<CR>", desc = "Open Oil explorer" },
    },
  },

  { -- File explorer
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    keys = {
      { "<leader>\\", "<cmd>NvimTreeToggle<CR>", desc = "File Tree Explorer" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        live_filter = {
          prefix = icons.ui.Search .. "  ",
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
            git_placement = "after",
            show = { folder = false },
            symlink_arrow = " " .. icons.documents.SymlinkFile .. " ",
            glyphs = {
              default = icons.documents.File,
              bookmark = icons.ui.Bookmark,
              symlink = icons.documents.SymlinkFile,
              folder = {
                arrow_closed = icons.ui.ChevronRight,
                arrow_open = icons.ui.ChevronDown,
                default = icons.documents.Folder,
                empty = icons.documents.EmptyFolder,
                empty_open = icons.documents.EmptyOpenFolder,
                open = icons.documents.OpenFolder,
                symlink = icons.documents.SymlinkFolder,
                symlink_open = icons.documents.SymlinkFolder,
              },
              git = icons.git_states,
            },
          },
        },
        diagnostics = {
          enable = true,
          icons = {
            error = icons.diagnostics.Error,
            warning = icons.diagnostics.Warn,
            hint = icons.diagnostics.Hint,
            info = icons.diagnostics.Info,
          },
        },
      })

      vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
        group = vim.api.nvim_create_augroup("before_file_tree_explorer_close", { clear = true }),
        desc = "Close file tree explorer",
        command = "NvimTreeClose",
      })

      Cange.set_highlights({
        NvimTreeGitDirtyIcon = { link = "GitSignsChange" },
        NvimTreeGitNewIcon = { link = "GitSignsAdd" },
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
      -- stylua: ignore start
      return {
        { "<leader>ma", function() harpoon:list():add() end,                         desc = "Add %s mark" },
        { "<leader>mm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Show %s marks" },
        { "<leader>ms", "<cmd>Telescope harpoon marks<CR>",                          desc = "Search marks" },
        { "<leader>m1", function() harpoon:list():select(1) end,                     desc = "1st mark" },
        { "<leader>m2", function() harpoon:list():select(2) end,                     desc = "2nd mark" },
        { "<leader>m3", function() harpoon:list():select(3) end,                     desc = "3rd mark" },
        { "<leader>m4", function() harpoon:list():select(4) end,                     desc = "4th mark" },
        { "[m", function() harpoon:list():prev() end,                                desc = "Prev %s mark" },
        { "]m", function() harpoon:list():next() end,                                desc = "Next %s mark" },
      }
      -- stylua: ignore end
    end,
  },

  {
    "olimorris/persisted.nvim",
    lazy = false, -- make sure the plugin is always loaded at startup
    opts = {
      autoload = true,
      on_autoload_no_session = function() vim.notify("[persisted] No existing session to load.") end,
    },
    config = function(_, opts) require("persisted").setup(opts) end,
    keys = {
      { "<leader>qd", "<cmd>SessionLoad<CR>", desc = "Load session of current directory" },
      { "<leader>qr", "<cmd>SessionLoadLast>", desc = "Recent session " },
      { "<leader>qs", "<cmd>SessionSave<CR>", desc = "Save the current session" },
      { "<leader>qS", "<cmd>SessionStop<CR>", desc = "Stop recording a session" },
    },
  },

  { -- keymaps
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      icons = {
        breadcrumb = "",
        group = icons.ui.ChevronRight .. " ",
        separator = "",
        colors = false,
      },
      win = {
        padding = { 2, 2 },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")

      wk.setup(opts)
      wk.add({
        -- groups
        { "<leader>b", group = "Buffers", icon = icons.documents.File },
        { "<leader>c", group = "Code", icon = icons.ui.Code },
        { "<leader>e", group = "Editor", icon = icons.ui.Neovim },
        { "<leader>g", group = "Git", icon = icons.git.Branch },
        { "<leader>m", group = "Bookmark", icon = icons.plugin.Harpoon },
        { "<leader>q", group = "Session" },
        { "<leader>s", group = "Search", icon = icons.ui.Search },
        { "<leader>t", group = "Troubleshooting", icon = icons.ui.Stethoscope },
        { "<localleader>c", group = "Copilot", icon = icons.plugin.Copilot },
        { "g", group = "Code/LSP", icon = icons.ui.Code },
        -- direct keymaps
        { "<leader>-", "<C-W>s", desc = "Split horizontal", icon = icons.ui.SplitHorizontal },
        { "<leader>|", "<C-W>v", desc = "Split vertical", icon = icons.ui.SplitVertical },
      })
    end,
  },

  { -- Highlight the word under the cursor
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      filetypes_denylist = { "NvimTree" },
    },
    config = function(_, opts) require("illuminate").configure(opts) end,
  },

  -- multi search and replace
  { "mg979/vim-visual-multi", event = "VeryLazy" },

  { -- allows to surround sections parentheses, brackets, quotes, XML tags, and more
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function(_, opts) require("nvim-surround").setup(opts) end,
  },

  { -- highlight TODO, FIXME, etc in comments
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      keywords = {
        FIX = { icon = "" },
        NOTE = { icon = "" },
        TODO = { icon = "" },
      },
    },
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
        "<localleader>m",
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
    keys = {
      { "s", function() require("flash").jump() end, desc = "Flash", mode = { "n", "o", "x" } },
      { "S", function() require("flash").treesitter() end, desc = "Flash Treesitter", mode = { "n", "o", "x" } },
      { "r", function() require("flash").remote() end, desc = "Remote Flash", mode = "o" },
      { "R", function() require("flash").treesitter_search() end, desc = "Treesitter Search", mode = { "o", "x" } },
      { "<c-s>", function() require("flash").toggle() end, desc = "Toggle Flash Search", mode = "c" },
    },
  },

  { -- smooth scrolling
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = true,
  },

  { -- Hex color highlighter
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      enable_tailwind = true,
      exclude_filetypes = { "lazy" },
    },
    keys = {
      { "<leader>ct", "<cmd>HighlightColors Toggle<CR>", desc = "Toggle Highlight Colors" },
    },
  },
}
