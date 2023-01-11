-- local ns = "[plugin/indent_blankline]"
return {
  "lukas-reineke/indent-blankline.nvim",
  confif = function()
    require("indent_blankline").setup({
      enabled = true,
      buftype_exclude = { "terminal", "nofile" },
      filetype_exclude = {
        "help",
        "dashboard",
        "NvimTree",
        "Trouble",
        "text",
      },
      char = Cange.get_icon("ui.LineLeft"),
      context_char = Cange.get_icon("ui.LineLeft"),
      show_current_context = true,
      show_current_context_start = true,
      use_treesitter = true,
    })
  end,
}
