return {
  -- advanced colorcolumn
  { "lukas-reineke/virt-column.nvim", opts = { char = Icon.ui.LineThin } },

  { -- font icon set
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup()
      require("user.utils.icons").setup()
    end,
  },

  { -- A pretty list for showing diagnostics
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
      use_diagnostic_signs = true,
      icons = {
        indent = {
          fold_open = Icon.ui.ChevronDown,
          fold_closed = Icon.ui.ChevronRight,
        },
        folder_closed = Icon.documents.Folder,
        folder_open = Icon.documents.OpenFolder,
        kinds = Icon.cmp_kinds,
      },
    },
    config = function(_, opts)
      require("trouble").setup(opts)

      vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
        group = vim.api.nvim_create_augroup("before_troubleshooting_list_close", { clear = true }),
        desc = "Close troubleshooting list",
        callback = function() require("trouble").close() end,
      })
    end,
    keys = {
      {
        "<Leader>tl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<CR>",
        desc = "LSP Definitions / references / ...",
      },
      { "<Leader>ts", "<cmd>Trouble symbols toggle focus=false<CR>", desc = "Symbols" },
      { "<Leader>dt", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "[diag] Buffer panel" },
      { "<Leader>dT", "<cmd>Trouble diagnostics toggle<CR>", desc = "[diag] All panel" },
    },
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    -- priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup()
      vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
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
    opts = {
      aliases = {
        ["eruby"] = "html",
      },
    },
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

  { -- search jump to any vertical/horizontal location
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", function() require("flash").jump() end, desc = "Flash", mode = { "n", "o", "x" } },
      { "S", function() require("flash").treesitter() end, desc = "Flash Treesitter", mode = { "n", "o", "x" } },
      { "r", function() require("flash").remote() end, desc = "Remote Flash", mode = "o" },
      { "R", function() require("flash").treesitter_search() end, desc = "Treesitter Search", mode = { "o", "x" } },
      { "<LocalLeader>f", function() require("flash").toggle() end, desc = "Toggle Flash Search", mode = "c" },
    },
  },

  { "folke/lazydev.nvim", opts = {} }, -- improves working in neovim/lua env

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
        { "const", "let" },
      },
    },
  },

  { -- diff two separate blocks of text
    "AndrewRadev/linediff.vim",
    event = { "CursorMoved" },
    keys = {
      -- stylua: ignore start
      { "<Leader>dl", "<cmd>Linediff<CR>",      desc = "[diff] Line", mode = { "v" } },
      { "<Leader>da", "<cmd>LinediffAdd<CR>",   desc = "[diff] Add line", mode = { "v" } },
      { "<Leader>dL", "<cmd>LinediffLast<CR>",  desc = "[diff] Last line", mode = { "v" } },
      { "<Leader>dr", "<cmd>LinediffReset<CR>", desc = "[diff] Reset line", mode = { "n", "v" } },
      { "<Leader>ds", "<cmd>LinediffShow<CR>",  desc = "[diff] Show line", mode = { "n", "v" } },
      -- stylua: ignore end
    },
  },

  { -- testing toggle util
    "cange/specto.nvim",
    lazy = false,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
      exclude = {
        filetypes = {
          "",
          "NvimTree",
          "TelescopePrompt",
          "gitcommit",
          "markdown",
          "help",
          "lazy",
          "mason",
        },
      },
    },
    keys = {
      -- stylua: ignore start
      { "<LocalLeader>o", "<cmd>Specto toggle only<CR>", desc = "[specto] Toggle only" },
      { "<LocalLeader>s", "<cmd>Specto toggle skip<CR>", desc = "[specto] Toggle skip" },
      { "<LocalLeader>t", "<cmd>Specto toggle todo<CR>", desc = "[specto] Toggle todo" },
      { "[t", "<cmd>Specto jump prev<CR>",               desc = "[specto] Goto prev toggle" },
      { "]t", "<cmd>Specto jump next<CR>",               desc = "[specto] Goto next toggle" },
      -- stylua: ignore end
    },
  },
}
