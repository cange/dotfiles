local modes = {
  light = "github_light_high_contrast",
  dark = "terafox",
}
---@return user.Palette, user.Spec, user.DebugPalette
local function get_palette()
  local curr_colorscheme = vim.g.colors_name
  local colorscheme = curr_colorscheme ~= nil and curr_colorscheme or User.get_config("ui.colorscheme")
  local debug = {
    blue = { base = "#0000dd", dim = "#000088", bright = "#0000ff" },
    cyan = { base = "#00dddd", dim = "#008888", bright = "#00ffff" },
    green = { base = "#00dd00", dim = "#00a000", bright = "#00ff00" },
    magenta = { base = "#dd00dd", dim = "#880088", bright = "#ff00ff" },
    red = { base = "#dd0000", dim = "#880000", bright = "#ff0000" },
    yellow = { base = "#dddd00", dim = "#888800", bright = "#ffff00" },
  }

  return require("nightfox.palette").load(colorscheme), require("nightfox.spec").load(colorscheme), debug
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
  local pal, spec, debug = get_palette()
  local highlights = {
    -- common
    Folded = { link = "Comment" }, -- reduces folding noise

    -- WhichKey
    WhichKey = { link = "@markup.link" },
    WhichkeyBorder = { link = "FloatBorder" },
    WhichKeyDesc = { link = "Comment" },
    WhichKeyIcon = { link = "Comment" },

    -- Telescope
    TelescopeNormal = { link = "UserNormal" },
    TelescopeBorder = { link = "FloatBorder" },
    TelescopeMatching = { link = "MatchParen" },
    TelescopePreviewTitle = { link = "FloatTitle" },
    TelescopePromptBorder = { link = "FloatBorder" },
    TelescopeSelectionNormal = { link = "FloatBorder" },
    TelescopeTitle = { link = "FloatTitle" },

    -- DropBar statusline
    DropBarIconUISeparator = { link = "WinBarNC" },
    DropBarKindFile = { link = "Normal" },
    DropBarMenuCurrentContext = { link = "TelescopeNormal" },
    DropBarMenuHoverEntry = { link = "TelescopeSelection" },
  }

  --  dark theme tweaks
  if vim.o.background == "dark" then
    highlights = vim.tbl_extend("force", highlights, {
      -- common
      CursorLine = { bg = pal.bg1 }, -- subtle
      Folded = { bg = nil, fg = pal.bg4 }, -- reduces folding noise
      NonText = { fg = pal.bg4 }, -- subtle virtual/column line
      UserNormal = { bg = pal.bg1 },
      WinBar = { fg = pal.fg2 },
      WinBarNC = { fg = pal.comment },

      -- misc
      DropBarKindFile = { fg = pal.fg1, bold = true },
      LspInlayHint = { fg = pal.comment, bg = nil, italic = true },

      -- Window
      FloatBorder = { fg = pal.bg0, bg = pal.bg0 },
      FloatInput = { fg = pal.fg1, bg = pal.bg2 },
      FloatTitle = { fg = pal.fg3, bg = pal.bg0 },
      NormalFloat = { fg = pal.fg1, bg = pal.bg0 },

      -- Snacks
      SnacksNotifierHistory = { link = "UserNormal" },
      SnacksIndentScope = { fg = pal.green.dim },
      SnacksInputBorder = { link = "FloatBorder" },
      SnacksInputNormal = { link = "UserNormal" },
      SnacksInputTitle = { link = "FloatTitle" },

      -- SymboleOutline
      FocusedSymbol = { bold = true },
      -- NormalTelescope
      TelescopePromptCounter = { fg = pal.fg3 },
      TelescopePromptNormal = { fg = pal.fg2, bg = pal.bg1 },
      TelescopePromptTitle = { link = "FloatTitle" },
      TelescopeResultsNormal = { fg = pal.fg2, bg = pal.bg0 },
      TelescopeSelection = { fg = pal.fg2, bg = pal.sel0 },
      TelescopeSelectionCaret = { fg = pal.fg1, bg = pal.sel0 },

      -- NvimTree
      NvimTreeFolderArrowClosed = { fg = pal.fg3 },
      NvimTreeFolderArrowOpen = { fg = pal.fg3 },
      NvimTreeGitRenamed = { fg = pal.magenta.base },
      NvimTreeIndentMarker = { fg = pal.bg2 },
      NvimTreeWindowPicker = { fg = pal.fg0, bg = pal.sel1 },

      -- completion
      CmpGhostText = { fg = pal.fg3, italic = true },
      CmpItemAbbr = { fg = pal.fg2 },
      CmpItemAbbrMatch = { link = "TelescopeMatching" },
    })
  end

  User.set_highlights(highlights)
end

---@param mode? '"dark"'|'"light"'|nil
---@param silent? boolean
local function update_colorscheme(mode, silent)
  ---@diagnostic disable-next-line: undefined-field
  mode = mode ~= nil and mode or vim.o.background
  if not mode then return end
  vim.opt.background = mode
  local theme = modes[mode]
  vim.cmd("colorscheme " .. theme)

  if silent == false then
    vim.schedule(function() Notify.info(mode .. " / " .. theme, { title = "Changed colorscheme" }) end)
  end

  vim.schedule(function() update_highlights() end) -- schedule enforces the update after the colorscheme change
end

vim.api.nvim_create_user_command("UserUpdateColorscheme", function() update_colorscheme() end, {})
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  group = vim.api.nvim_create_augroup("user_on_colorscheme_change", { clear = true }),
  command = "UserUpdateColorscheme",
})

return {
  {
    "EdenEast/nightfox.nvim", -- colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    dependencies = {
      "f-person/auto-dark-mode.nvim",
      {
        "projekt0n/github-nvim-theme",
        name = "github-theme",
        lazy = false,
        config = function() require("github-theme").setup({}) end,
      },
    },
    opts = { options = { transparent = true } },
    init = function()
      local auto_mode = require("auto-dark-mode")
      local silent = true
      update_colorscheme(vim.o.background or "dark", silent)

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
