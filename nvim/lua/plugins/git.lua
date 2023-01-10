return {
  "dinhhuy258/git.nvim", -- For git blame & browse
  config = function()
    require("git").setup({
      keymaps = {
        -- Open blame window
        blame = "<leader>Gb",
        -- Open file/folder in git repository
        browse = "<leader>Go",
      },
    })
  end,
}
