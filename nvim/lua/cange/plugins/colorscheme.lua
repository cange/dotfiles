local M = {
  ---@diagnostic disable-next-line: undefined-field
  mode = vim.opt.background:get(),
  ---@type ColorschemePalette|nil
  palette = nil,
}

---@return ColorschemePalette
local function update_palette()
  local curr_colorscheme = vim.g.colors_name
  local colorscheme = curr_colorscheme ~= nil and curr_colorscheme or Cange.get_config("ui.colorscheme")
  M.palette = require("nightfox.palette").load(colorscheme)

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
    -- SymboleOutline
    FocusedSymbol = { bold = true },
    -- Harpoon
    HarpoonBorder = { link = "FloatBorder" },
    HarpoonCurrentFile = { italic = true },
    HarpoonWindow = { link = "FloatNormal" },
    -- Telescope
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
    IblScope = { fg = p.green.dim },
    -- Rainbow (indent-blankline)
    RainbowRed = { fg = blend(Cange.get_hl_hex("TSRainbowRed", "fg").fg, 0.8) },
    RainbowYellow = { fg = blend(Cange.get_hl_hex("TSRainbowYellow", "fg").fg, 0.8) },
    RainbowBlue = { fg = blend(Cange.get_hl_hex("TSRainbowBlue", "fg").fg, 0.8) },
    RainbowOrange = { fg = blend(Cange.get_hl_hex("TSRainbowOrange", "fg").fg, 0.8) },
    RainbowGreen = { fg = blend(Cange.get_hl_hex("TSRainbowGreen", "fg").fg, 0.8) },
    RainbowViolet = { fg = blend(Cange.get_hl_hex("TSRainbowViolet", "fg").fg, 0.8) },
    RainbowCyan = { fg = blend(Cange.get_hl_hex("TSRainbowCyan", "fg").fg, 0.8) },

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
end

---@param mode? '"dark"'|'"light"'|nil
---@param silent? boolean
local function update_colorscheme(mode, silent)
  ---@diagnostic disable-next-line: undefined-field
  M.mode = mode ~= nil and mode or vim.opt.background:get()
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
    dependencies = { "f-person/auto-dark-mode.nvim" },
    lazy = true,
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

---@class ColorschemeShade
---@field base string
---@field bright string
---@field dim string
---@field light boolean

---@class ColorschemePalette
---@field black ColorschemeShade
---@field red ColorschemeShade
---@field green ColorschemeShade
---@field yellow ColorschemeShade
---@field blue ColorschemeShade
---@field magenta ColorschemeShade
---@field cyan ColorschemeShade
---@field white ColorschemeShade
---@field orange ColorschemeShade
---@field pink ColorschemeShade
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
