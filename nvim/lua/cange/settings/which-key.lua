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
---@param section_key string Key of a keybinding block
---@param block_name string Name of block name
---@return table<string, table> mappings bock i.e. { subleader: { name: 'foo', a: b } }
local function workflow_section(section_key, block_name)
  local section = {}
  local section_settings = editor_settings[section_key]
  local subleader = section_settings.meta.subleader
  section[subleader] = { name = block_name }
  local section_mappings = section[subleader]

  for key, props in pairs(section_settings.mappings) do
    section_mappings[key] = { props.command, props.label }
  end

  return section
end

local default_mappings = {
  ['a'] = { '<cmd>Alpha<CR>', 'Start screen' },
  ['b'] = {
    '<cmd>lua require("telescope.builtin").buffers(require(:telescope.themes").get_dropdown{previewer = false})<CR>',
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

M.mappings = vim.tbl_deep_extend('keep',
  default_mappings,
  workflow_section('session', 'Session'),
  workflow_section('git', 'Git'),
  workflow_section('lsp', 'LSP'),
  workflow_section('packer', 'Packer'),
  workflow_section('telescope', 'Search')
)

M.vopts = {
  mode = 'v', -- VISUAL mode
  prefix = '<leader>',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
M.vmappings = {
}

return M
