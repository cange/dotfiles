return {
  "nvim-treesitter/playground", -- inspect syntax node anatomy
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = Cange.get_config("treesitter.sources") or {}, -- A list of parser names, or "all"
      highlight = {
        enable = true, -- `false` will disable the whole extension
        additional_vim_regex_highlighting = true,
      },
      indent = {
        enable = true, -- Indentation based on treesitter for the = operator
      },
      rainbow = { -- https://github.com/p00f/nvim-ts-rainbow
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- highlight non-bracket tags like html
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings}
      },
      playground = { enable = true },
    })
  end,
}
