local line_format = "<author>, <author_time:%d. %b %Y> " .. Icon.ui.Note .. " <summary>"
local signs = {
  add = { text = Icon.ui.LineLeft },
  change = { text = Icon.ui.LineLeft },
  delete = { text = Icon.ui.LineLower },
  changedelete = { text = Icon.git.Diff },
  topdelete = { text = Icon.ui.LineUpper },
}

return {
  {
    "lewis6991/gitsigns.nvim", -- git highlighter, blame, etc
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = signs,
      signs_staged = signs,
      preview_config = { border = User.get_config("ui.border") },
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
      { "<Leader>gB", "<cmd>Telescope git_branches<CR>",                        desc = "Checkout branch" },
      { "<Leader>gC", "<cmd>Telescope git_commits<CR>",                         desc = "Checkout commit" },
      { "<Leader>go", "<cmd>Telescope git_status<CR>",                          desc = "Open changed file" },
      { "<Leader>gI", '<cmd>lua R("gitsigns").blame_line({ full = true })<CR>', desc = "Commit full info" },
      { "<Leader>gR", "<cmd>Gitsigns reset_buffer<CR>",                         desc = "Reset file" },
      { "<Leader>gS", "<cmd>Gitsigns stage_buffer<CR>",                         desc = "Stage file" },
      { "<Leader>gi", "<cmd>Gitsigns blame_line<CR>",                           desc = "Commit info" },
      { "<Leader>gl", "<cmd>Gitsigns toggle_current_line_blame<CR>",            desc = "Line blame" },
      { "<Leader>gp", "<cmd>Gitsigns preview_hunk<CR>",                         desc = "Preview hunk" },
      { "<Leader>gr", "<cmd>Gitsigns reset_hunk<CR>",                           desc = "Reset hunk" },
      { "<Leader>gs", "<cmd>Gitsigns stage_hunk<CR>",                           desc = "Stage hunk" },
      { "<Leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>",                      desc = "Undo stage hunk" },
    },
    --- stylua: ignore end
  },
}
