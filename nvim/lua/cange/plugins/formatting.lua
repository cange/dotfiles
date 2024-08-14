-- NOTE: formatter installation handled via mason
local prettier_preset = { "prettier", stop_after_first = true }

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      json = prettier_preset,
      jsonc = prettier_preset,
      lua = { "stylua" },
      html = prettier_preset,
      svg = prettier_preset,
      markdown = prettier_preset,
      yaml = prettier_preset,
      ruby = { "rubocop" },
      -- shell scripts
      zsh = { "shfmt" },
      shell = { "shfmt" },
      bash = { "shfmt" },
      -- css
      css = prettier_preset,
      scss = prettier_preset,
      -- js
      javascript = prettier_preset,
      javascriptreact = prettier_preset,
      svelte = prettier_preset,
      typescript = prettier_preset,
      typescriptreact = prettier_preset,
      vue = prettier_preset,
      xml = prettier_preset,
      ["_"] = { "trim_whitespace" },
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)
    require("cange.lsp").update_format_on_save()
  end,
  keys = {
    { "<leader>e3", "<cmd>ConformInfo<CR>", desc = "Formatter info" },
    { "<localleader>f", '<cmd>lua require("conform").format({ async = true })<CR>', desc = "Format" },
  },

  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
