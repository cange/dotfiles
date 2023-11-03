-- TODO: establish keymaps via setup
-- TODO: enable in test files only
-- TODO: establish telescope extension to show active toggles
-- TODO: establish jump to next/prev toggle

---@class SpecToggler
---@field only fun()
---@field skip fun()

---@alias SpecTogglerOptions table<string, any>

local M = {}

M.skip = require("spec_toggler.toggles").skip
M.only = require("spec_toggler.toggles").only

-- Public API
vim.api.nvim_create_user_command("SpecTogglerSkip", M.skip, {})
vim.api.nvim_create_user_command("SpecTogglerOnly", M.only, {})

return M
