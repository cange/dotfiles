---@type Cange.plugins.colorscheme
return {
  {
    "EdenEast/nightfox.nvim", -- colorscheme
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      Cange = Cange or require("cange.utils")
      local colorscheme = Cange.get_config("ui.colorscheme")

      vim.cmd("colorscheme " .. colorscheme)

      ---@type Nightfox.Palette
      local palette = require("nightfox.palette").load(colorscheme)

      Cange.register_key("palette", palette)

      local function assign_highlights()
        Cange.reload("cange.utils.highlights").setup(palette)
      end

      assign_highlights()

      vim.keymap.set("n", "<leader><leader>c", assign_highlights)
    end,
  },

  { "guns/xterm-color-table.vim" }, -- provides cterm color cheat via command :XtermColorTable
}
