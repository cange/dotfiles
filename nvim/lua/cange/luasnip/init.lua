local ns = 'cange.luasnip'
local found_luasnip, luasnip = pcall(require, 'luasnip')
if not found_luasnip then
  print('[' .. ns .. '] "luasnip" not found')
  return
end
local vscode_loader = require('luasnip.loaders.from_vscode')
-- -- local found_choices_ui, choices_ui = pcall(require, 'cange.luasnip.choices-ui')
-- -- if not found_choices_ui then
-- --   print('[' .. ns .. '] "cange.luasnip.choices-ui" not found')
-- -- end
local found_snippets, snippets = pcall(require, 'cange.snippets')
if not found_snippets then
  print('[' .. ns .. '] "cange.snippets" not found')
end
-- local found_utils, utils = pcall(require, 'cange.utils')
-- if not found_utils then
--   print('[' .. ns .. '] "cange.utils" not found')
-- end
-- local keymap = utils.keymap
--
---Expansion key
---this will expand the current item or jump to the next item within the snippet.

-- keymap({ 'i', 's' }, '<C-k>', function()
--   if luasnip.expand_or_jumpable() then
--     luasnip.expand_or_jump()
--   end
-- end)
--
-- ---Jump backwards key.
-- ---this always moves to the previous item within the snippet
-- keymap({ 'i', 's' }, '<C-j>', function()
--   if luasnip.jumpable(-1) then
--     luasnip.jump(-1)
--   end
-- end)

-- ---Selecting within a list of options.
-- ---This is useful for choice nodes (introduced in the forthcoming episode 2)
-- ---Go forwards within choice options
-- keymap('i', '<C-]>', function()
--   if luasnip.choice_active() then
--     luasnip.change_choice(1)
--   end
-- end)
-- ---Go backwards within coice options
-- keymap('i', '<C-[>', function()
--   if luasnip.choice_active() then
--     luasnip.change_choice(-1)
--   end
-- end)
--
-- keymap('i', '<C-u>', require('luasnip.extras.select_choice'))

-- shorcut to source my luasnips file again, which will reload my snippets
-- keymap('n', '<leader><leader>s', ':luafile ~/.config/nvim/lua/cange/luasnip/init.lua<CR>')
-- init
--
-- choices_ui.setup()
vscode_loader.lazy_load()
vscode_loader.load({ paths = snippets.path })

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
