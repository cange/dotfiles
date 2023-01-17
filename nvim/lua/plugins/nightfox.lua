return {
  "EdenEast/nightfox.nvim", -- colorscheme
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    -- local ns = "[plugins.nightfox]"
    local colorscheme = Cange.get_config("colorscheme")

    -- setup must be called before loading
    vim.cmd("colorscheme " .. colorscheme)
    -- vim.notify(colorscheme .. " colorscheme", vim.log.levels.INFO, { title = "Theme: " .. ns })

    -- Returns the palette of the specified colorscheme
    local p = require("nightfox.palette").load(colorscheme)
    Cange.register_key("palette", p)

    -- vim.pretty_print("color:", vim.tbl_keys(palette))

    Cange.set_hls({
      CursorLine = { bg = p.bg2 }, -- disable default
      Folded = { bg = nil, fg = p.bg4 }, -- reduces folding noise
      -- illuminate
      IlluminatedWordText = { bg = p.bg1 }, -- Default for references if no kind information is available
      IlluminatedWordRead = { bg = p.bg2 }, -- for references of kind read
      IlluminatedWordWrite = { bg = p.bg2, bold = true }, -- for references of kind write

      -- telescope
      TelescopeMatching = { fg = p.yellow.bright, bold = true },
      TelescopeSelection = { bg = p.sel0 },
      TelescopeSelectionCaret = { fg = p.white.base, bg = p.sel0 },
      TelescopePromptNormal = { bg = p.bg },
      TelescopeSelectionNormal = { bg = p.bg0 },
      TelescopePromptBorder = { fg = p.bg0, bg = p.bg0 },
      TelescopePromptTitle = { fg = p.bg4 },
      TelescopeBorder = { fg = p.bg0, bg = p.bg0 },
      TelescopeResultsNormal = { bg = p.bg0 },

      -- indent-blankline
      IndentBlanklineChar = { fg = p.bg2 },
      IndentBlanklineContextChar = { fg = p.fg3 },
      IndentBlanklineContextStart = { sp = p.fg3, underline = true },
      IndentBlanklineSpaceChar = { fg = p.bg3 },
      IndentBlanklineSpaceCharBlankline = { fg = p.red.base },

      -- cmp / completion
      CmpItemKindTabnine = { fg = p.pink.base },
      CmpItemKindCopilot = { fg = p.cyan.base },
    })
  end,
}
