-- Contains table of language servers
-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
local lsp = {
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
}
local linter = {
  'shfmt', -- shell
  'prettier', -- javascript, typepscript, etc
  'luaformatter', -- lua
  -- 'rubocop', --ruby
  'yamlfmt', -- yaml
}
local formatter = {
  'stylua', -- lua
  'markdownlint', -- markdown
  'yamllint', -- yaml
}

return {
  lsp = lsp,
  linter = linter,
  formatter = formatter,
}
