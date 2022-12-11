local ns = "[cange.keymaps.groups]"
-- All main key bindings to open certain function are defined here. Individual plugin internal bindings are handled in
-- each plugin by it self.
--
---@class cange.keymaps.Command
---@field desc string Description of the keybinding
---@field cmd string Command of the keybinding
---@field dashboard? boolean Determines whether or not to on "alpha" start page
---@field icon? cange.core.Icon The icon which shown on "alpha" start page
---@field primary? boolean Determines whether or not to show a on inital "which-key" window
--
---@class cange.keymaps.Group
---@field subleader string Additional key to enter the certain group
---@field title string Is displayed as group name
---@field mappings table<string, cange.keymaps.Command> The actual key bindings
--
---@class cange.keymaps.Groups
---@field config cange.keymaps.Group
---@field git cange.keymaps.Group
---@field lsp cange.keymaps.Group Language related syntax analytics
---@field packer cange.keymaps.Group Install, update neovims plugins
---@field search cange.keymaps.Group Finding stuff
---@field session cange.keymaps.Group
---@field treesitter cange.keymaps.Group

---Provides general settings
---@type cange.keymaps.Groups
local M = {}

M.lsp = {
  subleader = "l",
  title = "LSP Feature",
  mappings = {
    C = { cmd = '<cmd>lua require("luasnip").cleanup()<CR>', desc = "Reset snippets UI" },
    ["<F2>"] = { cmd = "<cmd>lua vim.lsp.buf.format({ async = true, timeout_ms = 10000 })<CR>", desc = "Format" },
    N = { cmd = "<cmd>NullLsInfo<CR>", desc = "Info Null-ls" },
    c = { cmd = vim.lsp.buf_get_clients, desc = "LSP clients" },
    d = { cmd = '<cmd>lua require("cange.telescope.custom").diagnostics_log()<CR>', desc = "Diagnostics log" },
    f = { cmd = "<cmd>CangeLSPToggleAutoFormat<CR>", desc = "Toggle Auto Formatting" },
    i = { cmd = "<cmd>LspInfo<CR>", desc = "Info LSP" },
    l = { cmd = vim.diagnostic.setloclist, desc = "Show current issues" },
    n = { cmd = vim.diagnostic.goto_next, desc = "Go to next issue" },
    o = { cmd = "<cmd>SymbolsOutline<CR>", desc = "Symbols Outline" },
    p = { cmd = vim.diagnostic.goto_prev, desc = "Go to previous issue" },
    q = { cmd = vim.lsp.buf.code_action, desc = "Quickfix issue" },
    s = { cmd = "<cmd>Mason<CR>", desc = "Sync LSP (Mason)" },
  },
}
M.search = {
  subleader = "s",
  title = "Search",
  mappings = {
    B = { cmd = "<cmd>Telescope buffers<CR>", desc = "Recent Files", primary = true },
    C = { cmd = "<cmd>Telescope commands<CR>", desc = "Commands" },
    F = {
      cmd = "<cmd>Telescope live_grep<CR>",
      desc = "Find Text",
      primary = true,
      dashboard = true,
      icon = Cange.get_icon("ui.List"),
    },
    M = { cmd = "<cmd>Telescope man_pages<CR>", desc = "Man Pages" },
    N = { cmd = "<cmd>Telescope notify<CR>", desc = "Notifications" },
    P = {
      cmd = "<cmd>lua require('telescope').extensions.project.project()<CR>",
      desc = "Projects",
      dashboard = true,
      icon = Cange.get_icon("ui.Project"),
    },
    b = { cmd = '<cmd>lua require("cange.telescope.custom").file_browser()<CR>', desc = "Browse files" },
    c = { cmd = "<cmd>Telescope colorscheme<CR>", desc = "Change theme" },
    f = {
      cmd = "<cmd>Telescope find_files<CR>",
      desc = "Find files",
      primary = true,
      dashboard = true,
      icon = Cange.get_icon("ui.Search"),
    },
    h = { cmd = "<cmd>Telescope help_tags<CR>", desc = "Find help" },
    k = { cmd = "<cmd>Telescope keymaps<CR>", desc = "Keymaps" },
    n = { cmd = '<cmd>lua require("cange.telescope.custom").browse_nvim()<CR>', desc = "Browse nvim" },
    r = {
      cmd = "<cmd>Telescope oldfiles<CR>",
      desc = "Old files",
      dashboard = true,
      icon = Cange.get_icon("ui.Calendar"),
    },
    w = { cmd = '<cmd>lua require("cange.telescope.custom").browse_workspace()<CR>', desc = "Browse workspace" },
  },
}
M.config = {
  subleader = "c",
  title = "Editor",
  mappings = {
    E = {
      cmd = "<cmd>enew <BAR>startinsert<CR>",
      desc = "New File",
      dashboard = true,
      icon = Cange.get_icon("documents", "NewFile"),
    },
    a = { cmd = "<cmd>Alpha<CR>", desc = "Start Screen", primary = true },
    e = { cmd = "<cmd>NvimTreeToggle<CR>", desc = "File Explorer", primary = true },
    k = { cmd = "<cmd>e ~/.config/nvim/lua/cange/keymaps/groups.lua<CR>", desc = "Edit Keymaps" },
    m = { cmd = "<cmd>e ~/.config/nvim/lua/cange/config.lua<CR>", desc = "Edit Config" },
    o = { cmd = "<cmd>e ~/.config/nvim/lua/cange/options.lua<CR>", desc = "Edit Options" },
    q = {
      cmd = "<cmd>quitall!<CR>",
      desc = "Quit",
      primary = true,
      dashboard = true,
      icon = Cange.get_icon("ui", "SignOut"),
    },
    w = { cmd = "<cmd>w!<CR>", desc = "Save", primary = true },
  },
}
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
      icon = Cange.get_icon("ui", "Gear"),
    },
    i = { cmd = "<cmd>PackerInstall<CR>", desc = "Install" },
    s = { cmd = "<cmd>PackerSync<CR>", desc = "Update plugins", dashboard = true, icon = Cange.get_icon("ui", "Sync") },
  },
}
M.session = {
  subleader = "b",
  title = "Sessions",
  mappings = {
    F = {
      cmd = "<cmd>SearchSession<CR>",
      desc = "Find Session",
      dashboard = true,
      icon = Cange.get_icon("ui.SignIn"),
    },
    R = {
      cmd = "<cmd>RestoreSession<CR>",
      desc = "Recent Project",
      dashboard = true,
      icon = Cange.get_icon("ui.Calendar"),
    },
    s = { cmd = "<cmd>SaveSession<CR>", desc = "Save Session" },
    x = { cmd = "<cmd>DeleteSession<CR>", desc = "Delete Session" },
  },
}
M.treesitter = {
  subleader = "T",
  title = "Tree-sitter",
  mappings = {
    h = { cmd = "<cmd>TSHighlightCapturesUnderCursor<cr>", desc = "Highlight" },
    p = { cmd = "<cmd>TSPlaygroundToggle<cr>", desc = "Playground" },
    r = { cmd = "<cmd>TSToggle rainbow<cr>", desc = "Rainbow" },
  },
}

return M
