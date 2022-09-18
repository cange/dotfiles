local found, plenary_reload = pcall(require, 'plenary.reload')
local reloader = require
if found then
  reloader = plenary_reload.reload_module
end

function P(v)
  print(vim.inspect(v))
  return v
end

function RELOAD(...)
  return reloader(...)
end

function R(name)
  RELOAD(name)
  return require(name)
end

---Loads mutiple modules at ones and catches loading errors in reports
-- them if given.
-- @param context_label string Indicate of loading location for error reporting.
-- @param module_names table<string,...> List of modules i.e {'a','b'}
-- @return table<string,string> List of loaded modules or if loading
-- error an incomplete list on last successful ones.
function BULK_LOADER(context_label, module_name)
  local loaded = {}
  for i, module_name in pairs(module_name) do
    local found, module = pcall(require, module_name)

    if not found then
      print('[' .. context_label .. '] "' .. module_name .. '" not found')
      return loaded
    end
    loaded[i] = module
  end

  return loaded
end
