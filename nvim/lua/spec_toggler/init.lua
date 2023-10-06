-- TODO: establish keymaps via setup
-- TODO: enable in test files only
---TODO: enable only in supported languages

---@class SpecToggler
---@field only fun()
---@field skip fun()

---@alias SpecTogglerOptions table<string, any>

local M = {}

M.skip = require("spec_toggler.toggles").skip
M.only = require("spec_toggler.toggles").only

return M
