local M = {
  ---@diagnostic disable-next-line: undefined-field
  mode = vim.o.background,
  ---@type Palette|nil
  palette = nil,
}

---@return Palette
local function update_palette()
  local curr_colorscheme = vim.g.colors_name
  local colorscheme = curr_colorscheme ~= nil and curr_colorscheme or Cange.get_config("ui.colorscheme")
  M.palette = require("nightfox.palette").load(colorscheme)

  return M.palette
end

local function update_highlights()
  local _, lua_color = require("nvim-web-devicons").get_icon_color("any.lua", "lua")

  local pal = update_palette()
  local highlights = {
    CursorLine = { bg = pal.bg2 }, -- more subtle
    Folded = { bg = nil, fg = pal.bg4 }, -- reduces folding noise
    NonText = { fg = pal.bg2 }, -- subtle virtual/column line

    -- Window
    FloatBorder = { fg = pal.bg0, bg = pal.bg0 },
    FloatTitle = { fg = pal.fg3, bg = pal.bg0 },
    NormalFloat = { fg = pal.fg1, bg = pal.bg0 },

    -- SymboleOutline
    FocusedSymbol = { bold = true },
    -- NormalTelescope
    TelescopeBorder = { link = "FloatBorder" },
    TelescopeMatching = { link = "MatchParen" },
    TelescopePreviewTitle = { link = "FloatTitle" },
    TelescopePromptBorder = { link = "FloatBorder" },
    TelescopePromptCounter = { fg = pal.fg3 },
    TelescopePromptNormal = { fg = pal.fg2, bg = pal.bg1 },
    TelescopePromptTitle = { link = "FloatTitle" },
    TelescopeResultsNormal = { fg = pal.fg2, bg = pal.bg0 },
    TelescopeSelection = { fg = pal.fg2, bg = pal.sel0 },
    TelescopeSelectionCaret = { fg = pal.fg1, bg = pal.sel0 },
    TelescopeSelectionNormal = { link = "FloatBorder" },
    TelescopeTitle = { link = "FloatTitle" },
    -- NvimTree
    NvimTreeFolderArrowClosed = { fg = pal.fg3 },
    NvimTreeFolderArrowOpen = { fg = pal.fg3 },
    NvimTreeGitRenamed = { fg = pal.magenta.base },
    NvimTreeIndentMarker = { fg = pal.bg2 },
    -- indent-blankline
    MiniIndentscopeSymbol = { fg = pal.green.dim },
    -- completion
    CmpGhostText = { fg = pal.fg3, italic = true },
    CmpItemAbbr = { fg = pal.fg2 },
    CmpItemAbbrMatch = { link = "TelescopeMatching" },
    CmpItemMenuLua = { fg = lua_color },
    -- misc
    WhichkeyBorder = { link = "FloatBorder" },
    LspInlayHint = { fg = pal.comment, bg = nil },
  }

  Cange.set_highlights(highlights)
end

local themes = {
  contrast = { name = "carbonfox", mode = "dark" },
  dark = { name = "terafox", mode = "dark" },
  light = { name = "dayfox", mode = "light" },
}

---@param mode? '"dark"'|'"light"'|'"contrast"'|nil
---@param silent? boolean
local function update_colorscheme(mode, silent)
  ---@diagnostic disable-next-line: undefined-field
  M.mode = mode ~= nil and mode or vim.o.background
  if not mode then return end
  local theme = themes[M.mode]
  vim.opt.background = theme.mode
  vim.cmd("colorscheme " .. theme.name)

  if silent == false then
    vim.schedule(function() Log:info(M.mode .. " / " .. theme.name, "Changed colorscheme") end)
  end

  update_highlights()
end

local selected_index = 1
local function toggle_colorscheme()
  local index = selected_index + 1
  selected_index = (index % vim.tbl_count(themes)) + 1
  update_colorscheme(vim.tbl_keys(themes)[selected_index], false)
end

vim.api.nvim_create_user_command("CangeUpdateColorscheme", function() update_colorscheme() end, {})
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  group = vim.api.nvim_create_augroup("cange_on_colorscheme_change", { clear = true }),
  command = "CangeUpdateColorscheme",
})

return {
  {
    "EdenEast/nightfox.nvim", -- colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    dependencies = { "f-person/auto-dark-mode.nvim" },
    opts = { options = { transparent = true } },
    init = function()
      local auto_mode = require("auto-dark-mode")
      local silent = true
      update_colorscheme("dark", silent)

      auto_mode.setup({
        set_dark_mode = function()
          update_colorscheme("dark", silent)
          silent = false
        end,
        set_light_mode = function()
          update_colorscheme("light", silent)
          silent = false
        end,
        update_interval = 1000,
      })
    end,
    keys = {
      { "<leader>et", toggle_colorscheme, desc = "Toggle colorscheme mode" },
    },
  },
}

--#region Types

---@class DualShade
---@field even string
---@field odd string

---@class PaletteMeta
---@field name string
---@field light boolean

---@class Shade
---@field base string
---@field bright string
---@field dim string
---@field light boolean

---@class Palette
---@field meta PaletteMeta
---@field black Shade
---@field red Shade
---@field green Shade
---@field yellow Shade
---@field blue Shade
---@field magenta Shade
---@field cyan Shade
---@field white Shade
---@field orange Shade
---@field pink Shade
---@field comment string
---@field bg0 string Dark bg (status line and float)
---@field bg1 string Default bg
---@field bg2 string Lighter bg (colorcolm folds)
---@field bg3 string Lighter bg (cursor line)
---@field bg4 string Conceal, border fg
---@field fg0 string Lighter fg
---@field fg1 string Default fg
---@field fg2 string Darker fg (status line)
---@field fg3 string Darker fg (line numbers, fold colums)
---@field sel0 string Popup bg, visual selection bg
---@field sel1 string Popup sel bg, search bg

--#endregion
