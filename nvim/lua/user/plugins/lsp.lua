--- Prefer this to `get_package`, since the package might not always be
--- available yet and trigger errors.
---@param pkg string
---@param path string
local function get_pkg_path(pkg, path)
  pcall(require, "mason") -- make sure Mason is loaded. Will fail when generating docs
  local root = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
  local pkg_path = root .. "/packages/" .. pkg .. "/" .. path

  if not vim.loop.fs_stat(pkg_path) then
    vim.notify(
      ("Package path not found for **%s**:\n- `%s`\nForce update the package."):format(pkg, path),
      vim.log.levels.INFO
    )
  end
  return pkg_path
end
local user_lsp = {}
user_lsp.ts_ls_settings = {
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

return {
  { -- managing & installing LSP servers, linters & formatters
    "mason-org/mason.nvim",
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
        ensure_installed = vim.tbl_extend("force", {}, linter, formatter),
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
      "mason-org/mason-lspconfig.nvim",
      "mason-org/mason.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      vim.g.markdown_fenced_languages = { "ts=typescript" } -- appropriately highlight codefences returned from denols,

      local servers = {
        cssls = {
          settings = {
            css = { lint = { unknownAtRules = "ignore" } },
            scss = { lint = { unknownAtRules = "ignore" } },
          },
        },
        html = {},
        eslint = {},
        ruby_lsp = {},
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
        -- javascript, typescript, etc.
        ts_ls = {
          -- ensure that workspace config files are used
          root_dir = require("lspconfig").util.root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git"),
          init_options = {
            preferences = { disableSuggestions = true },
            completions = { completeFunctionCalls = true },
          },
          settings = {
            typescript = user_lsp.ts_ls_settings,
            javascript = user_lsp.ts_ls_settings,
          },
        },
        vtsls = {
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#vtsls
          settings = {
            vtsls = {
              tsserver = {
                globalPlugins = {
                  {
                    name = "@vue/typescript-plugin",
                    location = get_pkg_path("vue-language-server", "node_modules/@vue/language-server"),
                    languages = { "vue" },
                    configNamespace = "typescript",
                  },
                },
              },
            },
          },
          filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        },
        vue_ls = {},
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

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      for server, cfg in pairs(servers) do
        cfg.on_attach = require("user.lsp").set_keymaps
        cfg.capabilities = vim.tbl_deep_extend("force", {}, capabilities, cfg.capabilities or {})
        vim.lsp.config(server, cfg)
        vim.lsp.enable(server)
      end

      require("user.lsp").update_diagnostics()
      require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(servers) })
    end,
    -- stylua: ignore
    keys = require("user.lsp").keymaps,
  },

  { -- Extensible UI notifications and LSP progress messages.
    "j-hui/fidget.nvim",
    opts = {
      progress = {
        display = {
          done_icon = Icon.ui.Check,
          progress_icon = { "arc" },
        },
      },
      notification = { window = { winblend = 0 } },
    },
  },
}
