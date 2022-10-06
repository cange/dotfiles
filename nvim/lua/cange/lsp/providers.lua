--- Provides general settings
--- Lists of providers for certain language_server, linter, and formatter
local M = {}

-- Contains table of language servers
-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
M.language_servers = {
  -- 'solargraph', -- ruby
  "emmet_ls", -- html
  "cssls", -- css
  "cssmodules_ls", -- css
  "dockerls", -- docker
  "eslint", -- javascript
  "html", -- html
  "tsserver", -- javascript, typepscript, etc.
  "jsonls", -- json
  "sumneko_lua", -- lua
  "marksman", -- markdown
  "stylelint_lsp", -- stylelint
  "svelte", -- svelte
  "vuels", -- vue
  -- 'volar', --vue 3
  "yamlls", -- yaml
}

M.linters = {
  "eslint_d", -- javascript
  "shfmt", -- shell
  "prettier", -- javascript, typepscript, etc
  "luaformatter", -- lua
  -- 'rubocop', --ruby
  "yamlfmt", -- yaml
}

M.formatters = {
  "stylua", -- lua
  "markdownlint", -- markdown
  "yamllint", -- yaml
}

return M
