local M = require("lualine.component"):extend()
local str = require("user.utils.string")

local default_options = {
  prefix = "",
  suffix = "",
  max_length = 20, -- the length of full segment (incl. prefix and suffix)
  shorten_breakpoint_columns = 120, -- value of when to shorten the segment (half of max_length)
}
--- Avoids redundant operations while statusline updates of static values
local cache = {
  content = nil,
  columns = nil,
  cwd = nil,
}

function M:init(options)
  M.super.init(self, options)
  self.options = vim.tbl_deep_extend("keep", self.options or {}, default_options)
  self.options.length = self.options.max_length - (#self.options.prefix + #self.options.suffix)
end

function M:get_workspace()
  local cwd = vim.fn.getcwd()
  if cwd == cache.cwd and cache.columns == vim.o.columns and cache.content then return cache.content end
  cache.columns = vim.o.columns

  local o = self.options
  local suffix = o.suffix
  local prefix = o.prefix
  local dir_name = cwd:match("([^/]*)$")
  local content = str.truncate(dir_name, o.length)

  if vim.o.columns < o.shorten_breakpoint_columns then
    prefix = ""
    suffix = ""
    content = str.truncate(dir_name, o.max_length / 2)
  end

  cache.cwd = cwd
  cache.content = prefix .. content .. suffix
  return cache.content
end

function M:update_status() return self:get_workspace() end

return M
