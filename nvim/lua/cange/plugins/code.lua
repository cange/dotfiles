return {
  {
    "stevearc/conform.nvim",
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
