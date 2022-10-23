--#region Types

---Allows to configurate deep hidden settings on a global stage.
---@class Config

--#endregion

local settings = {
  ["lsp.diagnostic.virtual_text"] = true, -- shows inline hint text if true
}

local M = {}

---Get certain settings attributes
---@param key string Path of a certain configguation key
---@return any Value of given key or nil if not found.
function M.get_config(key)
  return settings[key] or nil
end

return M
