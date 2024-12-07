local icons = require("user.icons")
local line_format = "<author>, <author_time:%d. %b %Y> " .. icons.ui.Note .. " <summary>"
local signs = {
  add = { text = icons.ui.LineLeft },
  change = { text = icons.ui.LineLeft },
  delete = { text = icons.ui.LineLower },
  changedelete = { text = icons.git.Diff },
  topdelete = { text = icons.ui.LineUpper },
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
}
