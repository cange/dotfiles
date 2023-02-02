-- local ns = "[cange.utils.whichkey_groups]"

-- All main key bindings to open certain function are defined here. Individual plugin internal bindings are handled in
-- each plugin by it self.

---@class Cange.utils.whichkey
---@field Command Cange.utils.whichkey.Command
---@field Group Cange.utils.whichkey.Group
---@field Groups Cange.utils.whichkey.Groups

---@class Cange.utils.whichkey.Command
---@field desc string Description of the keybinding
---@field cmd string|function Command of the keybinding
---@field primary? boolean Determines whether or not to show a on inital "which-key" window

---@class Cange.utils.whichkey.Group
---@field mappings table<string, Cange.utils.whichkey.Command> The actual key bindings
---@field subleader string Additional key to enter the certain group
---@field title string Is displayed as group name

---@class Cange.utils.whichkey.Groups
---@field config Cange.utils.whichkey.Group
---@field git Cange.utils.whichkey.Group
---@field lsp Cange.utils.whichkey.Group Language related syntax analytics
---@field plugins Cange.utils.whichkey.Group Install, update neovims plugins
---@field search Cange.utils.whichkey.Group Finding stuff
---@field session Cange.utils.whichkey.Group
---@field treesitter Cange.utils.whichkey.Group

---@type Cange.utils.whichkey.Groups
local groups = {}

local m = {}

---@param group_id string|nil
---@return Cange.utils.whichkey.Groups # All defined groups or one when group_id is specified
function m.get_group(group_id)
  return group_id == nil and groups[group_id] or groups
end

---Adds given mapping to the which key menu
---@param group_id string Letter starting name of the group
---@param group Cange.utils.whichkey.Group
function m.set_group(group_id, group)
  group_id = vim.trim(group_id):lower():gsub("%W", "-")
  groups[group_id] = group
  -- vim.pretty_print(ns, "set_group", group_id, vim.tbl_keys(group))
  return groups[group_id]
end

m.set_group("editor", {
  title = "Editor",
  subleader = "e",
  mappings = {
    c = { cmd = "<cmd>TextCaseOpenTelescope<CR>", desc = "[C]hange Case" },
    k = { cmd = "<cmd>e ~/.config/nvim/lua/cange/keymaps/M.groups.lua<CR>", desc = "Edit [K]eymaps" },
    m = { cmd = "<cmd>e ~/.config/nvim/lua/cange/config.lua<CR>", desc = "Edit Config" },
    o = { cmd = "<cmd>e ~/.config/nvim/lua/cange/options.lua<CR>", desc = "Edit [O]ptions" },
    w = { cmd = "<cmd>w!<CR>", desc = "Save", primary = true },
    ["\\"] = { cmd = "<cmd>NvimTreeToggle<CR>", desc = "File Explorer", primary = true },
  },
})
m.set_group("git", {
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
})
m.set_group("lsp", {
  title = "LSP",
  subleader = "l",
  mappings = {
    C = { cmd = '<cmd>lua require("luasnip").cleanup()<CR>', desc = "Reset snippets UI" },
    ["<F2>"] = {
      cmd = "<cmd>lua vim.lsp.buf.format({ async = true, timeout_ms = 10000 });vim.notify('Auto format')<CR>",
      desc = "Format",
      primary = true,
    },
    N = { cmd = "<cmd>NullLsInfo<CR>", desc = "Null-ls info" },
    c = { cmd = vim.lsp.buf_get_clients, desc = "LSP clients" },
    d = { cmd = '<cmd>lua require("cange.telescope").diagnostics_log()<CR>', desc = "Diagnostics log" },
    f = { cmd = "<cmd>LspToggleFormatOnSave<CR>", desc = "Toggle format on save" },
    i = { cmd = "<cmd>LspInfo<CR>", desc = "Info LSP" },
    q = { cmd = vim.lsp.buf.code_action, desc = "Quickfix issue" },
    s = { cmd = "<cmd>Mason<CR>", desc = "Sync LSP (Mason)" },
  },
})
m.set_group("plugins", {
  title = "Plugins",
  subleader = "p",
  mappings = {
    S = { cmd = "<cmd>Lazy health<CR>", desc = "Plugin [S]tatus" },
    h = { cmd = "<cmd>Lazy help<CR>", desc = "Plugin [h]elp" },
    e = { cmd = "<cmd>e ~/.config/nvim/lua/plugins/init.lua<CR>", desc = "[E]dit Plugins" },
    i = { cmd = "<cmd>Lazy install<CR>", desc = "Plugin [i]nstall" },
    s = { cmd = "<cmd>Lazy sync<CR>", desc = "Plugins [s]ync" },
  },
})
m.set_group("session", {
  title = "Session",
  subleader = "b",
  mappings = {
    F = { cmd = "<cmd>SearchSession<CR>", desc = "[F]ind Session" },
    R = { cmd = "<cmd>RestoreSession<CR>", desc = "[R]ecent Project" },
    s = { cmd = "<cmd>SaveSession<CR>", desc = "Save [s]ession" },
    x = { cmd = "<cmd>DeleteSession<CR>", desc = "Delete Session" },
  },
})
m.set_group("treesitter", {
  title = "Tree-sitter",
  subleader = "t",
  mappings = {
    h = { cmd = "<cmd>TSHighlightCapturesUnderCursor<CR>", desc = "[h]ighlight" },
    p = { cmd = "<cmd>TSPlaygroundToggle<CR>", desc = "[p]layground" },
    r = { cmd = "<cmd>TSToggle rainbow<CR>", desc = "[r]ainbow" },
  },
})

