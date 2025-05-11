return {
  { -- File explorer
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    keys = {
      { "<Leader>\\", "<cmd>NvimTreeToggle<CR>", desc = "File Tree Explorer" },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "folke/snacks.nvim",
    },
    opts = {
      live_filter = {
        prefix = Icon.ui.Search .. "  ",
      },
      -- project plugin related
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      renderer = {
        indent_markers = { enable = true },
        icons = {
          git_placement = "after",
          show = { folder = false },
          symlink_arrow = " " .. Icon.documents.SymlinkFile .. " ",
          glyphs = {
            default = Icon.documents.File,
            bookmark = Icon.ui.Bookmark,
            symlink = Icon.documents.SymlinkFile,
            folder = {
              arrow_closed = Icon.ui.ChevronRight,
              arrow_open = Icon.ui.ChevronDown,
              default = Icon.documents.Folder,
              empty = Icon.documents.EmptyFolder,
              empty_open = Icon.documents.EmptyOpenFolder,
              open = Icon.documents.OpenFolder,
              symlink = Icon.documents.SymlinkFolder,
              symlink_open = Icon.documents.SymlinkFolder,
            },
            git = Icon.git_states,
          },
        },
      },
      diagnostics = {
        enable = true,
        icons = {
          error = Icon.diagnostics.Error,
          warning = Icon.diagnostics.Warn,
          hint = Icon.diagnostics.Hint,
          info = Icon.diagnostics.Info,
        },
      },
    },
    config = function(_, opts)
      require("nvim-tree").setup(opts)

      vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
        group = vim.api.nvim_create_augroup("before_file_tree_explorer_close", { clear = true }),
        desc = "Close file tree explorer",
        command = "NvimTreeClose",
      })

      User.set_highlights({
        NvimTreeGitDirtyIcon = { link = "GitSignsChange" },
        NvimTreeGitNewIcon = { link = "GitSignsAdd" },
      })

      -- https://github.com/folke/snacks.nvim/blob/main/docs/rename.md#nvim-tree
      local prev = { new_name = "", old_name = "" } -- Prevents duplicate events
      vim.api.nvim_create_autocmd("User", {
        pattern = "NvimTreeSetup",
        callback = function()
          local events = require("nvim-tree.api").events
          events.subscribe(events.Event.NodeRenamed, function(data)
            if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
              data = data
              require("snacks").rename.on_rename_file(data.old_name, data.new_name)
            end
          end)
        end,
      })
    end,
  },

  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = function()
      return {
        { "<LocalLeader>-", require("oil").toggle_float, desc = "Open parent directory" },
      }
    end,
    opts = {
      columns = { "icon" },
      view_options = {
        show_hidden = true,
      },
      float = {
        padding = 4,
        max_width = 0.6,
        max_height = 0.6,
      },
    },
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
        {
          "<Leader>A",
          function()
            harpoon:list():add()
            Notify.info("Bookmark added!", { title = "Harpoon" })
          end,
          desc = "Add bookmark",
         },
        { "<Leader>m", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Show bookmarks" },
        { "<Leader>sm", "<cmd>Telescope harpoon marks<CR>",                         desc = "Search bookmarks" },
        { "[m", function() harpoon:list():prev() end,                               desc = "Prev bookmark" },
        { "]m", function() harpoon:list():next() end,                               desc = "Next bookmark" },
      }
      -- stylua: ignore end
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
      { "<Leader>qr", function() require("persistence").load({ last = true }) end, desc = "Recent Session" },
      { "<Leader>qs", function() require("persistence").save() end, desc = "Save session" },
      { "<Leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
      { "<Leader>qS", function() require("persistence").select() end, desc = "Select a session" },
    },
    init = function() require("persistence").load() end,
  },

  { -- keymaps
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",

      icons = {
        mappings = false,
        breadcrumb = "",
        group = Icon.ui.ChevronRight .. " ",
        separator = "",
        colors = false,
      },
    },
    config = function(_, opts)
      local wk = require("which-key")

      wk.setup(opts)
      wk.add({
        -- groups
        { "<Leader>b", group = "Buffers" },
        { "<Leader>c", group = "Code" },
        { "<Leader>e", group = "Editor" },
        { "<Leader>,", group = "Settings" },
        { "<Leader>g", group = "Git" },
        { "<Leader>a", group = "AI", mode = { "n", "v" } },
        { "<Leader>ac", group = "CopilotChat", mode = { "n", "v" } },
        { "<Leader>d", group = "Diff", mode = { "n", "v" } },
        { "<Leader>q", group = "Session" },
        { "<Leader>s", group = "Search" },
        { "<Leader>t", group = "Troubleshooting" },
        { "<LocalLeader>c", group = "Copilot" },
        { "g", group = "Code/LSP" },
        -- direct keymaps
        { "<Leader>-", "<C-W>s", desc = "Split horizontal" },
        { "<Leader>|", "<C-W>v", desc = "Split vertical" },
      })
    end,
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

  { -- autoclose and autorename html tags
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {},
  },

  { -- close brackets, quotes etc
    "windwp/nvim-autopairs",
    lazy = true,
    event = { "InsertEnter" },
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true, -- enable Tree-Sitter
        disable_filetype = { "markdown" },
        ts_config = {
          lua = { "string" }, -- it will not add a pair on that treesitter node
          javascript = { "template_string" },
        },
      })

      -- make autopairs and completion work together
      -- If you want insert `(` after select function or method item
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local ok, cmp = pcall(require, "cmp")
      if not ok then error('"cmp" not found') end

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
        "<LocalLeader>m",
        function()
          local method = require("peek").is_open() and "close" or "open"
          Notify.info(method, { title = "Markdown Preview" })
          require("peek")[method]()
        end,
        desc = "Toggle Markdown Preview",
      },
    },
  },

  { -- improve viewing Markdown files
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      heading = {
        backgrounds = {}, -- disable
        icons = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
      },
      latex = { enabled = false }, -- avoids this warnings
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

  { -- Hex color highlighter
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      enable_tailwind = true,
      exclude_filetypes = { "lazy" },
    },
    keys = {
      { "<Leader>ct", "<cmd>HighlightColors Toggle<CR>", desc = "Toggle Highlight Colors" },
    },
  },

  { -- Toggle booleans and common string values eg. true/false, endable/disable, etc
    "nat-418/boole.nvim",
    event = "VeryLazy",
    opts = {
      mappings = {
        increment = "<C-a>",
        decrement = "<C-x>",
      },
      additions = {
        { "flex", "block", "inline-flex", "inline-block", "inline", "none" },
        { "red", "magenta", "cyan", "yellowgreen", "lime", "purple", "pink" },
        { "solid", "dashed", "dotted", "double", "none", "groove", "ridge", "inset", "outset" },
        { "left", "right" },
        { "up", "down", "only" },
        { "desktop", "tablet", "mobile" },
      },
    },
  },

  { -- diff two separate blocks of text
    "AndrewRadev/linediff.vim",
    event = { "CursorMoved" },
    keys = {
      { "<Leader>dd", ":Linediff<CR>", desc = "Line diff", mode = { "v" } },
      { "<Leader>da", ":LinediffAdd<CR>", desc = "Add line diff", mode = { "v" } },
      { "<Leader>dl", ":LinediffLast<CR>", desc = "Last line diff", mode = { "v" } },
      { "<Leader>dr", ":LinediffReset<CR>", desc = "Reset line diff", mode = { "n", "v" } },
      { "<Leader>ds", ":LinediffShow<CR>", desc = "Show line diff", mode = { "n", "v" } },
    },
  },
}
