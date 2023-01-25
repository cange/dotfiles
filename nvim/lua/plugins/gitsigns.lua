local icon = Cange.get_icon

return {
  "lewis6991/gitsigns.nvim", -- git highlighter, blame, etc
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = icon("ui.VLineLeft", { trim = true }) },
        change = { text = icon("ui.VLineLeft", { trim = true }) },
        changedelete = { text = icon("ui.VLineLeft", { trim = true }) },
        delete = { text = icon("ui.ArrowRight", { trim = true }) },
        topdelete = { text = icon("ui.ArrowRight", { trim = true }) },
        untracked = { text = icon("ui.VDashLineLeft", { trim = true }) },
      },
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 800,
      },
      current_line_blame_formatter = " " .. icon("git.Commit") .. "<author>, <author_time:%d.%m.%y> " .. icon(
        "ui.Note"
      ) .. "<summary>",
    })
  end,
}
