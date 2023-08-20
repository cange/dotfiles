local sources = {
  "bash",
  "css",
  "dockerfile",
  "elixir",
  "gitattributes",
  "gitignore",
  "go",
  "html",
  "javascript",
  "json",
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
      { -- contextual comment in embedded language files like Vue.JS
        "JoosepAlviste/nvim-ts-context-commentstring",
      },
      { "HiPhish/nvim-ts-rainbow2" },
    },
    opts = {
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
    ---@param opts TSConfig
    config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
  },
}
