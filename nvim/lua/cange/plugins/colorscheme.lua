--#region Types

---@class cange.colorschemeShade
---@field base string
---@field bright string
---@field dim string
---@field light boolean

---@class cange.colorschemePalette
---@field black cange.colorschemeShade
---@field red cange.colorschemeShade
---@field green cange.colorschemeShade
---@field yellow cange.colorschemeShade
---@field blue cange.colorschemeShade
---@field magenta cange.colorschemeShade
---@field cyan cange.colorschemeShade
---@field white cange.colorschemeShade
---@field orange cange.colorschemeShade
---@field pink cange.colorschemeShade
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

--#endregion

M = {}

---@type boolean
local initialized = false

---@return cange.colorschemePalette
local function update_palette()
  local curr_colorscheme = vim.g.colors_name
  local colorscheme = curr_colorscheme ~= nil and curr_colorscheme or Cange.get_config("ui.colorscheme")
  local palette = require("nightfox.palette").load(colorscheme)

  return palette
end

local function update_highlights()
  local _, lua_color = require("nvim-web-devicons").get_icon_color("any.lua", "lua")
  local p = update_palette()
  local highlights = {
    CursorLine = { bg = p.bg2 }, -- disable default
    Folded = { bg = nil, fg = p.bg4 }, -- reduces folding noise
    Todo = { bg = nil, bold = true },
    -- illuminate
    IlluminatedWordText = { bg = p.bg1 }, -- Default for references if no kind information is available
    IlluminatedWordRead = { bg = p.bg2 }, -- for references of kind read
    IlluminatedWordWrite = { bg = p.bg2, bold = true }, -- for references of kind write

    -- Window
    FloatTitle = { fg = p.fg3, bg = p.bg0 },
    FloatNormal = { fg = p.fg1, bg = p.bg1 },
    FloatBorder = { fg = p.bg0, bg = p.bg0 },
    --
    HarpoonBorder = { link = "FloatBorder" },
    HarpoonCurrentFile = { italic = true },
    HarpoonWindow = { link = "FloatNormal" },
    TelescopeBorder = { link = "FloatBorder" },
    TelescopeMatching = { link = "MatchParen" },
    TelescopePreviewTitle = { link = "FloatTitle" },
    TelescopePromptBorder = { link = "FloatBorder" },
    TelescopePromptNormal = { link = "FloatNormal" },
    TelescopePromptTitle = { link = "FloatTitle" },
    TelescopeResultsNormal = { fg = p.fg0, bg = p.bg0 },
    TelescopeSelection = { fg = p.fg2, bg = p.sel0 },
    TelescopeSelectionCaret = { fg = p.fg1, bg = p.sel0 },
    TelescopeSelectionNormal = { link = "FloatBorder" },
    TelescopeTitle = { link = "FloatTitle" },
    WhichkeyBorder = { link = "FloatBorder" },

    -- indent-blankline
    IndentBlanklineChar = { fg = p.bg2 },
    IndentBlanklineContextChar = { fg = p.fg3 },
    IndentBlanklineContextStart = { sp = p.fg3, underline = true },
    IndentBlanklineSpaceChar = { fg = p.bg3 },

    -- completion
    CmpItemKindCopilot = { fg = p.cyan.base },
    CmpItemKindLsp = { link = "@lsp.type.method" },
    CmpItemKindLspSignatureHelp = { link = "@lsp.type.parameter" },
    CmpItemKindLua = { fg = lua_color },
    CmpItemKindTabnine = { fg = p.pink.dim },
    CmpItemMenuTabnine = { link = "CmpItemKindTabnine" },
    CmpItemMenuCopilot = { link = "CmpItemKindCopilot" },
  }

  Cange.set_highlights(highlights)

  if initialized then vim.schedule(function() Log:info("Color highlights refreshed!", "Colorscheme") end) end
end

vim.api.nvim_create_user_command("CangeUpdateColorscheme", update_highlights, {})

return {
  {
    "EdenEast/nightfox.nvim", -- colorscheme
    lazy = true,
    config = function()
      local colorscheme = Cange.get_config("ui.colorscheme")

      vim.cmd("colorscheme " .. colorscheme)

      update_highlights()
      initialized = true
    end,
  },

  { "guns/xterm-color-table.vim" }, -- provides cterm color cheat via command :XtermColorTable
}
