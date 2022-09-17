local found, ls = pcall(require, 'luasnip')
if not found then
  return
end

local found_from_vscode, from_vscode = pcall(require, 'luasnip.loaders.from_vscode')
if not found_from_vscode then
  vim.notify('luasnip: "luasnip.loaders.from_vscode" could not be found')
  return
end

from_vscode.lazy_load()

local found_snippets, snippets = pcall(require, 'cange.snippets')
if found_snippets then
  from_vscode.load({ paths = snippets.paths })
else
  vim.notify('luasnip: "cange.snippets" could not be found')
end

ls.config.setup({
  -- ext_opts = insert_or_choice_indicator,
})

-- Activate ChoiceNode popup
local found_choice_popop, _ = pcall(require, 'cange.luasnip.choice-popup')
if not found_choice_popop then
  vim.notify('luasnip: "cange.luasnip.choice-popup" could not be found')
  return
end

-- local found_colorscheme, colorscheme = pcall(require, 'cange.colorscheme')
-- if not found_colorscheme then
--   vim.notify('colorscheme: "cange.colorscheme" could not be found')
--   return
-- end
-- local color = colorscheme.palette()
-- local types = require('luasnip.util.types')
-- Adds a dot to the end of the line to show if inside a choices insert mode
-- local insert_or_choice_indicator = {
--   [types.choiceNode] = {
--     active = {
--       virt_text = { { '●', color.orange.base } }
--     },
--   },
--   [types.insertNode] = {
--     active = {
--       virt_text = { { '●', color.blue.base } }
--     },
--   },
-- }

-- local keymap = vim.api.nvim_set_keymap
-- local keymap = vim.keymap.set
-- local opts = {
--   noremap = true,
--   silent = true,
-- }
-- keymap('i', '<C-up>', '<Plug>luasnip-prev-choice', opts)
-- keymap('i', '<C-down>', '<Plug>luasnip-next-choice', opts)
-- TODOs
-- - jump to opposite edge when at end/beginning of list
-- - detect when popup choices available
-- keymap('i', '<down>', function()
--   if ls.choice_active() then -- travel forwards within choices
--     print('DOWN: get_current_choices: ' .. vim.inspect(ls.get_current_choices()))
--     return '<Plug>luasnip-next-choice'
--     -- return ls.change_choice(1)
--   else
--     return '<Nop>'
--   end
-- end, opts)
--
-- keymap('i', '<up>', function()
--   if ls.choice_active() then -- travel forwards within choices
--     print('UP: get_current_choices: ' .. vim.inspect(ls.get_current_choices()))
--     return '<Plug>luasnip-prev-choice'
--     -- return ls.change_choice(-1)
--   else
--     return '<Nop>'
--   end
-- end, opts)
