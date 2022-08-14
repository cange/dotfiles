require('base')
require('highlights')
require('maps')
require('plugins')

local has = function(x)
  return vim.fn.has(x) == 1
end

local is_mac = has "macunix"
local is_unix = has "unix"
local is_win = has "win32"

if is_mac then
  require('os.macos')
elseif is_unix then
  require('os.linux')
elseif is_win then
  require('os.windows')
end
