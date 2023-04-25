return {
  { -- popover notification
    "rcarriga/nvim-notify",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {
      -- Animation style (see below for details)
      stages = "fade_in_slide_out",

      -- Function called when a new window is opened, use for changing win settings/config
      on_open = nil,

      -- Function called when a window is closed
      on_close = nil,

      -- Render function for notifications. See notify-render()
      render = "default",

      -- Default timeout for notifications
      timeout = 175,

      -- For stages that change opacity this is treated as the highlight behind the window
      -- Set this to either a highlight group or an RGB hex value e.g. "#000000"
      background_colour = "Normal",

      -- Minimum width for notification windows
      minimum_width = 10,

      -- Icons for the different levels
      icons = {
        ERROR = Cange.get_icon("diagnostics.Error"),
        WARN = Cange.get_icon("diagnostics.Warn"),
        INFO = Cange.get_icon("diagnostics.Info"),
        DEBUG = Cange.get_icon("ui.Bug"),
        TRACE = Cange.get_icon("ui.Pencil"),
      },
    },
    config = function(_, opts)
      require("notify").setup(opts)
      require("telescope").load_extension("notify")

      vim.notify = function(msg, ...)
        if msg:match("character_offset must be called") or msg:match("method textDocument") then return end

        require("notify")(msg, ...)
      end
    end,
  },

  { -- Improve the built-in vim.ui interfaces with telescope, fzf, etc
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  { -- comment toggle
    "numToStr/Comment.nvim",
    dependencies = {
      -- contextual comment in embedded language files like Vue.JS
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },

  { "RRethy/vim-illuminate" }, -- Highlight the word under the cursor

  { -- text case converter (camel case, etc.,
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("textcase").setup()
      require("telescope").load_extension("textcase")
    end,
  },

  { -- close brackets, quotes etc
    "windwp/nvim-autopairs",
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
      local found_cmp, cmp = pcall(require, "cmp")
      if not found_cmp then return end

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  { -- indentation guides to all lines
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      enabled = true,
      buftype_exclude = { "terminal", "nofile" },
      filetype_exclude = { "help", "NvimTree", "Trouble", "text", "lazy" },
      char = Cange.get_icon("ui.VThinLineLeft"),
      context_char = Cange.get_icon("ui.VThinLineLeft"),
      show_current_context = true,
      show_current_context_start = true,
      use_treesitter = true,
    },
  },

  { -- Markdown preview
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    config = function()
      local peek = require("peek")

      peek.setup({ -- https://github.com/toppair/peek.nvim
        auto_load = true, -- whether to automatically load preview when entering another markdown buffer
        close_on_bdelete = true, -- close preview window on buffer delete
        syntax = true, -- enable syntax highlighting, affects performance
        theme = "dark", -- 'dark' or 'light'
        update_on_change = true,
        app = "browser", -- open in target 'webview', 'browser'
        -- relevant if update_on_change is true
        throttle_at = 200000, -- start throttling when file exceeds this amount of bytes in size
        throttle_time = "auto", -- minimum amount of time in milliseconds that has to pass before starting new render
      })

      local function toggle_markdown_preview()
        local method = peek.is_open() and "close" or "open"
        Cange.log(method, { title = "Markdown Preview - Peek" })
        peek[method]()
      end

      vim.keymap.set("n", "<leader>M", toggle_markdown_preview, { desc = "Toggle Markdown Preview" })
    end,
  },

  { -- easily jump to any location and enhanced f/t motions for Leap
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function()
      local leap = require("leap")

      leap.add_default_mappings()

      -- Getting used to `d` shouldn't take long - after all, it is more comfortable
      -- than `x`, and even has a better mnemonic.
      -- If you still desperately want your old `x` back, then just delete these
      -- mappings set by Leap:
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")

      -- fade out active search area
      vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
      leap.opts.highlight_unlabeled_phase_one_targets = true
    end,
  },

  -- smooth scrolling
  { "karb94/neoscroll.nvim", config = function() require("neoscroll").setup() end },

  -- Hex color highlighter
  { "norcalli/nvim-colorizer.lua", config = function() require("colorizer").setup() end },

  -- multi search and replace
  "mg979/vim-visual-multi",
}
