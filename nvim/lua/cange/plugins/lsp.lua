local i = Cange.get_icon

return {
  { -- managing & installing LSP servers, linters & formatters
    "williamboman/mason.nvim",
    dependencies = "neovim/nvim-lspconfig",
    opts = {
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
    },
    keys = { { "<leader>e2", "<cmd>Mason<CR>", desc = "Mason info" } },
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
      local util = require("lspconfig.util")
      local function get_typescript_server_path(root_dir)
        local global_ts = vim.fn.expand("$HOME")
          .. "/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib"
        local found_ts = ""
        local function check_dir(path)
          found_ts = path .. "/node_modules/typescript/lib"
          if util.path.exists(found_ts) then return path end
        end
        if util.search_ancestors(root_dir, check_dir) then
          return found_ts
        else
          return global_ts
        end
      end

      local server_configs = {
        cssls = {},
        eslint = {
          settings = {
            -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
            workingDirectories = { mode = "auto" },
          },
        },
        html = {},
        lemminx = {}, -- xml, xsd, xsl, xslt, svg
        ruby_ls = {},
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
          init_options = {
            preferences = {
              disableSuggestions = true,
            },
            completions = {
              completeFunctionCalls = true,
            },
          },
        },
        volar = { -- vue 3 and 2
          -- enable typescript Take Over Mode
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#volar
          filetypes = { "vue" },
          on_new_config = function(new_config, new_root_dir)
            new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
          end,
        },
        jsonls = {
          settings = {
            json = { schemas = require("schemastore").json.schemas() },
            validate = { enable = true },
          },
        },
        yamlls = {
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              schemaStore = {
                enable = true,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
              },
              schemas = require("schemastore").yaml.schemas({
                extra = {
                  {
                    description = "Definition of Visables pattern lib documentation data",
                    fileMatch = {
                      "**/wlw_styleguide/**/documentation.yml",
                      "**/wlw_styleguide/**/documentation.yaml",
                    },
                    name = "wlw styleguide",
                    url = vim.fn.expand("file://$HOME/workspace/services/wlw_styleguide/schemas/docs.schema.json"),
                  },
                },
              }),
            },
            validate = { enable = true },
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
      progress = {
        display = {
          done_icon = i("ui.Check"),
        },
      },
    },
  },

  "slim-template/vim-slim",
}
