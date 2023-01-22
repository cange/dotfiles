return {
  "lewis6991/gitsigns.nvim", -- git highlighter, blame, etc
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = Cange.get_icon("ui.VLineLeft", { trim = true }) },
        change = { text = Cange.get_icon("ui.VLineLeft", { trim = true }) },
        changedelete = { text = Cange.get_icon("ui.VLineLeft", { trim = true }) },
        delete = { text = Cange.get_icon("ui.ArrowRight", { trim = true }) },
        topdelete = { text = Cange.get_icon("ui.ArrowRight", { trim = true }) },
        untracked = { text = Cange.get_icon("ui.VDashLineLeft", { trim = true }) },
      },
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 800,
      },
      current_line_blame_formatter = " <author>, "
        .. "<author_time:%d.%m.%y> "
        .. Cange.get_icon("git.Commit")
        .. "<summary>",
    })
  end,
}
