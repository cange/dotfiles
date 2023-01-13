local found_lazy, lazy_status = pcall(require, "lazy.status")
if not found_lazy then
  return ""
end

local palette = require("nightfox.palette").load(Cange.get_config("colorscheme"))

return {
  lazy_status.updates,
  cond = lazy_status.has_updates,
  color = { fg = palette.fg3 },
}
