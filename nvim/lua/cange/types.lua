---@meta

--# selene: allow(unused_variable)

---@class Cange

-- log
---@class CangeLog

-- utils
---@class CangeUtil
---@field palette CangeColorscheme.Palette

---@class CangeUtil.Highlights

---@class CangeUtil.WhichKey

---@class CangeUtil.Icons

---@class CangeUtil.IconsPreset
---@field icon? CangeCore.Icons
---@field color? string Hex color value
---@field cterm_color? string
---@field name? string

-- keymaps
---@class CangeKeymaps

---@alias CangeKeymaps.Group
---| '"editor"' # Editor config while in session settings
---| '"git"' # Git related keys
---| '"lsp"' # LSP related keys
---| '"next"' # Keys the relates to a next action
---| '"plugins"' # Plugins update/install related keys
---| '"prev"' # Keys the relates to a prev action
---| '"search"' # Search related keys
---| '"treesitter"' # Tree-Sitter and code diagnostic related keys

---@class CangeKeymaps.Options
---@field buffer? number|nil, -- Global mappings. Specify a buffer number for buffer local mappings
---@field mode? string|table Mode short-name (map command prefix: "n", "i", "v", "x", …)
---@field noremap? boolean `noremap` when creating keymaps
---@field nowait? boolean `nowait` when creating keymaps
---@field silent? boolean silent` when creating keymaps

---@class CangeKeymaps.Mapping
---@field desc string
---@field cmd string|function
---@field key string Key
---@field opts CangeKeymaps.Options

-- telescope
---@class CangeTelescope

-- cmp
---@class CangeCmp

---@class CangeCmp.Util

-- lsp
---@class CangeLSP

---@class CangeLSP.Util

---@class CangeLSP.Format

---@class CangeLSP.FormatOptions
---@field async? boolean
---@field timeout_ms? integer

-- core
---@class CangeCore

---@alias CangeCore.Icons table<string, table>

---@class CangeCore.WhichKey

---@class CangeCore.WhichKey.command
---@field desc string Description of the keybinding
---@field cmd string|function command of the keybinding
---@field primary? boolean Determines whether or not to show a on inital "which-key" window

---@class CangeCore.WhichKey.group
---@field mappings CangeCore.WhichKey.command[] The actual key bindings
---@field subleader string Additional key to enter the certain group
---@field title string Is displayed as group name

---@class CangeColorscheme
---@class CangeColorscheme.Shade
---@field base string
---@field bright string
---@field dim string
---@field light boolean

---@class CangeColorscheme.Palette
---@field black CangeColorscheme.Shade
---@field red CangeColorscheme.Shade
---@field green CangeColorscheme.Shade
---@field yellow CangeColorscheme.Shade
---@field blue CangeColorscheme.Shade
---@field magenta CangeColorscheme.Shade
---@field cyan CangeColorscheme.Shade
---@field white CangeColorscheme.Shade
---@field orange CangeColorscheme.Shade
---@field pink CangeColorscheme.Shade
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
