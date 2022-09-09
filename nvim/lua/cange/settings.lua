-- This file contains general settings
M = {}

M.lsp = {
  -- Contains table of language servers
  -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
  providers = {
    lsp = {
      -- 'solargraph', -- ruby
      'emmet_ls', -- html
      'bashls', -- bash
      'cssls', -- css
      'cssmodules_ls', -- css
      'tailwindcss', -- css
      'cucumber_language_server' , -- cucumber, ruby
      'dockerls' , -- docker
      'eslint' , -- javascript
      'html' , -- html
      'tsserver' , -- javascript, typepscript, etc.
      'jsonls', -- json
      'sumneko_lua', -- lua
      'marksman', -- markdown
      'stylelint_lsp', -- stylelint
      'svelte', -- svelte
      'vimls', -- vim
      'vuels', -- vue
      'volar', --vue 3
      'yamlls' , -- yaml
    },
    linter = {
      'eslint_d' , -- javascript
      'shfmt', -- shell
      'prettier', -- javascript, typepscript, etc
      'luaformatter', -- lua
      -- 'rubocop', --ruby
      'yamlfmt', -- yaml
    },
    formatter = {
      'stylua', -- lua
      'markdownlint', -- markdown
      'yamllint', -- yaml
    },
  },
}

-- Treesitter parser list_extend
M.treesitter = {
  parsers = { ---- A list of parser names, or "all"
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
    'yaml'
  }
}

-- formatter
M.prettier = {
  filetypes = {
    'css',
    'graphql',
    'html',
    'javascript',
    'javascriptreact',
    'json',
    'less',
    'markdown',
    'scss',
    'typescript',
    'typescriptreact',
    'vue',
    'yaml',
  },
}

return M
