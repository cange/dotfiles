-- local ns = "[cange.keymaps.whichkey_groups]"
-- All main key bindings to open certain function are defined here. Individual plugin internal bindings are handled in
-- each plugin by it self.
--
---@class WhichKeyCommand
---@field desc string Description of the keybinding
---@field cmd string Command of the keybinding
---@field dashboard? boolean Determines whether or not to on "alpha" start page
---@field icon? CoreIcon The icon which shown on "alpha" start page
---@field primary? boolean Determines whether or not to show a on inital "which-key" window

---@class WhichKeyGroup
---@field subleader string Additional key to enter the certain group
---@field title string Is displayed as group name
---@field mappings table<string, WhichKeyCommand> The actual key bindings

---@class WhichKeyGroups
---@field config WhichKeyGroup
---@field git WhichKeyGroup
---@field lsp WhichKeyGroup Language related syntax analytics
---@field packer WhichKeyGroup Install, update neovims plugins
---@field search WhichKeyGroup Finding stuff
---@field session WhichKeyGroup
---@field treesitter WhichKeyGroup

---@class WhichKeyGroups
local M = {}

M.config = {
  subleader = "c",
  title = "Editor",
  mappings = {
    E = {
      cmd = "<cmd>enew <BAR>startinsert<CR>",
      desc = "New File",
      dashboard = true,
      icon = Cange.get_icon("documents.NewFile"),
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
      icon = Cange.get_icon("ui.SignOut"),
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
    o = { cmd = "<cmd>SymbolsOutline<CR>", desc = "Symbols Outline" },
    q = { cmd = vim.lsp.buf.code_action, desc = "Quickfix issue" },
    s = { cmd = "<cmd>Mason<CR>", desc = "Sync LSP (Mason)" },
  },
}
M.packer = {
  subleader = "p",
  title = "Plugin management",
  mappings = {
    S = { cmd = "<cmd>PackerStatus<CR>", desc = "[P]acker [S]tatus" },
    c = { cmd = "<cmd>PackerCompile<CR>", desc = "[P]acker [C]ompile" },
    e = {
      cmd = "<cmd>e ~/.config/nvim/lua/cange/plugins.lua<CR>",
      desc = "Edit plugins",
      dashboard = true,
      icon = Cange.get_icon("ui.Gear"),
    },
    i = { cmd = "<cmd>PackerInstall<CR>", desc = "[P]acker [I]nstall" },
    s = { cmd = "<cmd>PackerSync<CR>", desc = "[P]lugins [S]ync", dashboard = true, icon = Cange.get_icon("ui.Sync") },
  },
}
M.search = {
  subleader = "s",
  title = "Search",
  mappings = {
    B = { cmd = "<cmd>Telescope buffers<CR>", desc = "[S]earch Existing [B]uffers", primary = true },
    C = { cmd = "<cmd>Telescope commands<CR>", desc = "[S]earch [C]ommands" },
    F = {
      cmd = "<cmd>Telescope live_grep<CR>",
      desc = "[S]earch by [G]rep",
      primary = true,
      dashboard = true,
      icon = Cange.get_icon("ui.List"),
    },
    N = { cmd = "<cmd>Telescope notify<CR>", desc = "[S]earch [N]otifications" },
    P = {
      cmd = "<cmd>lua require('telescope').extensions.project.project()<CR>",
      desc = "[S]earch [P]rojects",
      dashboard = true,
      icon = Cange.get_icon("ui.Project"),
    },
    W = { cmd = '<cmd>lua require("telescope.builtin").grep_string<CR>', desc = "[S]earch current [W]ord" },
    b = { cmd = '<cmd>lua require("cange.telescope.custom").file_browser()<CR>', desc = "[S]earch [B]rowse files" },
    c = { cmd = "<cmd>Telescope colorscheme<CR>", desc = "[S]witch [C]olorscheme" },
    f = {
      cmd = "<cmd>Telescope find_files<CR>",
      desc = "[S]earch [F]iles",
      primary = true,
      dashboard = true,
      icon = Cange.get_icon("ui.Search"),
    },
    h = { cmd = "<cmd>Telescope help_tags<CR>", desc = "[S]earch [H]elp" },
    k = { cmd = "<cmd>Telescope keymaps<CR>", desc = "[S]earch [K]eybindings" },
    n = { cmd = '<cmd>lua require("cange.telescope.custom").browse_nvim()<CR>', desc = "Browse [N]vim" },
    r = {
      cmd = "<cmd>Telescope oldfiles<CR>",
      desc = "[R]ecently Opened Files",
      dashboard = true,
      icon = Cange.get_icon("ui.Calendar"),
    },
    w = { cmd = '<cmd>lua require("cange.telescope.custom").browse_workspace()<CR>', desc = "Browse [W]orkspace" },
    ["/"] = {
      cmd = '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>',
      desc = "Search current buffer",
    },
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
