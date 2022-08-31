local ok, ls = pcall(require, 'luasnip')
if not ok then return end

local theme_ok, _ = pcall(require, 'nightfox')
if not ok or not theme_ok then return end

local color = require('nightfox.palette').load('terafox')
local types = require('luasnip.util.types')

-- Adds a dot to the end of the line to show if inside a choices insert mode
local insert_or_choice_indicator = {
  [types.choiceNode] = {
    active = {
      virt_text = { { '●', color.orange.base } }
    },
  },
  [types.insertNode] = {
    active = {
      virt_text = { { '●', color.blue.base } }
    },
  },
}
require('luasnip.loaders.from_vscode').lazy_load()

local custom_snippets_ok, _ = pcall(require, 'cange.snippets')
if custom_snippets_ok then
  require('luasnip.loaders.from_vscode').load({ paths = './lua/cange/snippets' })
end

ls.config.setup({
  ext_opts = insert_or_choice_indicator,
})

-- activate ChoiceNode popup
require('cange.luasnip.choice-node-popup')

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
