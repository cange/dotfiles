return {
  { -- winbar with LSP context symbols
    "Bekaboo/dropbar.nvim",
    dependencies = { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    opts = {
      icons = {
        ui = { bar = { separator = " " .. Icon.ui.ChevronRight .. " " } },
        kinds = { symbols = { Folder = "" } },
      },
    },
    event = "BufEnter",
    keys = function() return { { "<Leader>;", require("dropbar.api").pick, desc = "Pick symbols in winbar" } } end,
  },
}
