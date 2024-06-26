local i = Cange.get_icon
local line_format = "<author>, <author_time:%d. %b %Y> " .. i("ui.Note") .. " <summary>"

return {
  {
    "lewis6991/gitsigns.nvim", -- git highlighter, blame, etc
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = i("ui.VLineLeft") },
        change = { text = i("ui.VLineLeft") },
        changedelete = { text = i("ui.VLineLeft") },
      },
      preview_config = { border = Cange.get_config("ui.border") },
      current_line_blame = true,
      current_line_blame_formatter = line_format,
      current_line_blame_opts = {
        virt_text = false, -- hide inline to preserve to show in statusline
      },
    },
    -- stylua: ignore start
    keys = {
      { "[g", "<cmd>Gitsigns prev_hunk<CR>",                                    desc = "Pre Git hunk" },
      { "]g", "<cmd>Gitsigns next_hunk<CR>",                                    desc = "Next Git hunk" },
      { "<leader>gB", "<cmd>Telescope git_branches<CR>",                        desc = "Checkout branch" },
      { "<leader>gC", "<cmd>Telescope git_commits<CR>",                         desc = "Checkout commit" },
      { "<leader>go", "<cmd>Telescope git_status<CR>",                          desc = "Open changed file" },
      { "<leader>gI", '<cmd>lua R("gitsigns").blame_line({ full = true })<CR>', desc = "Commit full info" },
      { "<leader>gR", "<cmd>Gitsigns reset_buffer<CR>",                         desc = "Reset file" },
      { "<leader>gS", "<cmd>Gitsigns stage_buffer<CR>",                         desc = "Stage file" },
      { "<leader>gi", "<cmd>Gitsigns blame_line<CR>",                           desc = "Commit info" },
      { "<leader>gl", "<cmd>Gitsigns toggle_current_line_blame<CR>",            desc = "Line blame" },
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>",                         desc = "Preview hunk" },
      { "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>",                           desc = "Reset hunk" },
      { "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>",                           desc = "Stage hunk" },
      { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>",                      desc = "Undo stage hunk" },
    },
    --- stylua: ignore end
  },

  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    dependencies = "nvim-lua/plenary.nvim",
    keys = { { "<Leader>gg", "<cmd>LazyGit<CR>", desc = "Open LazyGit" } },
    config = function()
      vim.g.lazygit_floating_window_border_chars = { " ", " ", " ", " ", " ", " ", " ", " " } -- no borders
      Cange.set_highlights({
        LazyGitBorder = { link = "FloatBorder" },
        LazyGitFloat = { link = "NormalFloat" },
      })
    end,
  },
}
