local ns = 'luasnip.init'
local found_luasnip, luasnip = pcall(require, 'luasnip')
if not found_luasnip then
  print('[' .. ns .. '] "luasnip" not found')
  return
end
local vscode_loader = require('luasnip.loaders.from_vscode')
local found_snippets, snippets = pcall(require, 'cange.snippets')
if found_snippets then
  vscode_loader.load({ paths = snippets.paths })
else
  print('[' .. ns .. '] "cange.snippets" not found')
end
local found_options, _ = pcall(require, 'cange.luasnip.choice-options')
if not found_options then
  print('[' .. ns .. '] "cange.luasnip.choice-options" not found')
  return
end

vscode_loader.lazy_load()

-- -- Adds a dot to the end of the line to show if inside a choices insert mode
-- local keymap = vim.api.nvim_set_keymap
-- local keymap = vim.keymap.set
-- local opts = {
--   noremap = true,
--   silent = true,
-- }
-- keymap('i', '<C-up>', '<Plug>luasnip-prev-choice', opts)
-- keymap('i', '<C-down>', '<Plug>luasnip-next-choice', opts)
-- -- TODOs
-- -- - jump to opposite edge when at end/beginning of list
-- -- - detect when popup choices available
-- keymap('i', '<down>', function()
--   if luasnip.choice_active() then -- travel forwards within choices
--     print('DOWN: get_current_choices: ' .. vim.inspect(luasnip.get_current_choices()))
--     return '<Plug>luasnip-next-choice'
--     -- return ls.change_choice(1)
--   else
--     return '<Nop>'
--   end
-- end, opts)
--
-- keymap('i', '<up>', function()
--   if luasnip.choice_active() then -- travel forwards within choices
--     print('UP: get_current_choices: ' .. vim.inspect(luasnip.get_current_choices()))
--     return '<Plug>luasnip-prev-choice'
--     -- return ls.change_choice(-1)
--   else
--     return '<Nop>'
--   end
-- end, opts)
