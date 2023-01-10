local ns = "[plugins.whichkey]"

-- Keybinding

---Generates a which-key table form mappings
---@param group WhichKeyGroup Key of a keybinding block
---@return table<string, table> mappings bock i.e. { <leader> = { command, title  } }
local function group_mappings(group)
  local section = {}
  -- vim.pretty_print(ns, group.title, group.subleader,vim.tbl_keys(group))
  section[group.subleader] = { name = group.title }

  local section_mappings = section[group.subleader]

  for key, m in pairs(group.mappings) do
    -- Ignore primary keys
    if m.primary then
      goto skip
    end
    section_mappings[key] = { m.cmd, m.desc }
    ::skip::
  end

  return section
end

---Generates a which-key primary mapping table
---@param group WhichKeyGroup Key of a keybinding block
---@param mappings table List to store mappings
local function primary_mappings(group, mappings)
  -- vim.pretty_print(ns, 'primary_mappings', vim.tbl_keys(group))
  for key, m in pairs(group.mappings) do
    -- vim.pretty_print(ns, 'primary_mappings', m.desc, m.primary)
    -- Primary keys only
    if not m.primary then
      goto skip
    end
    mappings[key] = { m.cmd, m.desc }
    ::skip::
  end
end

local found_groups, whichkey_groups = pcall(require, "cange.utils.whichkey_groups")
if not found_groups then
  print(ns, '"cange.utils.whichkey_groups" not found')
  return
end

return {
  "folke/which-key.nvim",
  -- dependencies = {
  --   "cange.utils.whichkey_groups",
  -- },
  config = function()
    local primary_keymaps = {}
    local secondary_keymaps = {}
    local wk_mappings = {}
    -- execute
    for _, g in pairs(whichkey_groups.get()) do
      secondary_keymaps = vim.tbl_extend("keep", secondary_keymaps, group_mappings(g))
      primary_mappings(g, primary_keymaps)
    end

    -- vim.pretty_print(ns, primary_keymaps)
    wk_mappings = vim.tbl_deep_extend("keep", primary_keymaps, secondary_keymaps)

    require("which-key").setup({
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on ' in NORMAL or <C-r> in INSERT mode
        spelling = {
          enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 24, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
          operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
          motions = true, -- adds help for motions
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
      icons = {
        breadcrumb = Cange.get_icon("which_key.Breadcrumb"),
        separator = Cange.get_icon("which_key.Separator", { trim = true }),
        group = Cange.get_icon("which_key.Group"),
      },
      popup_mappings = {
        scroll_down = "<C-s>", -- binding to scroll down inside the popup
        scroll_up = "<C-a>", -- binding to scroll up inside the popup
      },
      window = {
        border = "rounded", -- none, single, double, rounded, shadow
        margin = { 0, 8, 2, 8 }, -- extra window margin [top, right, bottom, left]
        padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 2,
      },
      layout = {
        height = { min = 4, max = 24 }, -- min and max height of the columns
        width = { min = 4, max = 150 }, -- min and max width of the columns
        spacing = 4, -- spacing between columns
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

    require("which-key").register(wk_mappings, {
      mode = "n", -- NORMAL mode
      prefix = "<leader>",
      buffer = nil, -- Global mappings. Specify a buffer number for buffer M.mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
    })
  end
}
