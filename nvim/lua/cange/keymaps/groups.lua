---Represents the most global keymaps mainly used in which-key and alpha (dasboard) plugins.
local ns = "cange.keymaps.groups"

local found_utils, utils = pcall(require, "cange.utils")
if not found_utils then
  print("[" .. ns .. '] "cange.utils" not found')
  return
end
local icon = utils.get_icon

--#region Types

---@class MappingTree
---@field desc string
---@field cmd string
---@field dashboard? boolean
---@field icon? string

---@enum mappings <string, MappingTree>

---@class Mapping
---@field subleader string Additional key to enter the certain group
---@field title string Is displayed as group name
---@field mappings mappings The actual key bindings

--#endregion

---Provides general settings
local M = {}

---Mappings tries to organise global used keybindings on one place
---Pattern: <block_key> = { { <key> = { cmd = '...', desc = '...' } } }
---@table mappings

---@alias lsp Mapping Language related syntax analytics
M.lsp = {
  subleader = "l",
  title = "Language (LSP)",
  mappings = {
    C = { cmd = '<cmd>lua require("luasnip").cleanup()<CR>', desc = "Reset snippets UI" },
    F = { cmd = "<cmd>lua vim.lsp.buf.format({ async = true, timeout_ms = 10000 })<CR>", desc = "Format" },
    N = { cmd = "<cmd>NullLsInfo<CR>", desc = "Info Null-ls" },
    c = { cmd = vim.lsp.buf_get_clients, desc = "LSP clients" },
    d = { cmd = '<cmd>lua require("cange.telescope.custom").diagnostics_log()<CR>', desc = "Diagnostics log" },
    i = { cmd = "<cmd>LspInfo<CR>", desc = "Info LSP" },
    q = { cmd = vim.lsp.buf.code_action, desc = "Quickfix issue" },
    l = { cmd = vim.diagnostic.setloclist, desc = "Show current issues" },
    n = { cmd = vim.diagnostic.goto_next, desc = "Go to next issue" },
    p = { cmd = vim.diagnostic.goto_prev, desc = "Go to previous issue" },
    s = { cmd = "<cmd>Mason<CR>", desc = "Sync LSP (Mason)" },
  },
}

---@alias search Mapping Finding stuff
M.search = {
  subleader = "s",
  title = "Search",
  mappings = {
    B = { cmd = "<cmd>Telescope buffers<CR>", desc = "Recent files" },
    C = { cmd = "<cmd>Telescope cmds<CR>", desc = "cmds" },
    M = { cmd = "<cmd>Telescope man_pages<CR>", desc = "Man pages" },
    N = { cmd = "<cmd>Telescope notify<CR>", desc = "Notifications" },
    P = { cmd = "<cmd>Telescope projects<CR>", desc = "Projects", dashboard = true, icon = icon("ui", "Project") },
    S = { cmd = "<cmd>Telescope live_grep<CR>", desc = "Find text", dashboard = true, icon = icon("ui", "List") },
    b = { cmd = '<cmd>lua require("cange.telescope.custom").file_browser()<CR>', desc = "Browse files" },
    c = { cmd = "<cmd>Telescope colorscheme<CR>", desc = "Change theme" },
    f = { cmd = "<cmd>Telescope find_files<CR>", desc = "Find files", dashboard = true, icon = icon("ui", "Search") },
    h = { cmd = "<cmd>Telescope help_tags<CR>", desc = "Find help" },
    k = { cmd = "<cmd>Telescope keymaps<CR>", desc = "Keymaps" },
    n = { cmd = '<cmd>lua require("cange.telescope.custom").browse_nvim()<CR>', desc = "Browse nvim" },
    r = { cmd = "<cmd>Telescope oldfiles<CR>", desc = "Old files", dashboard = true, icon = icon("ui", "Calendar") },
    w = { cmd = '<cmd>lua require("cange.telescope.custom").browse_workspace()<CR>', desc = "Browse workspace" },
  },
}

---@alias config Mapping
M.config = {
  subleader = "c",
  title = "Editor",
  mappings = {
    e = {
      cmd = "<cmd>enew <BAR>startinsert<CR>",
      desc = "New File",
      dashboard = true,
      icon = icon("documents", "NewFile"),
    },
    k = { cmd = "<cmd>e ~/.config/nvim/lua/cange/keymaps/groups.lua<CR>", desc = "Edit keymaps" },
    m = { cmd = "<cmd>e ~/.config/nvim/lua/cange/meta.lua<CR>", desc = "Edit meta information" },
    o = { cmd = "<cmd>e ~/.config/nvim/lua/cange/options.lua<CR>", desc = "Edit options" },
    q = { cmd = "<cmd>quitall!<CR>", desc = "Quit", dashboard = true, icon = icon("ui", "SignOut") },
  },
}

