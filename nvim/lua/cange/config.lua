local ns = "[cange.config]"
local config = {}

config["colorscheme.theme"] = "nightfox"
config["colorscheme.variant"] = "terafox"
config["author.display_name"] = "Christian"
config["lsp.diagnostic_virtual_text"] = true
config["lsp.format_on_save"] = true
config["lsp.server_sources"] = {
  "cssls", -- css
  "eslint", -- javascript
  "html", -- html
  "ruby_ls", -- ruby
  "sumneko_lua", -- lua
  "svelte", -- svelte
  "tsserver", -- javascript, typepscript, etc.
  "volar", --vue 3 and 2
  "yamlls", -- yaml
}
config["lsp.null_ls_sources"] = {
  "eslint_d",
  "jsonlint",
  "prettierd",
  "rubocop",
  "stylua",
  "yamllint",
  "zsh",
}
config["treesitter.sources"] = {
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

local M = {}

---@alias cange.config
---| '"lsp.diagnostic_virtual_text"' # Boolean to show or hide inline hint text
---| '"lsp.server_sources"' # List of LSP servers
---| '"lsp.format_on_save"' # Boolean to toggle on/off auto formatting on save
---| '"lsp.null_ls_sources"' # List of supported formatter, diagnostics servers
---| '"author.display_name"' # Name to personalise editor session
---| '"treesitter.sources"' # List of supported language parser
---| '"colorscheme.theme"' # Name of the theme library
---| '"colorscheme.variant"' # Variant name of theme

---Get certain config attributes
---@param key cange.config Path of a certain configuation key
---@return any Value of given key or nil if not found.
function M.get(key)
  local c = config[key]
  if c == nil then
    print(ns, 'of "' .. key .. '" key is not configured!')
  end
  return c
end

return M
