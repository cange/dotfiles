local found_lazy, lazy_status = pcall(require, "lazy.status")
if not found_lazy then
  return ""
end

return {
  lazy_status.updates,
  cond = lazy_status.has_updates,
  color = { fg = Cange.palette.fg1 },
}
