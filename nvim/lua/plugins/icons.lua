---@class Cange.plugins.icons

---@type Cange.plugins.icons
return {
  -- font icon set
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup()
      require("cange.utils.icons").setup()
    end,
  },
}
