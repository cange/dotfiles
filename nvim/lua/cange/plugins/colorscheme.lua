local M = {
  ---@diagnostic disable-next-line: undefined-field
  mode = vim.o.background,
}

---@return Palette, Spec
local function get_palette()
  local curr_colorscheme = vim.g.colors_name
  local colorscheme = curr_colorscheme ~= nil and curr_colorscheme or Cange.get_config("ui.colorscheme")

  return require("nightfox.palette").load(colorscheme), require("nightfox.spec").load(colorscheme)
end

---Returns a new color that a linear blend between two colors
---@param base_color string
---@param blend_color string
---@param factor number Float [0,1]. 0 being this and 1 being other
---@return string
local function blend(base_color, blend_color, factor)
  local C = require("nightfox.lib.color")
  return C(base_color):blend(C(blend_color), factor):to_css()
end

local function update_highlights()
  local _, lua_color = require("nvim-web-devicons").get_icon_color("any.lua", "lua")
  local pal, spec = get_palette()
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
    LspInlayHint = { fg = pal.comment, bg = nil, italic = true },

    -- parentheses highlighting
    RainbowDelimiterRed = { fg = blend(spec.syntax.bracket, pal.red.dim, 0.75) },
    RainbowDelimiterYellow = { fg = blend(spec.syntax.bracket, pal.yellow.dim, 0.75) },
    RainbowDelimiterBlue = { fg = blend(spec.syntax.bracket, pal.blue.dim, 0.75) },
    RainbowDelimiterOrange = { fg = blend(spec.syntax.bracket, pal.orange.dim, 0.75) },
    RainbowDelimiterGreen = { fg = blend(spec.syntax.bracket, pal.green.dim, 0.75) },
    RainbowDelimiterViolet = { fg = blend(spec.syntax.bracket, pal.magenta.dim, 0.75) },
    RainbowDelimiterCyan = { fg = blend(spec.syntax.bracket, pal.cyan.dim, 0.75) },
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

---@class Spec
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
---@field syntax SpecSyntax
---@field diag SpecDiagnostic
---@field diag_bg SpecDiagnosticBg
---@field diff SpecDiff
---@field git SpecGit

---@class SpecSyntax
---@field bracket string Brackets and Punctuation
---@field builtin0 string Builtin variable
---@field builtin1 string Builtin type
---@field builtin2 string Builtin const
---@field builtin3 string Not used
---@field comment string Comment
---@field conditional string Conditional and loop
---@field const string Constants, imports and booleans
---@field dep string Deprecated
---@field field string Field
---@field func string Functions and Titles
---@field ident string Identifiers
---@field keyword string Keywords
---@field number string Numbers
---@field operator string Operators
---@field preproc string PreProc
---@field regex string Regex
---@field statement string Statements
---@field string string Strings
---@field type string Types
---@field variable string Variables

---@class SpecDiagnostic
---@field error string
---@field warn string
---@field info string
---@field hint string
---@field ok string

---@class SpecDiagnosticBg
---@field error string
---@field warn string
---@field info string
---@field hint string
---@field ok string

---@class SpecDiff
---@field add string
---@field delete string
---@field change string
---@field text string

---@class SpecGit
---@field add string
---@field changed string
---@field conflict string
---@field ignored string
---@field removed string

--#endregion
