return {
  -- NOTE: linter installation handled via mason
  {
    "mfussenegger/nvim-lint",
    lazy = true,
    event = { "BufWritePost", "TextChanged" },
    opts = {
      css = { "stylelint" },
      html = { "markuplint" },
      json = { "jsonlint" },
      markdown = { "markdownlint" },
      ruby = { "rubocop" },
      scss = { "stylelint" },
      svg = { "markuplint" },
      xml = { "markuplint" },
      yaml = { "yamllint" },
      -- js
      javascript = { "eslint" },
      typescript = { "eslint" },
      javascriptreact = { "eslint" },
      typescriptreact = { "eslint" },
      svelte = { "eslint" },
      vue = { "eslint", "stylelint" },
    },
    keys = {
      { "<Leader>l", "<cmd>lua R('lint').try_lint()<CR>", desc = "Trigger linting for current file" },
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
