return {
  {
    "folke/which-key.nvim",
    config = function()
      local wk = require("which-key")

      wk.setup({
        plugins = {
          spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          },
        },
        icons = {
          breadcrumb = Cange.get_icon("ui.ArrowRight"),
          separator = Cange.get_icon("ui.ChevronRight"),
          group = Cange.get_icon("ui.PlusSmall") .. " ",
        },
        window = {
          border = Cange.get_config("ui.border"),
          margin = { 0, 4, 2, 4 }, -- extra window margin [top, right, bottom, left]
        },
        ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
      })

      wk.register(require("cange.utils.whichkey").mappings(), {
        prefix = "<leader>",
      })
    end,
  },
}
