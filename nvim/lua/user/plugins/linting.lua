return {
  -- NOTE: linter installation handled via mason
  {
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
      vue = { "eslint", "stylelint" },
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
}
