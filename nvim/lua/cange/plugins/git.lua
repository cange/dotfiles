local i = Cange.get_icon
local line_format = "   " .. i("git.Commit") .. "   <author>, <author_time:%d.%m.%y> " .. i("ui.Note") .. " <summary>"

return {
  {
    "lewis6991/gitsigns.nvim", -- git highlighter, blame, etc
    opts = {
      signs = {
        add = { text = i("ui.VLineLeft") },
        change = { text = i("ui.VLineLeft") },
        changedelete = { text = i("ui.VLineLeft") },
        delete = { text = i("ui.ArrowRight") },
        topdelete = { text = i("ui.ArrowRight") },
        untracked = { text = i("ui.VDashLineLeft") },
      },
      preview_config = { border = Cange.get_config("ui.border") },
      current_line_blame = true,
      current_line_blame_formatter = line_format,
    },
  },
}
