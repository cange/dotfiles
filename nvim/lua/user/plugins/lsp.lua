return {
  { -- managing & installing LSP servers, linters & formatters
    "williamboman/mason.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    opts = {
      ui = {
        border = User.get_config("ui.border"),
        icons = {
          package_installed = Icon.ui.Check,
          package_pending = Icon.ui.Sync,
          package_uninstalled = Icon.ui.Close,
        },
      },
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 4,
    },
    keys = { { "<Leader>e2", "<cmd>Mason<CR>", desc = "Mason info" } },
    config = function(_, opts)
      require("mason").setup(opts)
      -- loads formatter and linter
      local linter = { "eslint", "jsonlint", "markdownlint", "markuplint", "rubocop", "stylelint", "yamllint" }
      local formatter = { "prettier", "rubocop", "shfmt", "stylua", "superhtml" }
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
      local lspconfig = require("lspconfig")
      vim.g.markdown_fenced_languages = { "ts=typescript" } -- appropriately highlight codefences returned from denols,
      local ts_ls_settings = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        },
        implementationsCodeLens = { enabled = true },
        referencesCodeLens = { enabled = true },
        suggestionActions = { enabled = true },
      }
      local server_configs = {
        astro = {},
        cssls = {
          settings = {
            css = { lint = { unknownAtRules = "ignore" } },
            scss = { lint = { unknownAtRules = "ignore" } },
          },
        },
        denols = {
          -- prevent ts_ls and denols are attached to current buffer
          -- https://docs.deno.com/runtime/getting_started/setup_your_environment/
          root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
        },
        html = {},
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
        ts_ls = { -- javascript, typescript, etc.
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ts_ls
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
            typescript = ts_ls_settings,
            javascript = ts_ls_settings,
          },
          -- prevent ts_ls and denols are attached to current buffer
          root_dir = lspconfig.util.root_pattern("package.json"),
          single_file_support = false,
        },
        volar = { -- vue
          -- NOTE: not needed to configure if using @vue/typescript-plugin
          -- but required for CSS support in single file components
          -- and
          -- silents: `Client volar quit with exit code 1 and signal 0...`
          init_options = {
            typescript = {
              tsdk = mason_registry.get_package("typescript-language-server"):get_install_path()
                .. "/node_modules/typescript/lib",
            },
          },
          filetypes = { "vue" },
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
      local default_config = require("user.lsp").server_config

      for server, server_config in pairs(server_configs) do
        local config = vim.tbl_deep_extend("force", default_config, server_config)
        require("lspconfig")[server].setup(config)
      end

      require("user.lsp").update_diagnostics()
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(server_configs),
        automatic_installation = true,
      })
    end,
    -- stylua: ignore
    keys = require("user.lsp").keymaps,
  },

  { -- Extensible UI notifications and LSP progress messages.
    "j-hui/fidget.nvim",
    opts = {
      progress = { display = { done_icon = Icon.ui.Check } },
      notification = { window = { winblend = 0 } },
    },
  },

  "slim-template/vim-slim",
}
