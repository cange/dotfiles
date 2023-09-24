return {
  {
    "mhartington/formatter.nvim",
    event = "VeryLazy",
    cmd = { "Format", "FormatWrite" },
    config = function()
      require("formatter").setup({
        logging = true,
        filetype = {
          json = { require("formatter.filetypes.json").prettierd },
          jsonc = { require("formatter.filetypes.json").prettierd },
          lua = { require("formatter.filetypes.lua").stylua },
          markdown = { require("formatter.filetypes.markdown").prettierd },
          -- css
          css = { require("formatter.filetypes.css").prettierd },
          scss = { require("formatter.filetypes.css").prettierd },
          -- js
          javascript = { require("formatter.filetypes.javascript").prettierd },
          javascriptreact = { require("formatter.filetypes.javascript").prettierd },
          svelte = { require("formatter.filetypes.svelte").prettier },
          typescript = { require("formatter.filetypes.typescript").prettierd },
          typescriptreact = { require("formatter.filetypes.typescript").prettierd },
          vue = { require("formatter.filetypes.vue").prettier },
          ["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
        },
      })
    end,
  },
}
