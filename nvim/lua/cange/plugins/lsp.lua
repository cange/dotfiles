local i = Cange.get_icon

return {
  { -- lspconfig
    "neovim/nvim-lspconfig", -- configure LSP servers
    event = { "BufReadPre", "BufNewFile" },
    config = function() require("cange.lsp").setup_diagnostics() end,
    -- stylua: ignore start
    keys = {
      { "<leader>d", vim.lsp.buf.type_definition,                                 desc = "LSP goto type Definition" },
      { "<leader>e4", "<cmd>LspInfo<CR>",                                         desc = "LSP info" },
      { "<leader>el", "<cmd>lua R('cange.lsp.toggle').format_on_save()<CR>",      desc = "Toggle format on save" },
      { "<leader>r", vim.lsp.buf.rename,                                          desc = "LSP Rename symbol" },
      { "<localleader>f", '<cmd>lua R("cange.lsp").format({ force = true })<CR>', desc = "Format" },
      { "]d", vim.diagnostic.goto_next,                                           desc = "Next Diagnostic" },
      { "[d", vim.diagnostic.goto_prev,                                           desc = "Prev Diagnostic" },
      { "<leader>ca", vim.lsp.buf.code_action,                                            desc = "Code actions/Quickfixes" },
      { "<leader>cd", "<cmd>lua R('cange.lsp.toggle').virtual_text()<CR>",                desc = "Toggle inline virtual text" },
      { "<leader>cr", "<cmd>LspRestart;<CR><cmd>lua Log:info('Restarted', 'LSP')<CR>",    desc = "LSP Restart" },
      { "gD", vim.lsp.buf.declaration,                                            desc = "LSP Goto symbol Declaration" },
      { "gd", vim.lsp.buf.definition,                                             desc = "LSP Goto symbol Definition" },
      { "gi", vim.lsp.buf.implementation,                                         desc = "LSP List symbol Implementation" },
      { "gr", "<cmd>Telescope lsp_references<CR>",                                desc = "LSP Symbol References" },
    },
    -- stylua: ignore end
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
    keys = {
      { "<leader>e2", "<cmd>Mason<CR>", desc = "Mason info" },
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
  },
}
