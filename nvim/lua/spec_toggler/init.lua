---@class SpecToggler
---@field skip fun()

---@alias SpecTogglerOptions table<string, any>

local M = {}

M.skip = require("spec_toggler.toggles").toggle_skip

return M
