-- Operation system related settings
if vim.fn.has("mac") == 1 then
  vim.opt.clipboard:append({ "unnamedplus" })
elseif vim.fn.has("unix") == 1 then
  print("unix setup loaded - linux.lua")
elseif vim.fn.has("win32") == 1 then
  vim.opt.clipboard:prepend({ "unnamed", "unnamedplus" })
end
