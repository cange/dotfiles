-- Reloadable color highlights

---@class Cange.core.Highlights

---@type Cange.core.Highlights
local m = {}

-- local palette = nil
local ns = "[cange.core.highlights]"
vim.notify(ns .. " reloaded!")

---@param p Nightfox.Palette
function m.setup(p)
  local highlight_links = {
    NavicSeparator = { fg = p.fg0, link = "lualine_c_normal" },
    NavicText = { link = "lualine_c_normal" },
  }

  Cange.set_hls(highlight_links)

  Cange.set_hls({
    CursorLine = { bg = p.bg2 }, -- disable default
    Folded = { bg = nil, fg = p.bg4 }, -- reduces folding noise
    -- illuminate
    IlluminatedWordText = { bg = p.bg1 }, -- Default for references if no kind information is available
    IlluminatedWordRead = { bg = p.bg2 }, -- for references of kind read
    IlluminatedWordWrite = { bg = p.bg2, bold = true }, -- for references of kind write

    -- Window
    WindowTitle = { fg = p.bg3 },
    WindowBorder = { fg = p.bg3, bg = p.bg0 },
    --
    WhichkeyBorder = { link = "WindowBorder" },
    -- telescope
    TelescopeTitle = { link = "WindowTitle" },
    TelescopeBorder = { link = "WindowBorder" },
    -- TelescopeMatching = { bold = true, fg = p.bg0, bg = p.sel1 },
    TelescopeMatching = { link = "MatchParen" },
    TelescopePreviewTitle = { link = "WindowTitle" },
    TelescopePromptBorder = { link = "WindowBorder" },
    TelescopePromptNormal = { fg = p.fg2, bg = p.bg1 },
    TelescopePromptTitle = { link = "WindowTitle" },
    TelescopeResultsNormal = { bg = p.bg0, fg = p.fg2 },
    TelescopeSelection = { fg = p.fg2, bg = p.sel0 },
    TelescopeSelectionCaret = { fg = p.fg1, bg = p.sel0 },
    TelescopeSelectionNormal = { fg = p.bg3, bg = p.bg0 },

    -- indent-blankline
    IndentBlanklineChar = { fg = p.bg2 },
    IndentBlanklineContextChar = { fg = p.fg3 },
    IndentBlanklineContextStart = { sp = p.fg3, underline = true },
    IndentBlanklineSpaceChar = { fg = p.bg3 },

    -- cmp / completion
    CmpItemKindTabnine = { fg = p.pink.base },
    CmpItemKindCopilot = { fg = p.cyan.base },
  })
end

return m
