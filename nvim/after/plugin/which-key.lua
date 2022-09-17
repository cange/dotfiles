local found, which_key = pcall(require, 'which-key')
if not found then
  return
end

local found_icons, icons = pcall(require, 'cange.icons')
if not found_icons then
  print('[which-key] "cange.icons" not found')
  return
end

local found_keybindings, keybindings = pcall(require, 'cange.keybindings')
if not found_keybindings then
  print('[which-key] "cange.keybindings" not found')
  return
end
---Generates a which-key table form mappings
-- @param section_key string Key of a keybinding block
-- @param block_name string Name of block name
-- @return table<string, table> mappings bock i.e. { leader: { name: 'foo', a: b } }
local function workflow_mappings(section_key, block_name)
  local section = {}
  local section_bindings = keybindings.mappings[section_key]
  local leader = section_bindings.leader

  section[leader] = { name = block_name }

  local section_mappings = section[leader]

  for key, props in pairs(section_bindings.mappings) do
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
}

local mappings = vim.tbl_deep_extend(
  'keep',
  default_mappings,
  workflow_mappings('git', 'Git'),
  workflow_mappings('language', 'LSP'),
  workflow_mappings('packer', 'Packer'),
  workflow_mappings('search', 'Search'),
  -- workflow_mappings('terminal', 'Terminal'),
  workflow_mappings('session', 'Session')
)

local opts = {
  mode = 'n', -- NORMAL mode
  prefix = '<leader>',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer M.mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}


which_key.setup({
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on ' in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = 'Comments' },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ['<space>'] = 'SPC',
    -- ['<cr>'] = 'RET',
    -- ['<tab>'] = 'TAB',
  },
  icons = icons.which_key,
  popup_mappings = {
    scroll_down = '<c-d>', -- binding to scroll down inside the popup
    scroll_up = '<c-u>', -- binding to scroll up inside the popup
  },
  window = {
    border = 'rounded', -- none, single, double, rounded, shadow
    margin = { 0, 8, 2, 8 }, -- extra window margin [top, right, bottom, left]
    padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 2,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = 'left', -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = 'auto', -- automatically setup triggers
  -- triggers = {'<leader>'} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { 'j', 'k' },
    v = { 'j', 'k' },
  },
})

which_key.register(mappings, opts)
