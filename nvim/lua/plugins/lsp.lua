return {
  { -- lspconfig
    "neovim/nvim-lspconfig", -- configure LSP servers
    event = "BufReadPre",
    dependencies = {
      "williamboman/mason-lspconfig.nvim", -- bridges mason.nvim with the lspconfig plugin
      "williamboman/mason.nvim", -- managing & installing LSP servers, linters & formatters
    },
    config = function()
      Cange.reload("cange.lsp.diagnostics")
      Cange.reload("cange.lsp.lspconfig")

      require("mason").setup({
        ui = {
          border = Cange.get_config("ui.border"),
          icons = Cange.get_icon("mason"),
        },
        log_level = vim.log.levels.INFO,
        max_concurrent_installers = 4,
      })

      -- https://github.com/williamboman/mason-lspconfig.nvim#default-configuration
      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = Cange.get_config("lsp.server_sources"),
      })
    end,
  },

  { -- formatters
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = {
      "jayp0521/mason-null-ls.nvim", -- bridges mason.nvim with the null-ls plugin
      "jose-elias-alvarez/null-ls.nvim", -- syntax formatting, diagnostics (dependencies npm pacakges)
      "jose-elias-alvarez/typescript.nvim", -- enables LSP features for TS/JS
      "williamboman/mason.nvim",
    },
    config = function()
      -- https://github.com/jayp0521/mason-null-ls.nvim#default-configuration
      local sources = Cange.get_config("lsp.null_ls_sources")
      require("mason-null-ls").setup({
        automatic_installation = true,
        ensure_installed = sources,
      })

      -- Install all necessary packages at once
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(sources, " "))
      end, {})

      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/
      local nls = require("null-ls")
      local diagnostics = nls.builtins.diagnostics
      local code_actions = nls.builtins.code_actions
      local formatting = nls.builtins.formatting

      nls.setup({
        update_in_insert = false, -- if false, diagnostics will run upon exiting insert mode
        sources = {
          -- js, ts, vue, css, html, json, yaml, md etc.
          formatting.prettierd,

          -- js
          code_actions.eslint_d,
          formatting.eslint_d,
          require("typescript.extensions.null-ls.code-actions"),

          -- css
          diagnostics.stylelint,
          formatting.stylelint,

          -- json
          diagnostics.jsonlint,

          -- lua
          formatting.stylua,

          -- ruby
          diagnostics.rubocop,
          formatting.rubocop,

          diagnostics.yamllint,
          diagnostics.zsh,
        },
      })
    end,
  },

  -- other language supports
  { "slim-template/vim-slim" }, -- slim language support (Vim Script,
  { "b0o/SchemaStore.nvim" }, -- json/yaml schema support
}
