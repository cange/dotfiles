---@type CangeCore.WhichKey.group[]
local M = {}

-- All main key bindings to open certain function are defined here. Individual plugin internal bindings are handled in
-- each plugin by it self.

---@enum CangeCore.WhichKey.group.editor
M.editor = {
  title = "Editor",
  subleader = "e",
  mappings = {
    -- Format
    C = { cmd = "<cmd>e ~/.config/nvim/lua/cange/config.lua<CR>", desc = "Edit Config" },
    a = { cmd = '<cmd>lua require("harpoon.mark").add_file()<CR>', desc = "Add Bookmark", primary = true },
    c = { cmd = "<cmd>TextCaseOpenTelescope<CR>", desc = "Change Case" },
    n = {
      cmd = "<cmd>lua vim.o.relativenumber = not vim.o.relativenumber<CR>",
      desc = "Toggle Relativenumber",
      primary = true,
    },
    m = { cmd = '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', desc = "Bookmarks Menu", primary = true },
    k = { cmd = "<cmd>e ~/.config/nvim/lua/cange/keymaps/M.groups.lua<CR>", desc = "Edit Keymaps" },
    o = { cmd = "<cmd>e ~/.config/nvim/lua/cange/options.lua<CR>", desc = "Edit Options" },
    w = { cmd = "<cmd>w!<CR>", desc = "Save", primary = true },
    ["\\"] = { cmd = "<cmd>NvimTreeToggle<CR>", desc = "File Explorer", primary = true },
  },
}
---@enum CangeCore.WhichKey.group.git
M.git = {
  title = "Git",
  subleader = "g",
  mappings = {
    B = { cmd = "<cmd>Telescope git_branches<CR>", desc = "Checkout branch" },
    C = { cmd = "<cmd>Telescope git_commits<CR>", desc = "Checkout commit" },
    R = { cmd = "<cmd>Gitsigns reset_buffer<CR>", desc = "Reset file" },
    S = { cmd = "<cmd>Gitsigns stage_buffer<CR>", desc = "Stage file" },
    d = { cmd = "<cmd>Gitsigns diffthis HEAD<CR>", desc = "Git diff" },
    i = { cmd = "<cmd>Gitsigns blame_line<CR>", desc = "Commit info" },
    I = {
      cmd = function()
        require("gitsigns").blame_line({ full = true })
      end,
      desc = "Commit full info",
    },
    j = { cmd = "<cmd>Gitsigns next_hunk<CR>", desc = "Next hunk" },
    k = { cmd = "<cmd>Gitsigns prev_hunk<CR>", desc = "Prev hunk" },
    l = { cmd = "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "Line blame" },
    o = { cmd = "<cmd>Telescope git_status<CR>", desc = "Open changed file" },
    p = { cmd = "<cmd>Gitsigns preview_hunk<CR>", desc = "Preview hunk" },
    r = { cmd = "<cmd>Gitsigns reset_hunk<CR>", desc = "Reset hunk" },
    s = { cmd = "<cmd>Gitsigns stage_hunk<CR>", desc = "Stage hunk" },
    u = { cmd = "<cmd>Gitsigns undo_stage_hunk<CR>", desc = "Undo stage hunk" },
  },
}
---@enum CangeCore.WhichKey.group.lsp
M.lsp = {
  title = "LSP",
  subleader = "l",
  mappings = {
    C = { cmd = '<cmd>lua require("luasnip").cleanup()<CR>', desc = "Reset snippets UI" },
    N = { cmd = "<cmd>NullLsInfo<CR>", desc = "Null-ls info" },
    c = { cmd = vim.lsp.buf_get_clients, desc = "LSP clients" },
    d = { cmd = '<cmd>lua require("cange.telescope").diagnostics_log()<CR>', desc = "Diagnostics log" },
    f = { cmd = "<cmd>LspToggleFormatOnSave<CR>", desc = "Toggle format on save" },
    i = { cmd = "<cmd>LspInfo<CR>", desc = "Info LSP" },
    q = { cmd = vim.lsp.buf.code_action, desc = "Quickfix issue" },
    s = { cmd = "<cmd>Mason<CR>", desc = "Sync LSP (Mason)" },
    ["<F2>"] = { cmd = '<cmd>lua require("cange.lsp.format").format()<CR>', desc = "Format", primary = true },
  },
}
---@enum CangeCore.WhichKey.group.plugins
M.plugins = {
  title = "Plugins",
  subleader = "p",
  mappings = {
    S = { cmd = "<cmd>Lazy health<CR>", desc = "Plugin Status" },
    h = { cmd = "<cmd>Lazy help<CR>", desc = "Plugin Help" },
    e = { cmd = "<cmd>e ~/.config/nvim/lua/plugins/init.lua<CR>", desc = "Edit Plugins" },
    s = { cmd = "<cmd>Lazy sync<CR>", desc = "Plugins Sync" },
    i = { cmd = "<cmd>Lazy show<CR>", desc = "Plugins Show" },
  },
}
---@enum CangeCore.WhichKey.group.session
M.session = {
  title = "Session",
  subleader = "b",
  mappings = {
    F = { cmd = "<cmd>SearchSession<CR>", desc = "Find Session" },
    R = { cmd = "<cmd>RestoreSession<CR>", desc = "Recent Project" },
    s = { cmd = "<cmd>SaveSession<CR>", desc = "Save Session" },
    x = { cmd = "<cmd>DeleteSession<CR>", desc = "Delete Session" },
  },
}
---@enum CangeCore.WhichKey.group.treesitter
M.treesitter = {
  title = "Tree-sitter",
  subleader = "t",
  mappings = {
    h = { cmd = "<cmd>TSHighlightCapturesUnderCursor<CR>", desc = "Highlight info" },
    p = { cmd = "<cmd>TSPlaygroundToggle<CR>", desc = "Playground" },
    r = { cmd = "<cmd>TSToggle rainbow<CR>", desc = "Toggle Rainbow" },
  },
}
---@enum CangeCore.WhichKey.group.telescope
M.telescope = {
  title = "Search",
  subleader = "s",
  mappings = {
    B = { cmd = "<cmd>Telescope buffers<CR>", desc = "Search Buffers" },
    C = { cmd = "<cmd>Telescope commands<CR>", desc = "Search Commands" },
    F = {
      cmd = "<cmd>lua require('cange.telescope').live_grep()<CR>",
      desc = "Search in Files",
      primary = true,
    },
    N = { cmd = "<cmd>Telescope notify<CR>", desc = "Search Notifications" },
    H = { cmd = '<cmd>lua require("telescope.builtin").highlights()<CR>', desc = "Search Highlights" },
    b = { cmd = '<cmd>lua require("cange.telescope").file_browser()<CR>', desc = "Search in current Directory" },
    c = { cmd = "<cmd>Telescope colorscheme<CR>", desc = "Switch Colorscheme" },
    f = { cmd = "<cmd>Telescope find_files<CR>", desc = "Search Files", primary = true },
    h = { cmd = "<cmd>Telescope help_tags<CR>", desc = "Search Help" },
    k = { cmd = "<cmd>Telescope keymaps<CR>", desc = "Search Keybindings" },
    n = { cmd = '<cmd>lua require("cange.telescope").browse_nvim()<CR>', desc = "Search in Nvim" },
    p = {
      cmd = "<cmd>lua require('telescope').extensions.project.project()<CR>",
      desc = "Search Projects",
    },
    r = { cmd = "<cmd>Telescope oldfiles<CR>", desc = "Recently Opened Files" },
    w = { cmd = '<cmd>lua require("cange.telescope").browse_workspace()<CR>', desc = "Browse Workspace" },
    ["/"] = {
      cmd = '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>',
      desc = "Search current buffer",
    },
  },
}

return M
