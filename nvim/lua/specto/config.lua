---@class SpectoLanguage
---@field file_patterns string[] expects a table of *string-match* patterns.
---@field features SpectoFeature[]

---@class SpectoFeature
---@field keywords SpectoFeatureKeywords
---@field flag string
---@field separator string
---@field prefix boolean

---@alias SpectoFeatureKeywords string[]
---@alias SpectoType '"only"'|'"skip"'

---@class SpectoConfig
local M = {}

local defaults = {
  languages = {
    ["*"] = {
      file_patterns = {},
      features = {
        skip = {
          flag = "x",
          keywords = { "it", "describe", "test" },
          prefix = true,
          separator = "",
        },
        only = {
          flag = "only",
          keywords = { "it", "describe", "test" },
          prefix = false,
          separator = ".",
        },
      },
    },
    javascript = {
      file_patterns = { "__tests__/", "%.?test%.", "%.?spec%." },
      features = { skip = {}, only = {} },
    },
    ruby = {
      file_patterns = { "%w_spec%.$" },
      features = {
        skip = { keywords = { "context", "describe", "example", "it", "scenario", "specify", "test" } },
      },
    },
  },

  options = {
    features = {
      skip = { icon = "" }, -- nf-oct-skip
      only = { icon = "" }, -- nf-oct-play
    },
  },
}

---@type SpectoConfig
local options

---@param opts? SpectoConfig
function M.setup(opts)
  opts = opts or {}
  options = vim.tbl_deep_extend("force", {}, defaults, opts or {})
end

return setmetatable(M, {
  __index = function(_, key)
    if not options then M.setup() end
    return options[key]
  end,
})
