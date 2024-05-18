return {
  -- NOTE: formatter installation handled via mason
  {
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
        -- shell scripts
        zsh = { "shfmt" },
        shell = { "shfmt" },
        bash = { "shfmt" },
        -- css
        css = { "prettierd" },
        scss = { "prettierd" },
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
}
