return {
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
  keys = {
    { "<leader>e3", "<cmd>ConformInfo<CR>", desc = "Formatter info" },
  },
}
