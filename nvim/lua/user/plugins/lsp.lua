local user_lsp = {}

--- Gets a path to a package in the Mason registry.
--- Prefer this to `get_package`, since the package might not always be
--- available yet and trigger errors.
---@param pkg string
---@param path? string
function user_lsp.get_pkg_path(pkg, path)
  pcall(require, "mason") -- make sure Mason is loaded. Will fail when generating docs
  local uv = vim.uv
  local root = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
  path = path or ""
  local ret = root .. "/packages/" .. pkg .. path
  if not uv.fs_stat(ret) then
    local msg = ("Mason package path not found for **%s**:\n- `%s`\nYou may need to force update the package."):format(
      pkg,
      path
    )
    vim.notify(msg, vim.log.levels.DEBUG, { title = "Mason" })
  end
  return ret
end

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

-- Hybrid mode configuration (Requires @vue/language-server version ^2.0.0)
user_lsp.vue = {
  ts_ls = {
    filetypes = { "typescript", "javascript", "vue" },
    init_options = {
      plugins = {
        {
          -- NOTE: vue_ls setup with hybridMode:
          -- The Vue Language Server exclusively manages the CSS/HTML sections.
          -- As a result, you must run @vue/language-server in conjunction
          -- with a TypeScript server that employs @vue/typescript-plugin.
          -- see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#vue-support
          name = "@vue/typescript-plugin",
          location = user_lsp.get_pkg_path("vue-language-server", "/node_modules/@vue/language-server"),
          -- location = user_lsp.get_pkg_path("vue-language-server", "/node_modules/@vue/typescript-plugin"),
          languages = { "javascript", "typescript", "vue" },
        },
      },
    },
  },
  vue_ls = {
    init_options = {
      typescript = {
        -- vue_ls needs to know the typescript SDK location
        tsdk = user_lsp.get_pkg_path("typescript-language-server", "/node_modules/typescript/lib"),
      },
    },
  },
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
      "mason-org/mason-lspconfig.nvim",
      "mason-org/mason.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      vim.g.markdown_fenced_languages = { "ts=typescript" } -- appropriately highlight codefences returned from denols,

      local server_configs = {
        astro = {},
        cssls = {
          settings = {
            css = { lint = { unknownAtRules = "ignore" } },
            scss = { lint = { unknownAtRules = "ignore" } },
          },
        },
        -- denols = {
        --   -- prevent ts_ls and denols are attached to current buffer
        --   -- https://docs.deno.com/runtime/getting_started/setup_your_environment/
        --   root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
        -- },
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
        -- javascript, typescript, etc.
        ts_ls = vim.tbl_deep_extend("force", {
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ts_ls
          init_options = {
            preferences = { disableSuggestions = true },
            completions = { completeFunctionCalls = true },
          },
          -- filetypes is extended here to include Vue SFC
          -- filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
          settings = {
            typescript = user_lsp.ts_ls_settings,
            javascript = user_lsp.ts_ls_settings,
          },
          -- prevent ts_ls and denols are attached to current buffer
          root_dir = lspconfig.util.root_pattern("package.json"),
          -- single_file_support = false, // TODO: why SFC false
        }, user_lsp.vue.ts_ls),
        vue_ls = user_lsp.vue.vue_ls,
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

      for server, config in pairs(server_configs) do
        local server_config = vim.tbl_deep_extend("force", default_config, config)
        -- TODO: figure out how native vim.lsp.config works (using it does not
        -- allow renaming etc.)
        -- vim.lsp.config(server, server_config)
        -- vim.lsp.enable(server)
        lspconfig[server].setup(server_config)
      end

      require("user.lsp").update_diagnostics()
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(server_configs),
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
