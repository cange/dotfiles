---@return user.Palette, user.Spec
local function get_palette()
  local curr_colorscheme = vim.g.colors_name
  local colorscheme = curr_colorscheme ~= nil and curr_colorscheme or User.get_config("ui.colorscheme")

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
  local pal, spec = get_palette()
  local highlights = {
    -- common
    Folded = { link = "Comment" }, -- reduces folding noise

    -- WhichKey
    WhichKey = { link = "@markup.link" },
    WhichkeyBorder = { link = "FloatBorder" },
    WhichKeyDesc = { link = "Comment" },
    WhichKeyIcon = { link = "Comment" },

    -- Telescope
    TelescopeBorder = { link = "FloatBorder" },
    TelescopeMatching = { link = "MatchParen" },
    TelescopePreviewTitle = { link = "FloatTitle" },
    TelescopePromptBorder = { link = "FloatBorder" },
  }

  --  dark theme tweaks
  if vim.o.background == "dark" then
    highlights = vim.tbl_extend("force", highlights, {
      -- common
      NonText = { fg = pal.bg2 }, -- subtle virtual/column line
      CursorLine = { bg = pal.bg1 }, -- subtle
      Folded = { bg = nil, fg = pal.bg4 }, -- reduces folding noise

      -- misc
      LspInlayHint = { fg = pal.comment, bg = nil, italic = true },

      -- parentheses highlighting
      RainbowDelimiterRed = { fg = blend(spec.syntax.bracket, pal.red.dim, 0.75) },
      RainbowDelimiterYellow = { fg = blend(spec.syntax.bracket, pal.yellow.dim, 0.75) },
      RainbowDelimiterBlue = { fg = blend(spec.syntax.bracket, pal.blue.dim, 0.75) },
      RainbowDelimiterOrange = { fg = blend(spec.syntax.bracket, pal.orange.dim, 0.75) },
      RainbowDelimiterGreen = { fg = blend(spec.syntax.bracket, pal.green.dim, 0.75) },
      RainbowDelimiterViolet = { fg = blend(spec.syntax.bracket, pal.magenta.dim, 0.75) },
      RainbowDelimiterCyan = { fg = blend(spec.syntax.bracket, pal.cyan.dim, 0.75) },

      -- Window
      FloatBorder = { fg = pal.bg0, bg = pal.bg0 },
      FloatInput = { fg = pal.fg1, bg = pal.bg1 },
      FloatTitle = { fg = pal.fg3, bg = pal.bg0 },
      NormalFloat = { fg = pal.fg1, bg = pal.bg0 },

      -- SymboleOutline
      FocusedSymbol = { bold = true },
      -- NormalTelescope
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
      NvimTreeWindowPicker = { fg = pal.fg0, bg = pal.sel1 },
      -- indent-blankline
      MiniIndentscopeSymbol = { fg = pal.green.dim },
      -- completion
      CmpGhostText = { fg = pal.fg3, italic = true },
      CmpItemAbbr = { fg = pal.fg2 },
      CmpItemAbbrMatch = { link = "TelescopeMatching" },

      -- lualine - keep opaque
      lualine_c_normal = { fg = pal.fg2, bg = pal.bg0 },
      lualine_x_copilot_status_normal = { link = "lualine_c_normal" },
      lualine_x_git_blame_line_normal = { fg = pal.comment, bg = pal.bg0 },
    })
  end

  User.set_highlights(highlights)
end

local theme_modes = {
  light = "github_light_hight_contrast",
  dark = "terafox",
}

---@param mode? '"dark"'|'"light"'|nil
---@param silent? boolean
local function update_colorscheme(mode, silent)
  ---@diagnostic disable-next-line: undefined-field
  mode = mode ~= nil and mode or vim.o.background
  if not mode then return end
  vim.opt.background = mode
  local theme = theme_modes[mode]
  vim.cmd("colorscheme " .. theme)

  if silent == false then vim.schedule(function() Notify:info(mode .. " / " .. theme, "Changed colorscheme") end) end

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
