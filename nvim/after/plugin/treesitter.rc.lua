local ok, _ = pcall(require, 'nvim-treesitter')
if not ok then return end

require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    'bash',
    'css',
    'dockerfile',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'lua',
    'markdown',
    'ruby',
    'scss',
    'svelte',
    'tsx',
    'typescript',
    'vim',
    'vue',
    'yaml',
  },
  autotag = {
    enable = true,
  },
})
local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }
