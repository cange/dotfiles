local found, treesitter_config = pcall(require, 'nvim-treesitter.configs')
if not found then return end

-- https://github.com/p00f/nvim-ts-rainbow#installation-and-setup
local found_rainbo, _ = pcall(require, 'nvim-ts-rainbow')
if not found_rainbo then
  vim.notify('treesitter: "nvim-ts-rainbow" could not be found.')
  return
end

treesitter_config.setup({
  ensure_installed = 'all', -- A list of parser names, or 'all'
  ignore_install = {}, -- List of parsers to ignore installing (for 'all')
  highlight = {
    enable = true, -- `false` will disable the whole extension
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true, -- Indentation based on treesitter for the = operator
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- highlight non-bracket tags like html
    colors = {
      '#FF0000',
      '#0000FF',
      '#FFFF00',
      '#00FF00',
      '#00FFFF',
      '#FF00FF',
    }
  }
})

-- Enable tree-sitter based folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

