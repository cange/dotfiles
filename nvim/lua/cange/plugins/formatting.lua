return {
  -- NOTE: formatter installation handled via mason
  {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      formatters_by_ft = {
        json = { "prettier" },
        jsonc = { "prettier" },
        lua = { "stylua" },
        html = { "prettier" },
        svg = { "xmlformatter" },
        markdown = { "prettier" },
        yaml = { "prettier" },
        ruby = { "rubocop" },
        -- shell scripts
        zsh = { "shfmt" },
        shell = { "shfmt" },
        bash = { "shfmt" },
        -- css
        css = { "prettier" },
        scss = { "prettier" },
        -- js
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        svelte = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
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
}
