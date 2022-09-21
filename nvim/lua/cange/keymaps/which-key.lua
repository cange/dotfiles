local keymaps = _G.bulk_loader('keymaps', {
  { 'cange.keymaps.mappings', 'mappings' },
  { 'which-key', 'which_key' },
})
local utils = _G.bulk_loader('keymaps', { { 'cange.icons', 'icons' } })

keymaps.which_key.setup({
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
  icons = utils.icons.which_key,
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

---Generates a which-key table form mappings
-- @param section_key string Key of a keybinding block
-- @return table<string, table> mappings bock i.e. { <leader> = { command, title  } }
local function workflow_mappings(config)
  local section = {}
  -- vim.pretty_print(vim.tbl_keys(config))
  section[config.subleader] = { name = config.title }

  local section_mappings = section[config.subleader]

  for key, m in pairs(config.mappings) do
    section_mappings[key] = { m.command, m.title }
  end

  return section
end

local wk_mappings = vim.tbl_deep_extend(
  'keep',
  {
    ['a'] = { '<cmd>Alpha<CR>', 'Start screen' },
    ['F'] = { ':lua vim.lsp.buf.formatting_seq_sync(_, 10000)<CR>', 'File Format' },
    ['e'] = { '<cmd>NvimTreeToggle<cr>', 'File Explorer' },
    ['w'] = { '<cmd>w!<CR>', 'Save' },
    ['q'] = { '<cmd>q!<CR>', 'Quit' },
  },
  workflow_mappings(keymaps.mappings.bookmarks),
  workflow_mappings(keymaps.mappings.config),
  workflow_mappings(keymaps.mappings.git),
  workflow_mappings(keymaps.mappings.lsp),
  workflow_mappings(keymaps.mappings.packer),
  workflow_mappings(keymaps.mappings.search),
  -- workflow_mappings(keymaps.mappings.terminal),
  workflow_mappings(keymaps.mappings.session)
)

keymaps.which_key.register(wk_mappings, {
  mode = 'n', -- NORMAL mode
  prefix = '<leader>',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer M.mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
})
