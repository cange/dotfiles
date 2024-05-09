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
          prefix = i("ui.Search", { right = 2 }),
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
            symlink_arrow = i("documents.SymlinkFile", { left = 1, right = 1 }),
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
      Cange.set_highlights({
        HarpoonWindow = { link = "NormalFloat" },
        HarpoonTitle = { link = "FloatTitle" },
        HarpoonBorder = { link = "FloatBorder" },
      })
    end,
    keys = function()
      local harpoon = require("harpoon")
      return {
        { "<leader>a", function() harpoon:list():add() end, desc = "Add ⇁ mark" },
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
    "folke/persistence.nvim",
    dependencies = { "nvim-tree/nvim-tree.lua" },
    event = "BufReadPre",
    opts = {
      options = vim.opt.sessionoptions:get(),
      pre_save = function() require("nvim-tree.api").tree.close() end,
    },
    keys = {
      { "<leader>er", function() require("persistence").load({ last = true }) end, desc = "Recent Session" },
      { "<leader>es", function() require("persistence").save() end, desc = "Save session" },
      { "<leader>ed", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
    init = function() require("persistence").load() end,
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
        group = i("ui.ChevronRight", { right = 1 }),
        separator = "",
      },
      window = {
        border = Cange.get_config("ui.border"),
        margin = { 4, 8, 4, 8 }, -- extra window margin [top, right, bottom, left]
        padding = { 0, 0, 1, 0 }, -- extra window padding [top, right, bottom, left]
        winblend = vim.opt.winblend:get(),
      },
      layout = {
        width = { min = 32, max = 56 }, -- min and max width of the columns
        spacing = 4, -- spacing between columns
      },
      show_keys = true, -- show the currently pressed key and its label as a message in the command line
    },
    config = function(_, opts)
      local wk = require("which-key")

      wk.setup(opts)
      wk.register({ ["<leader>b"] = { name = i("documents.File", { right = 1 }) .. "Buffers" } })
      wk.register({ ["<leader>c"] = { name = i("ui.Code", { right = 1 }) .. "Code" } })
      wk.register({ ["<leader>e"] = { name = i("ui.Neovim", { right = 1 }) .. "Editor" } })
      wk.register({ ["<leader>g"] = { name = i("git.Branch", { right = 1 }) .. "Git" } })
      wk.register({ ["<leader>s"] = { name = i("ui.Search", { right = 1 }) .. "Search" } })
      wk.register({ ["<leader>t"] = { name = i("ui.Stethoscope", { right = 1 }) .. "Troubleshooting" } })
      wk.register({ ["<localleader>c"] = { name = i("ui.Copilot", { right = 1 }) .. "Copilot" } })
      wk.register({ ["g"] = { name = i("ui.Code", { right = 1 }) .. "Code/LSP" } })
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
        FIX = { alt = { "FIXME", "FIXUP", "BUG", "FIXIT", "ISSUE" }, icon = nil },
        NOTE = { alt = { "INFO", "DEPRECATED" }, icon = nil },
        TODO = { icon = i("ui.Check") },
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
