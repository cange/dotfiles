--- Provides which-key plugins keybindings
local M = {}

M.opts = {
  mode = 'n', -- NORMAL mode
  prefix = '<leader>',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer M.mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}


local found_settings, editor_settings = pcall(require, 'cange.settings.editor')
if not found_settings then
  vim.notify('telescope: "cange.editor_settings.editor" could not be found')
  return
end

---Generates a which-key table form mappings
--- @param section_key string Key of a keybinding block
--- @param block_name string Name of block name
--- @return table which-key mappings bock
local function mapping_by_block(section_key, block_name)
  local keymaps = { name = block_name }
  for key, props in pairs(editor_settings[section_key].mappings) do
    keymaps[key] = { props.command, props.label }
  end
  return keymaps
end

M.mappings = {
  -- ['/'] = { '<cmd>lua require("Comment.api").toggle_current_linewise()<CR>', 'Comment' },
  ['a'] = { '<cmd>Alpha<CR>', 'Start screen' },

  s = mapping_by_block('session', 'Session'),
  g = mapping_by_block('git', 'Git'),
  l = mapping_by_block('lsp', 'LSP'),
  p = mapping_by_block('packer', 'Packer'),
  f = mapping_by_block('telescope', 'Search'),

  ['b'] = {
    '<cmd>lua require("telescope.builtin").buffers(require(:telescope.themes").get_dropdown{previewer = false})<cr>',
    'Buffers',
  },
  ['c'] = { '<cmd>Bdelete!<CR>', 'Close Buffer' },
  ['='] = { ':lua vim.lsp.buf.formatting_seq_sync()<CR>', 'File formatting' },
  ['e'] = { '<cmd>NvimTreeToggle<cr>', 'Explorer' },
  ['w'] = { '<cmd>w!<CR>', 'Save' },
  ['q'] = { '<cmd>q!<CR>', 'Quit' },
  --
  --   t = {
  --     name = 'Terminal',
  --     n = { '<cmd>lua _NODE_TOGGLE()<cr>', 'Node' },
  --     u = { '<cmd>lua _NCDU_TOGGLE()<cr>', 'NCDU' },
  --     t = { '<cmd>lua _HTOP_TOGGLE()<cr>', 'Htop' },
  --     p = { '<cmd>lua _PYTHON_TOGGLE()<cr>', 'Python' },
  --     f = { '<cmd>ToggleTerm direction=float<cr>', 'Float' },
  --     h = { '<cmd>ToggleTerm size=10 direction=horizontal<cr>', 'Horizontal' },
  --     v = { '<cmd>ToggleTerm size=80 direction=vertical<cr>', 'Vertical' },
  --   },
}
--
M.vopts = {
  mode = 'v', -- VISUAL mode
  prefix = '<leader>',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
M.vmappings = {
  --   ['/'] = { '<ESC><CMD>lua require(\'Comment.api\').toggle_linewise_op(vim.fn.visualmode())<CR>', 'Comment' },
}

return M
