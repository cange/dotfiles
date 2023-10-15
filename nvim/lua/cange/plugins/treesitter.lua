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
  "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      { -- autoclose and autorename html tags
        "windwp/nvim-ts-autotag",
        config = function() require("nvim-ts-autotag").setup() end,
      },
      "HiPhish/nvim-ts-rainbow2",
      "JoosepAlviste/nvim-ts-context-commentstring", -- contextual comment in embedded language files like Vue.JS
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
        enable = true,
        enable_autocmd = false, -- enable commentstring support, when false
      },
      ensure_installed = sources, -- A list of parser names, or "all"
      highlight = { enable = true },
      indent = { enable = true }, -- Indentation based on treesitter for the = operator
      playground = { enable = true },
      rainbow = { enable = true },
    },
    main = "nvim-treesitter.configs",
  },
}
