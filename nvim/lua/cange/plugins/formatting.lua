local sources = {
  -- Language servers
  "css-lsp",
  "dockerfile-language-server",
  "eslint-lsp",
  "html-lsp",
  "json-lsp",
  "lua-language-server",
  "stylelint-lsp",
  "svelte-language-server",
  "typescript-language-server",
  "vue-language-server",
  "yaml-language-server",

  -- Linting and formatting
  "beautysh", -- bash/zsh formatting
  "eslint_d",
  "jsonlint",
  "prettierd",
  "rubocop",
  "stylua",
  "yamllint",
  "zsh",
}

return {
  { -- formatters
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "jayp0521/mason-null-ls.nvim", -- bridges mason.nvim with the null-ls plugin
      "jose-elias-alvarez/typescript.nvim", -- enables LSP features for TS/JS
      "williamboman/mason.nvim",
    },
    config = function()
      -- https://github.com/jayp0521/mason-null-ls.nvim#default-configuration
      require("mason-null-ls").setup({
        automatic_installation = true,
        ensure_installed = sources,
      })

      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/
      local nls = require("null-ls")
      local diagnostics = nls.builtins.diagnostics
      local code_actions = nls.builtins.code_actions
      local formatting = nls.builtins.formatting
      code_actions.typescript = require("typescript.extensions.null-ls.code-actions")

      nls.setup({
        update_in_insert = false, -- if false, diagnostics will run upon exiting insert mode
        sources = {
          code_actions.typescript,

          diagnostics.jsonlint,
          diagnostics.rubocop, -- ruby
          diagnostics.yamllint,
          diagnostics.zsh,

          formatting.prettierd, -- js, css, html, json, etc
          formatting.rubocop, -- ruby
          formatting.beautysh.with({ extra_args = { "--indent-size", "2" } }), -- bash, zsh
          formatting.stylelint, -- css
          formatting.stylua, -- lua
        },
      })
    end,
  },
}
