-- NOTE: formatter installation handled via mason
local prettier_preset = { "prettier", stop_after_first = true }

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      bash = { "shfmt" },
      css = prettier_preset,
      html = { "superhtml" },
      json = prettier_preset,
      jsonc = prettier_preset,
      lua = { "stylua" },
      markdown = prettier_preset,
      ruby = { "rubocop" },
      scss = prettier_preset,
      shell = { "shfmt" },
      svg = { "superhtml" },
      yaml = prettier_preset,
      zsh = { "shfmt" },
      xml = { "superhtml" },
      -- js
      javascript = prettier_preset,
      javascriptreact = prettier_preset,
      svelte = prettier_preset,
      typescript = prettier_preset,
      typescriptreact = prettier_preset,
      vue = prettier_preset,
      ["_"] = { "trim_whitespace" },
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)
    require("user.lsp").update_format_on_save()
  end,
  keys = {
    { "<Leader>e3", "<cmd>ConformInfo<CR>", desc = "Formatter info" },
    { "<LocalLeader>f", '<cmd>lua require("conform").format({ async = true })<CR>', desc = "Format" },
  },

  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
