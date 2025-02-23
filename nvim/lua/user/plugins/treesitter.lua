local sources = {
  "bash",
  "css",
  "diff",
  "dockerfile",
  "elixir",
  "gitignore",
  "html",
  "javascript",
  "jsdoc",
  "json",
  "luadoc",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "ruby",
  "rust",
  "scss",
  "svelte",
  "toml",
  "tsx",
  "typescript",
  "vimdoc",
  "vue",
  "xml",
  "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      ensure_installed = sources, -- A list of parser names, or "all"
      textobjects = {
        select = {
          enable = true,
          -- lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["ac"] = { query = "@class.outer", desc = "Outer class" },
            ["ic"] = { query = "@class.inner", desc = "Inner class" },
            ["af"] = { query = "@function.outer", desc = "Outer function" },
            ["if"] = { query = "@function.inner", desc = "Inner function" },
          },
        },
      },
      context_commentstring = {
        enable_autocmd = false, -- enable commentstring support, when false
      },
      highlight = { enable = true },
      indent = { enable = true }, -- Indentation based on treesitter for the = operator
    },
    main = "nvim-treesitter.configs",
  },

  { -- autoclose and autorename html tags
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function() require("nvim-ts-autotag").setup() end,
  },

  {
    -- contextual comment in embedded language files like Vue.JS
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    init = function()
      -- enable native commenting https://github.com/JoosepAlviste/nvim-ts-context-commentstring/wiki/Integrations#native-commenting-in-neovim-010
      local get_option = vim.filetype.get_option
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.filetype.get_option = function(filetype, option)
        return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
          or get_option(filetype, option)
      end
    end,
  },

  {
    "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
      },
      blacklist = { "vue" },
    },
    config = function(_, opts) require("rainbow-delimiters.setup").setup(opts) end,
  },

  { -- testing toggle util
    "cange/specto.nvim",
    version = "v0.3.1",
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
          "harpoon",
          "help",
          "lazy",
          "mason",
        },
      },
    },
    keys = {
      { "<LocalLeader>o", "<cmd>Specto toggle only<CR>", desc = "Toggle [only] test" },
      { "<LocalLeader>s", "<cmd>Specto toggle skip<CR>", desc = "Toggle [skip] test" },
      { "<LocalLeader>t", "<cmd>Specto toggle todo<CR>", desc = "Toggle [todo] test" },
    },
  },
}
