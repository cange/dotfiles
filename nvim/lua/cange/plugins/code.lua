return {
  {
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

  {
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

  { -- load formatter/linter related dependencies
    "WhoIsSethDaniel/mason-tool-installer.nvim",
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
}
