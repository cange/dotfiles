local i = Cange.get_icon

---@return table
local function symbol_outline_icons()
  ---@type table
  ---@diagnostic disable-next-line: assign-type-mismatch
  local icons = i("cmp_kinds")
  local symbols = {}

  for name, icon in pairs(icons) do
    symbols[name] = { icon = icon }
  end

  return symbols
end

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
    dependencies = "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint_d",
        "jsonlint",
        "markdownlint",
        "prettierd",
        "rubocop",
        "stylelint",
        "stylua",
        "yamllint",
      },
      auto_update = true,
    },
  },

  { -- formatting
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      formatters_by_ft = {
        json = { "prettierd" },
        jsonc = { "prettierd" },
        lua = { "stylua" },
        markdown = { "prettierd" },
        yaml = { "prettierd" },
        ruby = { "rubocop" },
        -- css
        css = { { "stylelint", "prettierd" } },
        scss = { { "stylelint", "prettierd" } },
        -- js
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        svelte = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        vue = { "prettierd" },
        ["_"] = { "trim_whitespace" },
      },
    },
  },

  { -- linting
    "mfussenegger/nvim-lint",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      json = { "jsonlint" },
      markdown = { "markdownlint" },
      ruby = { "rubocop" },
      yaml = { "yamllint" },
      -- css
      css = { "stylelint" },
      scss = { "stylelint" },
      -- js
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      vue = { "eslint_d" },
    },
    keys = {
      { "<leader>l", "<cmd>lua R('lint').try_lint()<CR>", desc = "Trigger linting for current file" },
    },
    config = function(_, opts)
      local lint = require("lint")
      lint.linters_by_ft = opts

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("lint", { clear = true }),
        callback = function() lint.try_lint() end,
      })
    end,
  },

  { -- slim language support (Ruby)
    "slim-template/vim-slim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
  },

  { -- json/yaml schema support
    "b0o/SchemaStore.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
  },

  {
    "simrat39/symbols-outline.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    cmd = "SymbolsOutline",
    opts = {
      autofold_depth = 3,
      fold_markers = { i("ui.ChevronRight"), i("ui.ChevronDown") },
      show_symbol_details = false,
      symbols = symbol_outline_icons(),
    },
  },
}
