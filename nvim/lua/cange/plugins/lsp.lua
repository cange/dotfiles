local i = Cange.get_icon
local servers = {
  "bashls",
  "cssls",
  "eslint",
  "html",
  "jsonls",
  "lemminx", -- xml, xsd, xsl, xslt, svg
  "lua_ls",
  "ruby_ls",
  "svelte",
  "tsserver", -- javascript, typescript, etc.
  "volar", -- vue 3 and 2
  "yamlls",
}
local formatters_and_linters = {
  "eslint_d",
  "jsonlint",
  "markdownlint",
  "prettierd",
  "rubocop",
  "stylelint",
  "stylua",
  "xmlformatter", -- svg
  "yamllint",
}

return {
  { -- auto install main LSPs
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "hrsh7th/cmp-nvim-lsp",
      { -- json/yaml schema support
        "b0o/SchemaStore.nvim",
        event = { "BufReadPre", "BufNewFile" },
      },
    },
    opts = {
      ensure_installed = servers,
      automatic_installation = true,
    },
  },

  { -- loads LSP formatter and linter
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
    },
    opts = {
      ensure_installed = formatters_and_linters,
      auto_update = true,
    },
  },

  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local config = require("cange.lsp").server_config
      for _, server in ipairs(servers) do
        local ok, server_config = pcall(require, "cange.lsp.server_configurations." .. server)
        if ok then config = vim.tbl_deep_extend("force", config, server_config) end

        require("lspconfig")[server].setup(config)
      end
      require("cange.lsp").update_diagnostics()

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

  {
    "cange/specto.nvim",
    lazy = false,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {},
    keys = {
      { "<LocalLeader>o", "<cmd>Specto toggle only<CR>", desc = "Toggle Only test block" },
      { "<LocalLeader>s", "<cmd>Specto toggle skip<CR>", desc = "Toggle Skip test block" },
    },
  },
}
