local i = Cange.get_icon

return {
  { -- lspconfig
    "neovim/nvim-lspconfig", -- configure LSP servers
    event = { "BufReadPre", "BufNewFile" },
    config = function() require("cange.lsp").setup_diagnostics() end,
  },

  { -- managing & installing LSP servers, linters & formatters
    "williamboman/mason.nvim",
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
  },

  { -- loads main LSPs
    "williamboman/mason-lspconfig.nvim",
    dependencies = "williamboman/mason.nvim",
    opts = {
      automatic_installation = true,
      ensure_installed = {
        "bashls",
        "cssls",
        "html",
        "jsonls",
        "lemminx", -- xml, xsd, xsl, xslt, svg
        "ruby_ls",
        "svelte",
        "tsserver", -- javascript, typescript, etc.
        "volar", -- vue 3 and 2
        "yamlls",
      },
    },
    config = function() require("mason-lspconfig").setup_handlers({ require("cange.lsp").setup_handler }) end,
  },

  { -- loads LSP formatter and linter
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
    },
    opts = {
      ensure_installed = {
        "eslint_d",
        "jsonlint",
        "markdownlint",
        "prettierd",
        "rubocop",
        "stylelint",
        "stylua",
        "xmlformatter", -- svg
        "yamllint",
      },
      auto_update = true,
    },
  },

  { -- slim language support (Ruby)
    "slim-template/vim-slim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
  },

  { -- json/yaml schema support
    "b0o/SchemaStore.nvim",
    event = { "BufReadPre", "BufNewFile" },
  },

  {
    "simrat39/symbols-outline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    desc = "Symbol Browser",
    keys = {
      { "<localleader>O", "<cmd>SymbolsOutline<CR>", desc = "Toggle Symbole Browser" },
    },
    cmd = "SymbolsOutline",
    opts = function()
      local symbols = {}

      ---@diagnostic disable-next-line: param-type-mismatch
      for name, icon in pairs(i("cmp_kinds")) do
        symbols[name] = { icon = icon }
      end

      return {
        autofold_depth = 1,
        fold_markers = { i("ui.ChevronRight"), i("ui.ChevronDown") },
        show_symbol_details = false,
        symbols = symbols,
      }
    end,
    init = function()
      vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
        group = vim.api.nvim_create_augroup("before_symbol_browser_close", { clear = true }),
        desc = "Close symbol browser",
        command = "SymbolsOutlineClose",
      })
    end,
  },

  {
    dir = vim.fn.expand("~") .. "/.config/nvim/lua/specto",
    -- opts = { "TODO: establish a way to pass options" },
  },
}
