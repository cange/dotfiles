local found_greetings, greetings = pcall(require, 'cange.uils.greetings')
if not found_greetings then
  vim.notify('utils: "cange.utils.greetings" could not be found')
  return
end

return {
  greetings = greetings,
}
