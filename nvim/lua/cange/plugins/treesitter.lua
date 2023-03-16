return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    config = function()
      require("nvim-treesitter.configs").setup({
        context_commentstring = { enable = true },
        ensure_installed = Cange.get_config("treesitter.sources") or {}, -- A list of parser names, or "all"
        highlight = {
          enable = true, -- `false` will disable the whole extension
          additional_vim_regex_highlighting = true,
        },
        indent = { enable = true }, -- Indentation based on treesitter for the = operator
        rainbow = { -- https://github.com/p00f/nvim-ts-rainbow
          enable = true,
          extended_mode = true, -- highlight non-bracket tags like html
          max_file_lines = nil, -- Do not enable for files with more than n lines, int
        },
        playground = { enable = true },
      })
    end,
  },

  { "mrjones2014/nvim-ts-rainbow", dependencies = { "nvim-treesitter/nvim-treesitter" } }, -- Rainbow parentheses

  { -- contextual comment in embedded language files like Vue.JS
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = true,
  },

  { -- autoclose and autorename html tags
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function() require("nvim-ts-autotag").setup() end,
  },
}
