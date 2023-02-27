---@meta

--# selene: allow(unused_variable)

---@class Cange

-- plugins
---@class Cange.plugins

---@class Cange.plugins.colorscheme

-- utils
---@class Cange.utils

---@class Cange.utils.Notify

---@class Cange.utils.Highlights

---@class Cange.utils.WhichKey

---@class Cange.utils
---@field palette Nightfox.Palette

---@class Cange.utils.Icons

---@class Cange.utils.IconsPreset
---@field icon? Cange.core.Icons
---@field color? string Hex color value
---@field cterm_color? string
---@field name? string


-- keymaps
---@class Cange.keymaps

---@alias Cange.keymaps.Group
---| '"editor"' # Editor config while in session settings
---| '"git"' # Git related keys
---| '"lsp"' # LSP related keys
---| '"next"' # Keys the relates to a next action
---| '"plugins"' # Plugins update/install related keys
---| '"prev"' # Keys the relates to a prev action
---| '"search"' # Search related keys
---| '"treesitter"' # Tree-Sitter and code diagnostic related keys

---@class Cange.keymaps.Options
---@field buffer? number|nil, -- Global mappings. Specify a buffer number for buffer local mappings
---@field mode? string|table Mode short-name (map command prefix: "n", "i", "v", "x", …)
---@field noremap? boolean `noremap` when creating keymaps
---@field nowait? boolean `nowait` when creating keymaps
---@field silent? boolean silent` when creating keymaps

---@class Cange.keymaps.Mapping
---@field desc string
---@field cmd string|function
---@field key string Key
---@field opts Cange.keymaps.Options

-- telescope
---@class Cange.telescope

-- cmp
---@class Cange.cmp

---@class Cange.cmp.Utils

-- lsp
---@class Cange.lsp

---@class Cange.lsp.Format

-- core
---@class Cange.core

---@class Cange.core.WhichKey

---@class Cange.core.WhichKey.command
---@field desc string Description of the keybinding
---@field cmd string|function command of the keybinding
---@field primary? boolean Determines whether or not to show a on inital "which-key" window

---@class Cange.core.WhichKey.group
---@field mappings Cange.core.WhichKey.command[] The actual key bindings
---@field subleader string Additional key to enter the certain group
---@field title string Is displayed as group name

---@class Nightfox
---@class Nightfox.Shade
---@field base string
---@field bright string
---@field dim string
---@field light boolean

---@class Nightfox.Palette
---@field black Nightfox.Shade
---@field red Nightfox.Shade
---@field green Nightfox.Shade
---@field yellow Nightfox.Shade
---@field blue Nightfox.Shade
---@field magenta Nightfox.Shade
---@field cyan Nightfox.Shade
---@field white Nightfox.Shade
---@field orange Nightfox.Shade
---@field pink Nightfox.Shade
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

---@class Keymap
---@field rhs string
---@field lhs string
---@field buffer number
---@field expr number
---@field lnum number
---@field mode string
---@field noremap number
---@field nowait number
---@field script number
---@field sid number
---@field silent number
---@field callback fun()|nil
---@field id string terminal keycodes for lhs
---@field desc string

---@class KeyCodes
---@field keys string
---@field internal string[]
---@field notation string[]

---@class MappingOptions
---@field noremap boolean
---@field silent boolean
---@field nowait boolean
---@field expr boolean

---@class Mapping
---@field buf number
---@field group boolean
---@field label string
---@field desc string
---@field prefix string
---@field cmd string
---@field opts MappingOptions
---@field keys KeyCodes
---@field mode? string
---@field callback fun()|nil
---@field preset boolean
---@field plugin string
---@field fn fun()

---@class MappingTree
---@field mode string
---@field buf? number
---@field tree Tree

---@class VisualMapping : Mapping
---@field key string
---@field highlights table
---@field value string

---@class PluginItem
---@field key string
---@field label string
---@field value string
---@field cmd string
---@field highlights table

---@class PluginAction
---@field trigger string
---@field mode string
---@field label? string
---@field delay? boolean

---@class Plugin
---@field name string
---@field actions PluginAction[]
---@field run fun(trigger:string, mode:string, buf:number):PluginItem[]
---@field setup fun(wk, opts, Options)