---@alias git Mapping
M.git = {
  subleader = "g",
  title = "Git",
  mappings = {
    l = { cmd = "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "Line blame" },
    R = { cmd = "<cmd>Gitsigns reset_buffer<CR>", desc = "Reset buffer" },
    B = { cmd = "<cmd>Telescope git_branches<CR>", desc = "Checkout branch" },
    C = { cmd = "<cmd>Telescope git_commits<CR>", desc = "Checkout commit" },
    d = { cmd = "<cmd>Gitsigns diffthis HEAD<CR>", desc = "Diff" },
    g = { cmd = "<cmd>lua CangeLazygitToggle()<CR>", desc = "Lazygit" },
    o = { cmd = "<cmd>Telescope git_status<CR>", desc = "Open changed file" },
    j = { cmd = '<cmd>lua require("gitsigns").next_hunk()<CR>', desc = "Next hunk" },
    k = { cmd = '<cmd>lua require("gitsigns").prev_hunk()<CR>', desc = "Prev hunk" },
    p = { cmd = '<cmd>lua require("gitsigns").preview_hunk()<CR>', desc = "Preview hunk" },
    r = { cmd = '<cmd>lua require("gitsigns").reset_hunk()<CR>', desc = "Reset hunk" },
    s = { cmd = '<cmd>lua require("gitsigns").stage_hunk()<CR>', desc = "Stage hunk" },
    u = { cmd = '<cmd>lua require("gitsigns").undo_stage_hunk()<CR>', desc = "Undo stage hunk" },
  },
}

---@alias packer Mapping Install, update neovims plugins
M.packer = {
  subleader = "p",
  title = "Plugin management",
  mappings = {
    C = { cmd = "<cmd>PackerCompile<CR>", desc = "Compile" },
    S = { cmd = "<cmd>PackerStatus<CR>", desc = "Status" },
    c = {
      cmd = "<cmd>e ~/.config/nvim/lua/cange/plugins.lua<CR>",
      desc = "Edit plugins",
      dashboard = true,
      icon = icon("ui", "Gear"),
    },
    i = { cmd = "<cmd>PackerInstall<CR>", desc = "Install" },
    u = { cmd = "<cmd>PackerSync<CR>", desc = "Update plugins", dashboard = true, icon = icon("ui", "Sync") },
  },
}

---@alias session Mapping
M.session = {
  subleader = "b",
  title = "Sessions",
  mappings = {
    F = { cmd = "<cmd>SearchSession<CR>", desc = "Find Session", dashboard = true, icon = icon("ui", "SignIn") },
    R = { cmd = "<cmd>RestoreSession<CR>", desc = "Recent Project", dashboard = true, icon = icon("ui", "Calendar") },
    s = { cmd = "<cmd>SaveSession<CR>", desc = "Save Session" },
    x = { cmd = "<cmd>DeleteSession<CR>", desc = "Delete Session" },
  },
}

---@alias terminal Mapping
M.terminal = {
  subleader = "t",
  title = "Terminal",
  mappings = {
    ["1"] = { cmd = ":1ToggleTerm size=80 direction=vertical<CR>", desc = "VTerminal 1" },
    ["2"] = { cmd = ":2ToggleTerm size=80 direction=vertical<CR>", desc = "VTerminal 2" },
    ["3"] = { cmd = ":3ToggleTerm<CR>", desc = "HTerminal 1" },
    ["4"] = { cmd = ":4ToggleTerm<CR>", desc = "HTerminal 2" },
    f = { cmd = "<cmd>ToggleTerm direction=float<CR>", desc = "Float" },
    h = { cmd = "<cmd>ToggleTerm size=10 direction=horizontal<CR>", desc = "Horizontal" },
    v = { cmd = "<cmd>ToggleTerm size=80 direction=vertical<CR>", desc = "Vertical" },
  },
}

---@alias treesitter Mapping
M.treesitter = {
  subleader = "T",
  title = "Treesitter (syntax)",
  mappings = {
    h = { cmd = "<cmd>TSHighlightCapturesUnderCursor<cr>", desc = "Highlight" },
    p = { cmd = "<cmd>TSPlaygroundToggle<cr>", desc = "Playground" },
    r = { cmd = "<cmd>TSToggle rainbow<cr>", desc = "Rainbow" },
  },
}

return M
