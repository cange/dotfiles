---@alias cange.config
---| '"lsp.diagnostic_virtual_text"' # Boolean to show or hide inline hint text
---| '"lsp.server_sources"' # List of LSP servers
---| '"lsp.format_on_save"' # Boolean to toggle on/off auto formatting on save
---| '"lsp.null_ls_sources"' # List of supported formatter, diagnostics servers
---| '"author.display_name"' # Name to personalise editor session
---| '"treesitter.sources"' # List of supported language parser
---| '"colorscheme.theme"' # Name of the theme library
---| '"colorscheme.variant"' # Variant name of theme
--
local M = {}

M["colorscheme.theme"] = "nightfox"
M["colorscheme.variant"] = "terafox"
M["author.display_name"] = "Christian"
M["lsp.diagnostic_virtual_text"] = true
M["lsp.format_on_save"] = true
M["lsp.server_sources"] = {
  "cssls", -- css
  "eslint", -- javascript
  "html", -- html
  "ruby_ls", -- ruby
  "sumneko_lua", -- lua
  "svelte", -- svelte
  "tsserver", -- javascript, typescript, etc.
  "volar", --vue 3 and 2
  "yamlls", -- yaml
}
M["lsp.null_ls_sources"] = {
  "eslint_d",
  "jsonlint",
  "prettierd",
  "rubocop",
  "stylua",
  "yamllint",
  "zsh",
}
M["treesitter.sources"] = {
  "bash",
  "css",
  "dockerfile",
  "elixir",
  "gitattributes",
  "gitignore",
  "go",
  "javascript",
  "json",
  "html",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "python",
  "regex",
  "ruby",
  "rust",
  "scss",
  "svelte",
  "tsx",
  "typescript",
  "vue",
  "yaml",
}

return M
