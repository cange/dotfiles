local sources = {
  "bash",
  "css",
  "diff",
  "dockerfile",
  "elixir",
  "gitattributes",
  "gitignore",
  "html",
  "javascript",
  "json",
  "jsdoc",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "python",
  "regex",
  "ruby",
  "rust",
  "scss",
  "svelte",
  "toml",
  "tsx",
  "typescript",
  "vue",
  "vimdoc",
  "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/playground",
    },
    opts = {
      textobjects = {
        select = {
          enable = true,
          -- lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["ac"] = { query = "@class.outer", desc = "Select outer class" },
            ["ic"] = { query = "@class.inner", desc = "Select inner class" },
            ["af"] = { query = "@function.outer", desc = "Select outer function" },
            ["if"] = { query = "@function.inner", desc = "Select inner function" },
            ["ii"] = { query = "@conditional.inner", desc = "Select inner conditional" },
            ["ai"] = { query = "@conditional.outer", desc = "Select outer conditional" },
            ["il"] = { query = "@loop.inner", desc = "Select inner loop" },
            ["al"] = { query = "@loop.outer", desc = "Select outer loop" },
          },
        },
      },
      autotag = { enable = true },
      context_commentstring = {
        enable_autocmd = false, -- enable commentstring support, when false
      },
      ensure_installed = sources, -- A list of parser names, or "all"
      highlight = { enable = true },
      indent = { enable = true }, -- Indentation based on treesitter for the = operator
      playground = { enable = true },
    },
    main = "nvim-treesitter.configs",
  },

  { -- autoclose and autorename html tags
    "windwp/nvim-ts-autotag",
    opts = {},
    config = function(_, opts) require("nvim-ts-autotag").setup(opts) end,
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
          "harpoon",
          "help",
          "lazy",
          "mason",
        },
      },
    },
    keys = {
      { "<LocalLeader>o", "<cmd>Specto toggle only<CR>", desc = "Toggle Only test block" },
      { "<LocalLeader>s", "<cmd>Specto toggle skip<CR>", desc = "Toggle Skip test block" },
    },
  },
}
