local ns = "[cange.core.colorscheme]"
local theme = Cange.get_config("colorscheme.theme")
local variant = Cange.get_config("colorscheme.variant")

-- theme https://github.com/EdenEast/nightfox.nvim#usage
local found, palette = pcall(require, theme .. ".palette")
if not found then
  print(ns, 'colorscheme "' .. theme .. '.palette" module not found')
  return
end

---@diagnostic disable-next-line: param-type-mismatch
local found_theme, _ = pcall(vim.cmd, "colorscheme " .. variant)
if not found_theme then
  print(ns, '"' .. variant .. '" of "' .. theme .. '" colorscheme not found!')
  return
end

-- vim.notify('Theme: "' .. theme .. '" in "' .. variation .. '" variation')
local c = palette.load(variant)
-- vim.pretty_print("color:", vim.tbl_keys(c))

Cange.set_hls({
  -- defaults override
  CursorLine = { bg = c.bg2 }, -- disable default
  Folded = { bg = nil, fg = c.bg4 }, -- reduces folding noise
  -- illuminate
  IlluminatedWordText = { bg = c.bg1 }, -- Default for references if no kind information is available
  IlluminatedWordRead = { bg = c.bg2 }, -- for references of kind read
  IlluminatedWordWrite = { bg = c.bg2, bold = true }, -- for references of kind write

  -- telescope
  TelescopeMatching = { fg = c.yellow.bright, bold = true },
  TelescopeSelection = { bg = c.sel0 },
  TelescopeSelectionCaret = { fg = c.white.base, bg = c.sel0 },
  TelescopePromptNormal = { bg = c.bg },
  TelescopeSelectionNormal = { bg = c.bg0 },
  TelescopePromptBorder = { fg = c.bg0, bg = c.bg0 },
  TelescopePromptTitle = { fg = c.bg4 },
  TelescopeBorder = { fg = c.bg0, bg = c.bg0 },
  TelescopeResultsNormal = { bg = c.bg0 },

  -- indent-blankline
  IndentBlanklineChar = { fg = c.bg2 },
  IndentBlanklineContextChar = { fg = c.fg3 },
  IndentBlanklineContextStart = { sp = c.fg3, underline = true },
  IndentBlanklineSpaceChar = { fg = c.bg3 },
  IndentBlanklineSpaceCharBlankline = { fg = c.red.base },
})
