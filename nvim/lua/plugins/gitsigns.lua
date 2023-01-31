return {
  "lewis6991/gitsigns.nvim", -- git highlighter, blame, etc
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = Cange.get_icon("ui.VLineLeft") },
        change = { text = Cange.get_icon("ui.VLineLeft") },
        changedelete = { text = Cange.get_icon("ui.VLineLeft") },
        delete = { text = Cange.get_icon("ui.ArrowRight") },
        topdelete = { text = Cange.get_icon("ui.ArrowRight") },
        untracked = { text = Cange.get_icon("ui.VDashLineLeft") },
      },
      preview_config = {
        border = Cange.get_config("ui.border"),
      },
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 800,
      },
      current_line_blame_formatter = " "
        .. Cange.get_icon("git.Commit")
        .. " <author>, <author_time:%d.%m.%y> "
        .. Cange.get_icon("ui.Note")
        .. " <summary>",
    })
  end,
}
