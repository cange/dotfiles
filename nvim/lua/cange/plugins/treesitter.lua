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
      ensure_installed = Cange.get_config("treesitter.sources") or {}, -- A list of parser names, or "all"
      highlight = { enable = true },
      indent = { enable = true }, -- Indentation based on treesitter for the = operator
      playground = { enable = true },
      rainbow = { enable = true },
    },
    ---@param opts TSConfig
    config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
  },
}
