local ns = "cange.config"

-- Allows to configurate hidden items on a global stage.
---@class cange.Config
---@field "lsp.diagnostic.virtual_text" boolean Shows inline hint text if true
---@field "lsp.server.sources" table List of LSP servers
---@field "lsp.null_ls.sources" table List of supported formatter, diagnostics
---@field "treesitter.sources" table List of supported language parser

local config = {}
config["lsp.diagnostic.virtual_text"] = true
config["lsp.server.sources"] = {
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
config["lsp.null_ls.sources"] = {
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

---Get certain config attributes
---
---@param key ("lsp.diagnostics.virtual_text"|"lsp.server.sources"|"lsp.null_ls.sources"|"treesitter.sources") Path of a certain configguation key
---@return any Value of given key or nil if not found.
function M.get_config(key)
  local c = config[key] or nil
  if not c then
    print("[" .. ns .. "] of " .. key .. " key is not configured!")
  end
  return c
end

return M
