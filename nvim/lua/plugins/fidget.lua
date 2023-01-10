return {
  "j-hui/fidget.nvim", -- shows LSP initialization progress
  config = function()
    require("fidget").setup({
      text = {
        spinner = "dots",
      },
    })
  end,
}
