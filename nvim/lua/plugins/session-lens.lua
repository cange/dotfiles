-- local ns = "[plugins.session]"

return {
  "rmagatti/session-lens", -- extends auto-session through Telescope
  dependencies = {
    "rmagatti/auto-session",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("session-lens").setup({
      path_display = { "shorten" },
      previewer = true,
      prompt_title = "Sessions",
    })
    require("telescope").load_extension("session-lens")
  end,
}
