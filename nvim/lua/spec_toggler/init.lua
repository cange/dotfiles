-- TODO: establish keymaps via setup
-- TODO: enable in test files only
-- TODO: detect language
---TODO: enable only in supported languages
-- TODO: support ruby rspec

---@class SpecToggler
---@field only fun()
---@field skip fun()

---@alias SpecTogglerOptions table<string, any>

local M = {}

M.skip = require("spec_toggler.toggles").skip
M.only = require("spec_toggler.toggles").only

return M
