---table Gobal convenience helper
---@module 'Cange'
Cange = Cange or {}

---Loads mutiple modules at ones and catches loading errors in reports
---them if given.
---@param context_name string Indicate of loading location for error reporting.
---@param module_names table<string|table> List of modules i.e {'a','b'}
---@param method? function Determines which method is called internallly by `pcall`. (default: require)
---@return table<string,string> List of loaded modules or if loading
---error an incomplete list on last successful ones.
---@usage local m = BULK_LOADER('ctx', { 'module_a', 'ns.module_b', 'my_m' }); m.my_m()
function Cange.bulk_loader(context_name, module_names, method)
  local loaded = {}
  method = method or require
  for i, name_or_table in pairs(module_names) do
    local is_list = vim.tbl_islist(name_or_table)
    local module_name = is_list and name_or_table[1] or name_or_table
    local register_name = is_list and name_or_table[2] or i

    local found_module, module = pcall(method, module_name)

    if not found_module then
      print('[' .. context_name .. '] "' .. module_name .. '" not found')
      return loaded
    end
    loaded[register_name] = module
  end

  return loaded
end

---Convenience helper to load a single module savely
---@param context_name string Indicate of loading location for error reporting.
---@param module_name string Name of the module which should be loaded
---@return table|function|nil Loaded module if successful or nil in error case
function Cange.load(context_name, module_name)
  if pcall(require, module_name) then
    return require(module_name)
  end
  print('[' .. context_name .. '] "' .. module_name .. '" not found')
  return nil
end
local found_icons, icons = pcall(require, 'cange.icons')
if not found_icons then
  print('[cange.init] "cange.icons" not found')
  return
end

Cange.icons = icons
