-- Reloadable color highlights

---@class Cange.utils.Highlights

---@type Cange.utils.Highlights
local m = {}

local ns = "[cange.utils.highlights]"
vim.notify(ns .. " reloaded!")

---@param p Nightfox.Palette
function m.setup(p)
  local highlight_links = {
    NavicSeparator = { fg = p.fg0, link = "lualine_c_normal" },
    NavicText = { link = "lualine_c_normal" },
  }
  for name, hl_link in pairs(Cange.get_symbol_kind_hl()) do
    -- vim.pretty_print("highlight_link", name, hl_link)
    highlight_links["NavicIcons" .. name] = vim.tbl_extend("keep", { bg = p.red.base }, hl_link)
  end

  Cange.set_hls(highlight_links)

  Cange.set_hls({
    Winbar = { link = "lualine_c_normal" },
    WinbarNC = { link = "Comment" },

    CursorLine = { bg = p.bg2 }, -- disable default
    Folded = { bg = nil, fg = p.bg4 }, -- reduces folding noise
    -- illuminate
    IlluminatedWordText = { bg = p.bg1 }, -- Default for references if no kind information is available
    IlluminatedWordRead = { bg = p.bg2 }, -- for references of kind read
    IlluminatedWordWrite = { bg = p.bg2, bold = true }, -- for references of kind write

    -- Window
    FloatTitle = { fg = p.bg3 },
    FloatNormal = { fg = p.fg2, bg = p.bg1 },
    FloatBorder = { fg = p.bg3, bg = p.bg0 },
    --
    HarpoonBorder = { link = "FloatBorder" },
    HarpoonWindow = { fg = p.fg1, bg = p.bg1 },
    TelescopeBorder = { link = "FloatBorder" },
    TelescopeMatching = { link = "MatchParen" },
    TelescopePreviewTitle = { link = "FloatTitle" },
    TelescopePromptBorder = { link = "FloatBorder" },
    TelescopePromptNormal = { link = "FloatNormal" },
    TelescopePromptTitle = { link = "FloatTitle" },
    TelescopeResultsNormal = { fg = p.fg2, bg = p.bg0 },
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
