--- Provides general settings
local M = {}

---Mappings tries to organise global used keybindings on one place
--- Pattern: <block_key> = { { <key> = { command = '...', title = '...' } } }
--- @table mappings

--- Language related syntax analytics
M.bookmarks = {
  subleader = 'b',
  title = 'Bookmarks',
  mappings = {
    n = { command = '<cmd>lua require("nvim-tree.api").marks.navigate.next()<CR>', title = 'Next bookmark' },
    p = { command = '<cmd>lua require("nvim-tree.api").marks.navigate.prev()<CR>', title = 'Prev bookmark' },
    s = { command = '<cmd>lua require("nvim-tree.api").marks.navigate.select()<CR>', title = 'Select bookmark' },
  },
}
M.lsp = {
  subleader = 'l',
  title = 'Language (LSP)',
  mappings = {
    I = { command = '<cmd>LspInfo<CR>', title = 'LSP Info' },
    d = { command = '<cmd>lua require("cange.telescope.custom").diagnostics_log()<CR>', title = 'Diagnostics hints' },
    S = { command = '<cmd>Telescope local sp_dynamic_workspace_symbols<CR>', title = 'Workspace Symbols' },
    i = { command = '<cmd>LspInfo<CR>', title = 'Info' },
    a = { command = '<cmd>lua vim.lsp.buf.code_action()<CR>', title = 'Code Action' },
    c = { command = '<cmd>lua vim.lsp.buf_get_clients()<CR>', title = 'LSP clients' },
    f = { command = '<cmd>lua vim.lsp.buf.formatting()<CR>', title = 'Format' },
    l = { command = '<cmd>lua vim.diagnostic.setloclist()<CR>', title = 'Problems log' },
    m = { command = '<cmd>Mason<CR>', title = 'Update LSP services' },
    r = { command = '<cmd>lua vim.lsp.buf.rename()<CR>', title = 'Rename' },
  },
}

---Finding stuff
M.search = {
  subleader = 'f',
  title = 'Search',
  mappings = {
    C = { command = '<cmd>Telescope commands<CR>', title = 'Commands' },
    F = { command = '<cmd>Telescope live_grep<CR>', title = 'Find text' },
    M = { command = '<cmd>Telescope man_pages<CR>', title = 'Man pages' },
    N = { command = '<cmd>Telescope notify<CR>', title = 'Browse notifications' },
    b = { command = '<cmd>lua require("cange.telescope.custom").file_browser()<CR>', title = 'Browse files' },
    c = { command = '<cmd>Telescope colorscheme<CR>', title = 'Change colorscheme' },
    f = { command = '<cmd>Telescope find_files<CR>', title = 'Find files' },
    h = { command = '<cmd>Telescope help_tags<CR>', title = 'Find help' },
    k = { command = '<cmd>Telescope keymaps<CR>', title = 'Keymaps' },
    B = { command = '<cmd>Telescope buffers previewer=false<CR>', title = 'Buffers' },
    n = { command = '<cmd>lua require("cange.telescope.custom").browse_nvim()<CR>', title = 'Browse nvim' },
    o = { command = '<cmd>Telescope oldfiles<CR>', title = 'Recent files' },
    p = { command = '<cmd>Telescope projects<CR>', title = 'Open projects' },
    w = { command = '<cmd>lua require("cange.telescope.custom").browse_workspace()<CR>', title = 'Browse workspace' },
  },
}

M.config = {
  subleader = 'c',
  title = 'Editor config',
  mappings = {
    k = { command = '<cmd>e ~/.config/nvim/lua/cange/keymaps/mappings.lua<CR>', title = 'Edit keybindings' },
    m = { command = '<cmd>e ~/.config/nvim/lua/cange/meta.lua<CR>', title = 'Edit meta information' },
    o = { command = '<cmd>e ~/.config/nvim/lua/cange/options.lua<CR>', title = 'Edit options' },
    p = { command = '<cmd>e ~/.config/nvim/lua/cange/plugins.lua<CR>', title = 'Edit plugins' },
  },
}

M.git = {
  subleader = 'g',
  title = 'Git',
  mappings = {
    l = { command = '<cmd>Gitsigns toggle_current_line_blame<CR>', title = 'Line blame' },
    R = { command = '<cmd>Gitsigns reset_buffer<CR>', title = 'Reset buffer' },
    B = { command = '<cmd>Telescope git_branches<CR>', title = 'Checkout branch' },
    C = { command = '<cmd>Telescope git_commits<CR>', title = 'Checkout commit' },
    d = { command = '<cmd>Gitsigns diffthis HEAD<CR>', title = 'Diff' },
    -- t = { command = '<cmd>lua _LAZYGIT_TOGGLE()<CR>',                     title = 'Lazygit' },
    o = { command = '<cmd>Telescope git_status<CR>', title = 'Open changed file' },
    j = { command = '<cmd>lua require("gitsigns").next_hunk()<CR>', title = 'Next hunk' },
    k = { command = '<cmd>lua require("gitsigns").prev_hunk()<CR>', title = 'Prev hunk' },
    p = { command = '<cmd>lua require("gitsigns").preview_hunk()<CR>', title = 'Preview hunk' },
    r = { command = '<cmd>lua require("gitsigns").reset_hunk()<CR>', title = 'Reset hunk' },
    s = { command = '<cmd>lua require("gitsigns").stage_hunk()<CR>', title = 'Stage hunk' },
    u = { command = '<cmd>lua require("gitsigns").undo_stage_hunk()<CR>', title = 'Undo stage hunk' },
  },
}

---Install, update neovims plugins
M.packer = {
  subleader = 'p',
  title = 'Plugin management',
  mappings = {
    S = { command = '<cmd>PackerStatus<CR>', title = 'Status' },
    c = { command = '<cmd>PackerCompile<CR>', title = 'Compile' },
    i = { command = '<cmd>PackerInstall<CR>', title = 'Install' },
    s = { command = '<cmd>PackerSync<CR>', title = 'Sync' },
    u = { command = '<cmd>PackerUpdate<CR>', title = 'Update' },
    C = { command = '<cmd>e ~/.config/nvim/lua/cange/plugins.lua<CR>', title = 'Config' },
  },
}
M.session = {
  subleader = 's',
  title = 'Sessions',
  mappings = {
    R = { command = '<cmd>RestoreSession<CR>', title = 'Recent session' },
    d = { command = '<cmd>Autosession delete<CR>', title = 'Find delete session' },
    f = { command = '<cmd>SearchSession<CR>', title = 'Find session' },
    s = { command = '<cmd>SaveSession<CR>', title = 'Save session' },
    x = { command = '<cmd>DeleteSession<CR>', title = 'Delete session' },
  },
}
-- M.terminal = {
--   subleader = 't',
--   mappings = {
--     n = { command = '<cmd>lua _NODE_TOGGLE()<CR>',                      title = 'Node' },
--     u = { command = '<cmd>lua _NCDU_TOGGLE()<CR>',                      title = 'NCDU' },
--     t = { command = '<cmd>lua _HTOP_TOGGLE()<CR>',                      title = 'Htop' },
--     p = { command = '<cmd>lua _PYTHON_TOGGLE()<CR>',                    title = 'Python' },
--     f = { command = '<cmd>ToggleTerm direction=float<CR>',              title = 'Float' },
--     h = { command = '<cmd>ToggleTerm size=10 direction=horizontal<CR>', title = 'Horizontal' },
--     v = { command = '<cmd>ToggleTerm size=80 direction=vertical<CR>',   title = 'Vertical' },
--   },

return M
