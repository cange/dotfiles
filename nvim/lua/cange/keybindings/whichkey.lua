local ns = "cange.keybindings.whichkey"

local found_whichkey, whichkey = pcall(require, "which-key")
if not found_whichkey then
  print("[" .. ns .. '] "which-key" not found')
  return
end
local found_workflows, wk_groups = pcall(require, "cange.keybindings.whichkey_groups")
if not found_workflows then
  print("[" .. ns .. '] "cange.keybindings.whichkey_groups" not found')
  return
end
local found_utils, utils = pcall(require, "cange.utils")
if not found_utils then
  print("[" .. ns .. '] "cange.utils" not found')
  return
end

---Generates a which-key table form mappings
-- @param group string Key of a keybinding block
-- @return table<string, table> mappings bock i.e. { <leader> = { command, title  } }
local function group_mappings(group)
  local section = {}
  -- vim.pretty_print(vim.tbl_keys(group))
  section[group.subleader] = { name = group.title }

  local section_mappings = section[group.subleader]

  for key, m in pairs(group.mappings) do
    section_mappings[key] = { m.command, m.title }
  end

  return section
end

local custom_mappings = {}
for _, m in pairs(wk_groups) do
  custom_mappings = vim.tbl_extend("keep", custom_mappings, group_mappings(m))
end

local wk_mappings = vim.tbl_deep_extend("keep", {
  ["a"] = { "<cmd>Alpha<CR>", "Start screen" },
  ["f"] = { "<cmd>Telescope find_files<CR>", "Find files" },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "File Explorer" },
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
}, custom_mappings)

local M = {}

function M.setup()
  whichkey.setup({
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
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
      border = "rounded", -- none, single, double, rounded, shadow
      margin = { 0, 8, 2, 8 }, -- extra window margin [top, right, bottom, left]
      padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 2,
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = "left", -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {'<leader>'} -- or specify a list manually
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { "j", "k" },
      v = { "j", "k" },
    },
  })

  whichkey.register(wk_mappings, {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer M.mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  })
end

return M
