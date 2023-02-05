return {
  { -- Language Server Protocol
    "neovim/nvim-lspconfig", -- configure LSP servers
    dependencies = {
      "jayp0521/mason-null-ls.nvim", -- bridges mason.nvim with the null-ls plugin
      "jose-elias-alvarez/null-ls.nvim", -- syntax formatting, diagnostics (dependencies npm pacakges)
      "jose-elias-alvarez/typescript.nvim", -- enables LSP features for TS/JS
      "williamboman/mason-lspconfig.nvim", -- bridges mason.nvim with the lspconfig plugin
      "williamboman/mason.nvim", -- managing & installing LSP servers, linters & formatters
    },
    config = function()
      Cange.reload("cange.lsp")
    end,
  },

  { "slim-template/vim-slim" }, -- slim language support (Vim Script,

  { "b0o/SchemaStore.nvim" }, -- json/yaml schema support
}
