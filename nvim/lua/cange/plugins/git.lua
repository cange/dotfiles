local icon = Cange.get_icon

return {
  {
    "lewis6991/gitsigns.nvim", -- git highlighter, blame, etc
    opts = {
      signs = {
        add = { text = icon("ui.VLineLeft") },
        change = { text = icon("ui.VLineLeft") },
        changedelete = { text = icon("ui.VLineLeft") },
        delete = { text = icon("ui.ArrowRight") },
        topdelete = { text = icon("ui.ArrowRight") },
        untracked = { text = icon("ui.VDashLineLeft") },
      },
      preview_config = { border = Cange.get_config("ui.border") },
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 800,
      },
      current_line_blame_formatter = " " .. icon("git.Commit") .. " <author>, <author_time:%d.%m.%y> " .. icon(
        "ui.Note"
      ) .. " <summary>",
    },
  },
}
