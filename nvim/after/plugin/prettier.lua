local found_prettier, prettier = pcall(require, 'prettier')
if not found_prettier then
  return
end

local found_settings, editor_settings = pcall(require, 'cange.settings.editor')
if not found_settings then
  vim.notify('prettier: "cange.settings" could not be found')
  return
end

prettier.setup({
  bin = 'prettierd', -- pretty fast prettier version
  filetypes = editor_settings.prettier.filetypes,
})
