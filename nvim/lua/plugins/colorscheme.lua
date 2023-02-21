---@class Nightfox

---@class Nightfox.Shade
---@field base string
---@field bright string
---@field dim string
---@field light boolean

---@class Nightfox.Palette
---@field black Nightfox.Shade
---@field red Nightfox.Shade
---@field green Nightfox.Shade
---@field yellow Nightfox.Shade
---@field blue Nightfox.Shade
---@field magenta Nightfox.Shade
---@field cyan Nightfox.Shade
---@field white Nightfox.Shade
---@field orange Nightfox.Shade
---@field pink Nightfox.Shade
---@field comment string
---@field bg0 string
---@field bg1 string
---@field bg2 string
---@field bg3 string
---@field bg4 string
---@field fg0 string
---@field fg1 string
---@field fg2 string
---@field fg3 string
---@field sel0 string
---@field sel1 string

---@class Cange.plugins.colorscheme

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
