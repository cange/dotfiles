local found_fidget, fidget = pcall(require, "fidget")
if not found_fidget then
  return
end

fidget.setup({
  text = {
    spinner = "dots",
  },
})
