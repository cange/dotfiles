local i = Cange.get_icon
local line_format = "<author>, <author_time:%d. %b %Y> " .. i("ui.Note") .. " <summary>"

return {
  {
    "lewis6991/gitsigns.nvim", -- git highlighter, blame, etc
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = i("ui.VLineLeft") },
        change = { text = i("ui.VLineLeft") },
        changedelete = { text = i("ui.VLineLeft") },
        delete = { text = i("ui.ArrowRight") },
        topdelete = { text = i("ui.ArrowRight") },
        untracked = { text = i("ui.VWavyLine") },
      },
      preview_config = { border = Cange.get_config("ui.border") },
      current_line_blame = true,
      current_line_blame_formatter = line_format,
      current_line_blame_opts = {
        virt_text = false, -- hide inline to preserve to show in statusline
      },
    },
  },
}
