local icons = require("cange.icons")

return {
  { -- managing & installing LSP servers, linters & formatters
    "williamboman/mason.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    opts = {
      ui = {
        border = Cange.get_config("ui.border"),
        icons = {
          package_installed = icons.ui.Check,
          package_pending = icons.ui.Sync,
          package_uninstalled = icons.ui.Close,
        },
      },
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 4,
    },
    keys = { { "<leader>e2", "<cmd>Mason<CR>", desc = "Mason info" } },
    config = function(_, opts)
      require("mason").setup(opts)
      -- loads formatter and linter
      local linter = { "eslint", "jsonlint", "markdownlint", "rubocop", "stylelint", "yamllint" }
      local formatter = { "prettier", "rubocop", "shfmt", "stylua", "xmlformatter" }
      require("mason-tool-installer").setup({
        ensure_installed = vim.tbl_extend("force", linter, formatter),
        auto_update = true,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "b0o/SchemaStore.nvim",
      "williamboman/mason-lspconfig.nvim", -- auto install main LSPs
      "williamboman/mason.nvim",
    },
    config = function()
      local mason_registry = require("mason-registry")
      local server_configs = {
        cssls = {
          settings = {
            css = { lint = { unknownAtRules = "ignore" } },
            scss = { lint = { unknownAtRules = "ignore" } },
          },
        },
        html = {},
        lemminx = {}, -- xml, xsd, xsl, xslt, svg
        ruby_lsp = {},
        tailwindcss = {},
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              workspace = {
                library = {
                  -- Make the server aware of Neovim runtime files
                  [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                  [vim.fn.stdpath("config") .. "/lua"] = true,
                },
              },
              telemetry = { enable = false },
            },
          },
        },
        tsserver = { -- javascript, typescript, etc.
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
          init_options = {
            preferences = { disableSuggestions = true },
            completions = { completeFunctionCalls = true },
            plugins = {
              { -- vue setup with hybridMode:
                -- https://github.com/vuejs/language-tools/blob/master/README.md#hybrid-mode-configuration-requires-vuelanguage-server-version-200
                -- NOTE: It is crucial to ensure that @vue/typescript-plugin and volar are of identical versions.
                -- check `npm list -g`
                -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#vue-support
                name = "@vue/typescript-plugin",
                location = mason_registry.get_package("vue-language-server"):get_install_path()
                  .. "/node_modules/@vue/language-server",
                languages = {
                  "javascript",
                  "javascript.jsx",
                  "javascriptreact",
                  "json",
                  "typescript",
                  "typescript.tsx",
                  "typescriptreact",
                  "vue",
                },
              },
            },
          },
          -- filetypes is extended here to include Vue SFC
          filetypes = {
            "javascript",
            "javascript.jsx",
            "javascriptreact",
            "json",
            "typescript",
            "typescript.tsx",
            "typescriptreact",
            "vue",
          },
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all", --'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all", --'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        volar = { -- vue
          -- NOTE: not needed to configure if using @vue/typescript-plugin
        },
        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                -- You must disable built-in schemaStore support if you want to use
                -- this plugin and its advanced options like `ignore`.
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
              },
              schemas = require("schemastore").yaml.schemas(),
            },
          },
        },
      }
      local default_config = require("cange.lsp").server_config

      for server, server_config in pairs(server_configs) do
        local config = vim.tbl_deep_extend("force", default_config, server_config)

        require("lspconfig")[server].setup(config)
      end

      require("cange.lsp").update_diagnostics()
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(server_configs),
        automatic_installation = true,
      })

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = Cange.get_config("ui.border"),
        title = "Hover",
      })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = Cange.get_config("ui.border"),
        title = "Signature Help",
      })
    end,
    -- stylua: ignore
    keys = require("cange.lsp").keymaps,
  },

  { -- Extensible UI notifications and LSP progress messages.
    "j-hui/fidget.nvim",
    opts = {
      progress = { display = { done_icon = icons.ui.Check } },
      notification = { window = { winblend = 0 } },
    },
  },

  "slim-template/vim-slim",
}
