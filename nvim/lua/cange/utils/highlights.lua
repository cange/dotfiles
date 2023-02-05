-- Reloadable color highlights

---@class Cange.utils.Highlights

---@type Cange.utils.Highlights
local m = {}

local ns = "[cange.utils.highlights]"
vim.notify(ns .. " reloaded!")

---Set highlight group by given table.
---@param highlights table<string, table> Highlight definition map
---@see vim.api.nvim_set_hl
function m.set_hls(highlights)
  for name, val in pairs(highlights) do
    vim.api.nvim_set_hl(0, name, val)
  end
end

---@param p Nightfox.Palette
function m.setup(p)
  m.set_hls({
    Winbar = { link = "lualine_c_normal" },
    WinbarNC = { link = "Comment" },

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
    HarpoonWindow = { link = "FloatNormal" },
    NavicSeparator = { fg = p.fg0, link = "lualine_c_normal" },
    NavicText = { link = "lualine_c_normal" },
    TelescopeBorder = { link = "FloatBorder" },
    TelescopeMatching = { link = "MatchParen" },
    TelescopePreviewTitle = { link = "FloatTitle" },
    TelescopePromptBorder = { link = "FloatBorder" },
    TelescopePromptNormal = { link = "FloatNormal" },
    TelescopePromptTitle = { link = "FloatTitle" },
    TelescopeResultsNormal = { fg = p.fg0, bg = p.bg1 },
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
    CmpItemKindTabnine = { fg = p.pink.base },
    CmpItemKindCopilot = { fg = p.cyan.base },
  })
end

return m
