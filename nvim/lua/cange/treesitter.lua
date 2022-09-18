--- Provides general settings
local M = {}

--- List of Treesitters support parsers
M.parsers = { ---- A list of parser names, or "all"
  'bash',
  'cmake',
  'css',
  'dart',
  'dockerfile',
  'elixir',
  'erlang',
  'gitattributes',
  'gitignore',
  'go',
  'graphql',
  'html',
  'http',
  'java',
  'javascript',
  'jsdoc',
  'json',
  'json5',
  'jsonc',
  'lua',
  'make',
  'markdown',
  'markdown_inline',
  'pug',
  'python',
  'query',
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
