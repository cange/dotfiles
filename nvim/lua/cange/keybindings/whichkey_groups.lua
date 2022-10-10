---Provides general settings
local M = {}

---Mappings tries to organise global used keybindings on one place
---Pattern: <block_key> = { { <key> = { command = '...', title = '...' } } }
---@table mappings

---Language related syntax analytics
M.lsp = {
  subleader = "l",
  title = "Language (LSP)",
  mappings = {
    C = { command = '<cmd>lua require("luasnip").cleanup()<CR>', title = "Reset snippets UI" },
    F = { command = "<cmd>lua vim.lsp.buf.format({ async = true, timeout_ms = 10000 })<CR>", title = "Format" },
    N = { command = "<cmd>NullLsInfo<CR>", title = "Info Null-ls" },
    c = { command = vim.lsp.buf_get_clients, title = "LSP clients" },
    d = { command = '<cmd>lua require("cange.telescope.custom").diagnostics_log()<CR>', title = "Diagnostics log" },
    i = { command = "<cmd>LspInfo<CR>", title = "Info LSP" },
    q = { command = vim.lsp.buf.code_action, title = "Quickfix issue" },
    l = { command = vim.diagnostic.setloclist, title = "Show current issues" },
    n = { command = vim.diagnostic.goto_next, title = "Go to next issue" },
    p = { command = vim.diagnostic.goto_prev, title = "Go to previous issue" },
    s = { command = "<cmd>Mason<CR>", title = "Sync LSP (Mason)" },
  },
}

---Finding stuff
M.search = {
  subleader = "s",
  title = "Search",
  mappings = {
    B = { command = "<cmd>Telescope buffers previewer=false<CR>", title = "Buffers" },
    C = { command = "<cmd>Telescope commands<CR>", title = "Commands" },
    M = { command = "<cmd>Telescope man_pages<CR>", title = "Man pages" },
    N = { command = "<cmd>Telescope notify<CR>", title = "Notifications" },
    b = { command = '<cmd>lua require("cange.telescope.custom").file_browser()<CR>', title = "Browse files" },
    c = { command = "<cmd>Telescope colorscheme<CR>", title = "Change theme" },
    f = { command = "<cmd>Telescope find_files<CR>", title = "Find files" },
    h = { command = "<cmd>Telescope help_tags<CR>", title = "Find help" },
    k = { command = "<cmd>Telescope keymaps<CR>", title = "Keymaps" },
    n = { command = '<cmd>lua require("cange.telescope.custom").browse_nvim()<CR>', title = "Browse nvim" },
    r = { command = "<cmd>Telescope oldfiles<CR>", title = "Recent files" },
    p = { command = "<cmd>Telescope projects<CR>", title = "Projects" },
    s = { command = "<cmd>Telescope live_grep<CR>", title = "Find text" },
    w = { command = '<cmd>lua require("cange.telescope.custom").browse_workspace()<CR>', title = "Browse workspace" },
  },
}

M.config = {
  subleader = "c",
  title = "Editor config",
  mappings = {
    k = { command = "<cmd>e ~/.config/nvim/lua/cange/keymaps/mappings.lua<CR>", title = "Edit keybindings" },
    m = { command = "<cmd>e ~/.config/nvim/lua/cange/meta.lua<CR>", title = "Edit meta information" },
    o = { command = "<cmd>e ~/.config/nvim/lua/cange/options.lua<CR>", title = "Edit options" },
    p = { command = "<cmd>e ~/.config/nvim/lua/cange/plugins.lua<CR>", title = "Edit plugins" },
  },
}

M.git = {
  subleader = "g",
  title = "Git",
  mappings = {
    l = { command = "<cmd>Gitsigns toggle_current_line_blame<CR>", title = "Line blame" },
    R = { command = "<cmd>Gitsigns reset_buffer<CR>", title = "Reset buffer" },
    B = { command = "<cmd>Telescope git_branches<CR>", title = "Checkout branch" },
    C = { command = "<cmd>Telescope git_commits<CR>", title = "Checkout commit" },
    d = { command = "<cmd>Gitsigns diffthis HEAD<CR>", title = "Diff" },
    g = { command = "<cmd>lua CangeLazygitToggle()<CR>", title = "Lazygit" },
    o = { command = "<cmd>Telescope git_status<CR>", title = "Open changed file" },
    j = { command = '<cmd>lua require("gitsigns").next_hunk()<CR>', title = "Next hunk" },
    k = { command = '<cmd>lua require("gitsigns").prev_hunk()<CR>', title = "Prev hunk" },
    p = { command = '<cmd>lua require("gitsigns").preview_hunk()<CR>', title = "Preview hunk" },
    r = { command = '<cmd>lua require("gitsigns").reset_hunk()<CR>', title = "Reset hunk" },
    s = { command = '<cmd>lua require("gitsigns").stage_hunk()<CR>', title = "Stage hunk" },
    u = { command = '<cmd>lua require("gitsigns").undo_stage_hunk()<CR>', title = "Undo stage hunk" },
  },
}

---Install, update neovims plugins
M.packer = {
  subleader = "p",
  title = "Plugin management",
  mappings = {
    S = { command = "<cmd>PackerStatus<CR>", title = "Status" },
    c = { command = "<cmd>PackerCompile<CR>", title = "Compile" },
    i = { command = "<cmd>PackerInstall<CR>", title = "Install" },
    s = { command = "<cmd>PackerSync<CR>", title = "Sync" },
    u = { command = "<cmd>PackerUpdate<CR>", title = "Update" },
    C = { command = "<cmd>e ~/.config/nvim/lua/cange/plugins.lua<CR>", title = "Config" },
  },
}
M.session = {
  subleader = "b",
  title = "Sessions/Buffers",
  mappings = {
    R = { command = "<cmd>RestoreSession<CR>", title = "Recent session" },
    d = { command = "<cmd>Autosession delete<CR>", title = "Find delete session" },
    f = { command = "<cmd>SearchSession<CR>", title = "Find session" },
    s = { command = "<cmd>SaveSession<CR>", title = "Save session" },
    x = { command = "<cmd>DeleteSession<CR>", title = "Delete session" },
  },
}

M.terminal = {
  subleader = "t",
  title = "Terminal",
  mappings = {
    ["1"] = { command = ":1ToggleTerm size=80 direction=vertical<CR>", title = "VTerminal 1" },
    ["2"] = { command = ":2ToggleTerm size=80 direction=vertical<CR>", title = "VTerminal 2" },
    ["3"] = { command = ":3ToggleTerm<CR>", title = "HTerminal 1" },
    ["4"] = { command = ":4ToggleTerm<CR>", title = "HTerminal 2" },
    f = { command = "<cmd>ToggleTerm direction=float<CR>", title = "Float" },
    h = { command = "<cmd>ToggleTerm size=10 direction=horizontal<CR>", title = "Horizontal" },
    v = { command = "<cmd>ToggleTerm size=80 direction=vertical<CR>", title = "Vertical" },
  },
}

M.treesitter = {
  subleader = "T",
  title = "Treesitter (syntax)",
  mappings = {
    h = { command = "<cmd>TSHighlightCapturesUnderCursor<cr>", title = "Highlight" },
    p = { command = "<cmd>TSPlaygroundToggle<cr>", title = "Playground" },
    r = { command = "<cmd>TSToggle rainbow<cr>", title = "Rainbow" },
  },
}

return M
