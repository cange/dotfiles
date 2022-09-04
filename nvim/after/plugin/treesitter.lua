local tsconfigs_ok, tsconfigs = pcall(require, 'nvim-treesitter.configs')
if not tsconfigs_ok then return end

-- https://github.com/p00f/nvim-ts-rainbow#installation-and-setup
local rainbow_ok, _ = pcall(require, 'nvim-ts-rainbow')
local rainbow_settings = {}
if rainbow_ok then
  rainbow_settings.enable = true
  rainbow_settings.extended_mode = true -- highlight non-bracket tags like html
end

tsconfigs.setup({
  ensure_installed = 'all',  -- A list of parser names, or "all"
  ignore_install = {}, -- List of parsers to ignore installing (for "all")
  highlight = {
    enable = true,  -- `false` will disable the whole extension
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true, -- Indentation based on treesitter for the = operator
  },
  rainbow = rainbow_settings, -- enable parentheses rainbow highlighting
})

-- Enable tree-sitter based folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
