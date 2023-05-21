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
            package_installed = Cange.get_icon("ui.Check"),
            package_pending = Cange.get_icon("ui.Sync"),
            package_uninstalled = Cange.get_icon("ui.Close"),
          },
        },
        log_level = vim.log.levels.INFO,
        max_concurrent_installers = 4,
      })
      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = Cange.get_config("lsp.server_sources"),
      })
      local handler = require("cange.lsp").setup_handler
      require("mason-lspconfig").setup_handlers({ handler })
    end,
  },

  { -- formatters
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
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
      vim.api.nvim_create_user_command(
        "MasonInstallAll",
        function() vim.cmd("MasonInstall " .. table.concat(sources, " ")) end,
        {}
      )

      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/
      local nls = require("null-ls")
      local diagnostics = nls.builtins.diagnostics
      local code_actions = nls.builtins.code_actions
      local formatting = nls.builtins.formatting
      code_actions.typescript = require("typescript.extensions.null-ls.code-actions")

      nls.setup({
        update_in_insert = false, -- if false, diagnostics will run upon exiting insert mode
        sources = {
          code_actions.eslint_d, -- js
          code_actions.gitsigns, -- git
          code_actions.typescript,

          diagnostics.eslint_d,
          diagnostics.jsonlint,
          diagnostics.rubocop, -- ruby
          diagnostics.stylelint, -- css
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

  -- other language supports
  { "slim-template/vim-slim" }, -- slim language support (Vim Script,
  { "b0o/SchemaStore.nvim" }, -- json/yaml schema support
}
