return { -- bookmark buffers
  enabled = false,
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  branch = "harpoon2",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  opts = {
    settings = {
      save_on_toggle = true, -- any time the ui menu is closed then sync
    },
  },
  config = function(_, opts)
    require("harpoon"):setup(opts)
    require("telescope").load_extension("harpoon")
  end,
  keys = function()
    local harpoon = require("harpoon")
    return {
      {
        "<Leader>A",
        function()
          harpoon:list():add()
          Notify.info("Bookmark added!", { title = "Harpoon" })
        end,
        desc = "Add bookmark",
      },
      { "<Leader>m", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Show bookmarks" },
      { "[m", function() harpoon:list():prev() end, desc = "Prev bookmark" },
      { "]m", function() harpoon:list():next() end, desc = "Next bookmark" },
      { "<Leader>1", function() harpoon:list():select(1) end, desc = "Bookmark 1" },
      { "<Leader>2", function() harpoon:list():select(2) end, desc = "Bookmark 2" },
      { "<Leader>3", function() harpoon:list():select(3) end, desc = "Bookmark 3" },
      { "<Leader>4", function() harpoon:list():select(4) end, desc = "Bookmark 4" },
    }
  end,
}
