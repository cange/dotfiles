-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers

---List of LSP servers
---@type table<string, string>
local servers = {
  "eslint", -- javascript
  "html", -- html
  "tsserver", -- javascript, typepscript, etc.
  "sumneko_lua", -- lua
  "stylelint_lsp", -- stylelint
  "svelte", -- svelte
  "volar", --vue 3 and 2
}

return servers
