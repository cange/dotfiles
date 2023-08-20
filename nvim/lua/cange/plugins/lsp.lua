local i = Cange.get_icon
local server_sources = {
  "bashls", -- bash
  "cssls", -- css
  "html", -- html
  "jsonls", -- json
  "ruby_ls", -- ruby
  "svelte", -- svelte
  "tsserver", -- javascript, typescript, etc.
  "volar", -- vue 3 and 2
  "yamlls", -- yaml
}

return {
  { -- lspconfig
    "neovim/nvim-lspconfig", -- configure LSP servers
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim", -- managing & installing LSP servers, linters & formatters
      "williamboman/mason-lspconfig.nvim", -- bridges mason.nvim with the lspconfig plugin
    },
    config = function()
      require("cange.lsp").setup_diagnostics()
      require("mason").setup({
        ui = {
          border = Cange.get_config("ui.border"),
          icons = {
            package_installed = i("ui.Check"),
            package_pending = i("ui.Sync"),
            package_uninstalled = i("ui.Close"),
          },
        },
        log_level = vim.log.levels.INFO,
        max_concurrent_installers = 4,
      })
      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = server_sources,
      })
      local handler = require("cange.lsp").setup_handler
      require("mason-lspconfig").setup_handlers({ handler })
    end,
  },

  -- other language supports
  { "slim-template/vim-slim" }, -- slim language support (Vim Script,
  { "b0o/SchemaStore.nvim" }, -- json/yaml schema support
}
