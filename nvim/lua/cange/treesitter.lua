--- Provides general settings
local M = {}

--- List of Treesitters support parsers
M.parsers = { ---- A list of parser names, or "all"
  'bash',
  'css',
  'dockerfile',
  'elixir',
  'gitattributes',
  'gitignore',
  'go',
  'html',
  'http',
  'javascript',
  'jsdoc',
  'json',
  'json5',
  'jsonc',
  'lua',
  'make',
  'markdown',
  'markdown_inline',
  'python',
  'regex',
  'ruby',
  'scss',
  'sql',
  'svelte',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vue',
  'yaml',
}

return M
