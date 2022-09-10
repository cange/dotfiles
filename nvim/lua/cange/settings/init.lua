local found_meta, meta = pcall(require, 'cange.settings.meta')
if not found_meta then
  vim.notify('settings: "cange.settings.meta" could not be found')
  return
end
local found_editor, editor = pcall(require, 'cange.settings.editor')
if not found_editor then
  vim.notify('settings: "cange.settings.editor" could not be found')
  return
end

return {
  meta = meta,
  editor = editor,
}
