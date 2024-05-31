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
  M.palette.copilot = { even = "#93f5ec", odd = "#a77bf3" }
  M.palette.tabnine = { even = "#0575ed", odd = "#ff16ff" }

  return M.palette
end

---@param shade string
---@param factor number
---@return number # as hex
local function blend(shade, factor)
  local C = require("nightfox.lib.color")
  return C.from_hex(shade):blend(C(M.palette.bg1), factor):to_css()
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
    CmpItemKindCopilot = { link = "CmpItemKindDefault" },
    CmpItemKindTabnine = { link = "CmpItemKindDefault" },
    CmpItemMenuCopilot = { fg = blend(pal.copilot.odd, 0.2) },
    CmpItemMenu = { fg = pal.cyan.dim },
    CmpItemMenuLua = { fg = lua_color },
    CmpItemMenuTabnine = { fg = blend(pal.tabnine.even, -0.5) },
    -- misc
    WhichkeyBorder = { link = "FloatBorder" },
    LspInlayHint = { fg = pal.comment, bg = nil },

    -- parentheses highlighting
    RainbowDelimiterRed = { fg = pal.red.base },
    RainbowDelimiterYellow = { fg = pal.yellow.base },
    RainbowDelimiterBlue = { fg = pal.blue.base },
    RainbowDelimiterOrange = { fg = pal.orange.base },
    RainbowDelimiterGreen = { fg = pal.green.base },
    RainbowDelimiterViolet = { fg = pal.magenta.base },
    RainbowDelimiterCyan = { fg = pal.cyan.base },
  }

  Cange.set_highlights(highlights)
end

---@param mode? '"dark"'|'"light"'|nil
---@param silent? boolean
local function update_colorscheme(mode, silent)
  ---@diagnostic disable-next-line: undefined-field
  M.mode = mode ~= nil and mode or vim.o.background
  local theme = Cange.get_config("ui.colorscheme." .. M.mode)
  vim.opt.background = M.mode
  vim.cmd("colorscheme " .. theme)

  if silent == false then vim.schedule(function() Log:info(M.mode .. " / " .. theme, "Changed colorscheme") end) end

  update_highlights()
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
---@field tabnine DualShade
---@field copilot DualShade

--#endregion
