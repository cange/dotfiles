-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers

---List of LSP servers
---@type table<string, string>
local servers = {
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

return servers
