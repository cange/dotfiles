local found_greetings, greetings = pcall(require, 'cange.uils.greetings')
if not found_greetings then
  print('[utils] "cange.utils.greetings"  not found')
  return
end

return {
  greetings = greetings,
}
