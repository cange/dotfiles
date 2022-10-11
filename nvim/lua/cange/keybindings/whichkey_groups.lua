--#region Types

---@class MappingTree
---@field desc string
---@field cmd string

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
    B = { cmd = "<cmd>Telescope buffers previewer=false<CR>", desc = "Buffers" },
    C = { cmd = "<cmd>Telescope cmds<CR>", desc = "cmds" },
    M = { cmd = "<cmd>Telescope man_pages<CR>", desc = "Man pages" },
    N = { cmd = "<cmd>Telescope notify<CR>", desc = "Notifications" },
    b = { cmd = '<cmd>lua require("cange.telescope.custom").file_browser()<CR>', desc = "Browse files" },
    c = { cmd = "<cmd>Telescope colorscheme<CR>", desc = "Change theme" },
    f = { cmd = "<cmd>Telescope find_files<CR>", desc = "Find files" },
    h = { cmd = "<cmd>Telescope help_tags<CR>", desc = "Find help" },
    k = { cmd = "<cmd>Telescope keymaps<CR>", desc = "Keymaps" },
    n = { cmd = '<cmd>lua require("cange.telescope.custom").browse_nvim()<CR>', desc = "Browse nvim" },
    r = { cmd = "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
    p = { cmd = "<cmd>Telescope projects<CR>", desc = "Projects" },
    s = { cmd = "<cmd>Telescope live_grep<CR>", desc = "Find text" },
    w = { cmd = '<cmd>lua require("cange.telescope.custom").browse_workspace()<CR>', desc = "Browse workspace" },
  },
}

---@alias config Mapping
M.config = {
  subleader = "c",
  title = "Editor config",
  mappings = {
    k = { cmd = "<cmd>e ~/.config/nvim/lua/cange/keymaps/mappings.lua<CR>", desc = "Edit keybindings" },
    m = { cmd = "<cmd>e ~/.config/nvim/lua/cange/meta.lua<CR>", desc = "Edit meta information" },
    o = { cmd = "<cmd>e ~/.config/nvim/lua/cange/options.lua<CR>", desc = "Edit options" },
    p = { cmd = "<cmd>e ~/.config/nvim/lua/cange/plugins.lua<CR>", desc = "Edit plugins" },
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

---@alias paccker Mapping Install, update neovims plugins
M.packer = {
  subleader = "p",
  title = "Plugin management",
  mappings = {
    S = { cmd = "<cmd>PackerStatus<CR>", desc = "Status" },
    c = { cmd = "<cmd>PackerCompile<CR>", desc = "Compile" },
    i = { cmd = "<cmd>PackerInstall<CR>", desc = "Install" },
    s = { cmd = "<cmd>PackerSync<CR>", desc = "Sync" },
    u = { cmd = "<cmd>PackerUpdate<CR>", desc = "Update" },
    C = { cmd = "<cmd>e ~/.config/nvim/lua/cange/plugins.lua<CR>", desc = "Config" },
  },
}

---@alias session Mapping
M.session = {
  subleader = "b",
  title = "Sessions/Buffers",
  mappings = {
    R = { cmd = "<cmd>RestoreSession<CR>", desc = "Recent session" },
    d = { cmd = "<cmd>Autosession delete<CR>", desc = "Find delete session" },
    f = { cmd = "<cmd>SearchSession<CR>", desc = "Find session" },
    s = { cmd = "<cmd>SaveSession<CR>", desc = "Save session" },
    x = { cmd = "<cmd>DeleteSession<CR>", desc = "Delete session" },
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
