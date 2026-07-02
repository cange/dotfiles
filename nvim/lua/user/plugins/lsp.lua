return {
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "b0o/SchemaStore.nvim",
      "mason-org/mason.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      vim.g.markdown_fenced_languages = { "ts=typescript" } -- appropriately highlight codefences returned from denols,

      local servers = {
        -- see also /lsp/
        lua_ls = {}, --[[ see lsp/]]
        -- CSS
        css_variables = { filetypes = { "css", "scss", "vue", "eruby" } },
        cssls = {},
        tailwindcss = {},

        -- ruby
        herb_ls = {},
        ruby_lsp = {},
        stimulus_ls = {},

        -- JavaScript / TypeScript, etc.
        vtsls = {},--[[ see lsp/]]
        ts_ls = {}, --[[ see lsp/]]
        vue_ls = {},

        -- misc
        eslint = {},
        html = {},
        markdown_oxide = {},
        jsonls = {}, --[[ see lsp/]]
        yamlls = {}, --[[ see lsp/]]
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      --Enable (broadcasting) snippet capability for completion
      capabilities.textDocument.completion.completionItem.snippetSupport = true
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

  { -- managing & installing LSP servers, linters & formatters
    "mason-org/mason.nvim",
    dependencies = {
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
      local linter = {
        "eslint",
        "jsonlint",
        "markdown_oxide",
        "markuplint",
        "stylelint",
        "yamllint",
      }
      local formatter = {
        "prettier",
        "shfmt",
        "stylua",
        "html",
      }
      require("mason-tool-installer").setup({
        -- loads formatter and linter
        ensure_installed = vim.list_extend(vim.list_extend({}, linter), formatter),
        auto_update = true,
      })
    end,
  },
}
