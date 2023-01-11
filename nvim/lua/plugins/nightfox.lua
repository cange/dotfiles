return {
  "EdenEast/nightfox.nvim", -- colorscheme
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    -- local ns = "[plugins.nightfox]"
    local colorscheme = Cange.get_config("colorscheme")

    require("nightfox").setup({
      options = {
        dim_inactive = true, -- Non focused panes set to alternative background
      },
    })
    -- setup must be called before loading
    vim.cmd("colorscheme " .. colorscheme)
    -- vim.notify(colorscheme .. " colorscheme", vim.log.levels.INFO, { title = "Theme: " .. ns })

    -- Returns the palette of the specified colorscheme
    local palette = require("nightfox.palette").load(colorscheme)
    -- vim.pretty_print("color:", vim.tbl_keys(palette))

    Cange.set_hls({
      CursorLine = { bg = palette.bg2 }, -- disable default
      Folded = { bg = nil, fg = palette.bg4 }, -- reduces folding noise
      -- illuminate
      IlluminatedWordText = { bg = palette.bg1 }, -- Default for references if no kind information is available
      IlluminatedWordRead = { bg = palette.bg2 }, -- for references of kind read
      IlluminatedWordWrite = { bg = palette.bg2, bold = true }, -- for references of kind write

      -- telescope
      TelescopeMatching = { fg = palette.yellow.bright, bold = true },
      TelescopeSelection = { bg = palette.sel0 },
      TelescopeSelectionCaret = { fg = palette.white.base, bg = palette.sel0 },
      TelescopePromptNormal = { bg = palette.bg },
      TelescopeSelectionNormal = { bg = palette.bg0 },
      TelescopePromptBorder = { fg = palette.bg0, bg = palette.bg0 },
      TelescopePromptTitle = { fg = palette.bg4 },
      TelescopeBorder = { fg = palette.bg0, bg = palette.bg0 },
      TelescopeResultsNormal = { bg = palette.bg0 },

      -- indent-blankline
      IndentBlanklineChar = { fg = palette.bg2 },
      IndentBlanklineContextChar = { fg = palette.fg3 },
      IndentBlanklineContextStart = { sp = palette.fg3, underline = true },
      IndentBlanklineSpaceChar = { fg = palette.bg3 },
      IndentBlanklineSpaceCharBlankline = { fg = palette.red.base },
    })
  end,
}
