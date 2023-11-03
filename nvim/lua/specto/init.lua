if not rawget(vim, "treesitter") then
  error('[specto] "treesitter" is not defined!')
  return
end

local util = require("specto.util")
local config = require("specto.config")

---@class Specto
---@field config SpectoConfig
---@field lang_props SpectoLanguage|nil
---@field only fun()
---@field skip fun()
local M = {}
local lang = require("nvim-treesitter.parsers").get_parser():lang()

---@param opts? SpectoConfig
function M.setup(opts)
  require("specto.config").setup(opts)
  M.lang_props = util.get_language_props(lang, config.languages)
  PF("[specto] setup -opts: %q", opts)
end

M.skip = function()
  if not util.supported("skip", lang, M.lang_props) then return end
  require("specto.toggles").skip(M.lang_props.features)
  vim.api.nvim_create_user_command("SpectoSkip", M.skip, {})
end

M.only = function()
  if not util.supported("only", lang, M.lang_props) then return end
  require("specto.toggles").only(M.lang_props.features)
  vim.api.nvim_create_user_command("SpectoOnly", M.only, {})
end

M.setup()

return M

-- TODO: establish keymaps via setup
-- TODO: enable in test files only
-- TODO: establish telescope extension to show active toggles
-- TODO: establish jump to next/prev toggle
