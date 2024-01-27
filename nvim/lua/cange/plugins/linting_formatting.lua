return {
  { -- loads formatter and linter
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
    },
    opts = {
      ensure_installed = {
        "eslint",
        "jsonlint",
        "luacheck",
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

  { -- linting
    "mfussenegger/nvim-lint",
    lazy = true,
    event = { "BufWritePost", "TextChanged" },
    opts = {
      json = { "jsonlint" },
      markdown = { "markdownlint" },
      ruby = { "rubocop" },
      yaml = { "yamllint" },
      -- css
      css = { "stylelint" },
      scss = { "stylelint" },
      -- js
      javascript = { "eslint" },
      typescript = { "eslint" },
      javascriptreact = { "eslint" },
      typescriptreact = { "eslint" },
      svelte = { "eslint" },
      vue = { "eslint" },
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

  { -- formatting
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      formatters_by_ft = {
        json = { "prettierd" },
        jsonc = { "prettierd" },
        lua = { "stylua" },
        html = { "prettierd" },
        svg = { "xmlformatter" },
        markdown = { "prettierd" },
        yaml = { "prettierd" },
        ruby = { "rubocop" },
        -- css
        css = { { "prettierd", "stylelint" } },
        scss = { { "prettierd", "stylelint" } },
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
    config = function(_, opts)
      require("conform").setup(opts)
      require("cange.lsp").update_format_on_save()
    end,
    keys = {
      { "<leader>e3", "<cmd>ConformInfo<CR>", desc = "Formatter info" },
      { "<localleader>f", '<cmd>lua require("conform").format()<CR>', desc = "Format" },
    },
  },

  { -- A pretty list for showing diagnostics
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    config = function(_, opts)
      require("trouble").setup(opts)

      vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
        group = vim.api.nvim_create_augroup("before_troubleshooting_list_close", { clear = true }),
        desc = "Close troubleshooting list",
        callback = function() require("trouble").close() end,
      })
    end,
    keys = function()
      local opts = { skip_groups = true, jump = true }
      local trouble = require("trouble")

      return {
        { "<leader>tt", "<cmd>TroubleToggle<CR>", desc = "All Diagnostics" },
        { "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Workspace Diagnostics" },
        { "<leader>td", "<cmd>TroubleToggle document_diagnostics<CR>", desc = "Document Diagnostics" },
        { "<leader>tq", "<cmd>TroubleToggle quickfix<CR>", desc = "Quickfix List" },
        { "<leader>tl", "<cmd>TroubleToggle loclist<CR>", desc = "Location List" },
        { "gR", "<cmd>TroubleToggle lsp_references<CR>", desc = "LSP Refenrences Search" },
        {
          "[q",
          function()
            if not trouble.is_open() then trouble.open() end
            trouble.previous(opts)
          end,
          desc = "Prev Diagnostic",
        },
        {
          "]q",
          function()
            if not trouble.is_open() then trouble.open() end
            trouble.next(opts)
          end,
          desc = "Next Diagnostic",
        },
      }
    end,
  },
}
