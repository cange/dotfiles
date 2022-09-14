-- Operation system related settings
local has = function(x)
  return vim.fn.has(x) == 1
end

local is_mac = has('macunix')
local is_unix = has('unix')
local is_win = has('win32')

if is_mac then
  vim.opt.clipboard:append({ 'unnamedplus' })
elseif is_unix then
  print('unix setup loaded - linux.lua')
elseif is_win then
  vim.opt.clipboard:prepend({ 'unnamed', 'unnamedplus' })
end