m.set_group("telescope", {
  title = "Search",
  subleader = "s",
  mappings = {
    B = { cmd = "<cmd>Telescope buffers<CR>", desc = "Search Existing [B]uffers", primary = true },
    C = { cmd = "<cmd>Telescope commands<CR>", desc = "Search [C]ommands" },
    F = {
      cmd = "<cmd>lua require('cange.telescope').live_grep()<CR>",
      desc = "Search in [F]iles",
      primary = true,
    },
    N = { cmd = "<cmd>Telescope notify<CR>", desc = "Search [N]otifications" },
    W = { cmd = '<cmd>lua require("telescope.builtin").grep_string<CR>', desc = "Search current [W]ord" },
    H = { cmd = '<cmd>lua require("telescope.builtin").highlights()<CR>', desc = "Search [H]ighlights" },
    a = { cmd = '<cmd>lua require("harpoon.mark").add_file()<CR>', desc = "[a]dd bookmark" },
    b = { cmd = '<cmd>lua require("cange.telescope").file_browser()<CR>', desc = "Search [b]rowse files" },
    c = { cmd = "<cmd>Telescope colorscheme<CR>", desc = "Switch [c]olorscheme" },
    f = { cmd = "<cmd>Telescope find_files<CR>", desc = "Search [f]iles", primary = true },
    h = { cmd = "<cmd>Telescope help_tags<CR>", desc = "Search [h]elp" },
    k = { cmd = "<cmd>Telescope keymaps<CR>", desc = "Search [k]eybindings" },
    m = { cmd = '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', desc = "Bookmarks [m]enu" },
    n = { cmd = '<cmd>lua require("cange.telescope").browse_nvim()<CR>', desc = "Browse [n]vim" },
    p = {
      cmd = "<cmd>lua require('telescope').extensions.project.project()<CR>",
      desc = "Search [P]rojects",
    },
    r = { cmd = "<cmd>Telescope oldfiles<CR>", desc = "[r]ecently Opened Files" },
    w = { cmd = '<cmd>lua require("cange.telescope").browse_workspace()<CR>', desc = "Browse [w]orkspace" },
    ["/"] = {
      cmd = '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>',
      desc = "Search current buffer",
    },
  },
})

return m
