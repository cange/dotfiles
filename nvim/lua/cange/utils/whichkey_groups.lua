local ns = "[cange.utils.whichkey_groups]"

-- All main key bindings to open certain function are defined here. Individual plugin internal bindings are handled in
-- each plugin by it self.

---@class WhichKeyCommand
---@field desc string Description of the keybinding
---@field cmd string|function Command of the keybinding
---@field dashboard? boolean Determines whether or not to on "alpha" start page
---@field icon? string The icon which shown on "alpha" start page
---@field primary? boolean Determines whether or not to show a on inital "which-key" window

---@class WhichKeyGroup
---@field mappings table<string, WhichKeyCommand> The actual key bindings
---@field subleader string Additional key to enter the certain group
---@field title string Is displayed as group name

---@class WhichKeyGroups
---@field config WhichKeyGroup
---@field git WhichKeyGroup
---@field lsp WhichKeyGroup Language related syntax analytics
---@field plugins WhichKeyGroup Install, update neovims plugins
---@field search WhichKeyGroup Finding stuff
---@field session WhichKeyGroup
---@field treesitter WhichKeyGroup

---@class WhichKeyGroups
local groups = {}

local M = {}

---@param group_id string|nil
---@return WhichKeyGroups # All defined groups or one when group_id is specified
function M.get_group(group_id)
  return group_id == nil and groups[group_id] or groups
end

---Adds given mapping to the which key menu
---@param group_id string Letter starting name of the group
---@param group WhichKeyGroup
function M.set_group(group_id, group)
  group_id = vim.trim(group_id):lower():gsub("%W", "-")
  groups[group_id] = group
  -- vim.pretty_print(ns, "set_group", group_id, vim.tbl_keys(group))
  return groups[group_id]
end

M.set_group("editor", {
  title = "Editor",
  subleader = "e",
  mappings = {
    a = { cmd = "<cmd>Alpha<CR>", desc = "Start Screen", primary = true },
    c = { cmd = "<cmd>TextCaseOpenTelescope<CR>", desc = "[C]hange Case" },
    k = { cmd = "<cmd>e ~/.config/nvim/lua/cange/keymaps/M.groups.lua<CR>", desc = "Edit [K]eymaps" },
    m = { cmd = "<cmd>e ~/.config/nvim/lua/cange/config.lua<CR>", desc = "Edit Config" },
    o = { cmd = "<cmd>e ~/.config/nvim/lua/cange/options.lua<CR>", desc = "Edit [O]ptions" },
    w = { cmd = "<cmd>w!<CR>", desc = "Save", primary = true },
    ["\\"] = { cmd = "<cmd>NvimTreeToggle<CR>", desc = "File Explorer", primary = true },
  },
})
M.set_group("git", {
  title = "Git",
  subleader = "g",
  mappings = {
    B = { cmd = "<cmd>Telescope git_branches<CR>", desc = "Checkout branch" },
    C = { cmd = "<cmd>Telescope git_commits<CR>", desc = "Checkout commit" },
    R = { cmd = "<cmd>Gitsigns reset_buffer<CR>", desc = "Reset buffer" },
    d = { cmd = "<cmd>Gitsigns diffthis HEAD<CR>", desc = "Git [d]iff" },
    i = { cmd = "<cmd>Gitsigns blame_line<CR>", desc = "Commit [i]nfo" },
    I = {
      cmd = function()
        require("gitsigns").blame_line({ full = true })
      end,
      desc = "Commit full [I]nfo",
    },
    j = { cmd = '<cmd>lua require("gitsigns").next_hunk()<CR>', desc = "Next hunk" },
    k = { cmd = '<cmd>lua require("gitsigns").prev_hunk()<CR>', desc = "Prev hunk" },
    l = { cmd = "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "Line blame" },
    o = { cmd = "<cmd>Telescope git_status<CR>", desc = "Open changed file" },
    p = { cmd = '<cmd>lua require("gitsigns").preview_hunk()<CR>', desc = "Preview hunk" },
    r = { cmd = '<cmd>lua require("gitsigns").reset_hunk()<CR>', desc = "Reset hunk" },
    s = { cmd = '<cmd>lua require("gitsigns").stage_hunk()<CR>', desc = "Stage hunk" },
    u = { cmd = '<cmd>lua require("gitsigns").undo_stage_hunk()<CR>', desc = "Undo stage hunk" },
  },
})
M.set_group("lsp", {
  title = "LSP",
  subleader = "l",
  mappings = {
    C = { cmd = '<cmd>lua require("luasnip").cleanup()<CR>', desc = "Reset snippets UI" },
    ["<F2>"] = {
      cmd = "<cmd>lua vim.lsp.buf.format({ async = true, timeout_ms = 10000 });vim.notify('Auto format')<CR>",
      desc = "Format",
      primary = true,
    },
    N = { cmd = "<cmd>NullLsInfo<CR>", desc = "Info Null-ls" },
    c = { cmd = vim.lsp.buf_get_clients, desc = "LSP clients" },
    d = { cmd = '<cmd>lua require("cange.telescope").diagnostics_log()<CR>', desc = "Diagnostics log" },
    f = { cmd = "<cmd>LspToggleFormatOnSave<CR>", desc = "Toggle format on save" },
    i = { cmd = "<cmd>LspInfo<CR>", desc = "Info LSP" },
    q = { cmd = vim.lsp.buf.code_action, desc = "Quickfix issue" },
    s = { cmd = "<cmd>Mason<CR>", desc = "Sync LSP (Mason)" },
  },
})
M.set_group("plugins", {
  title = "Plugins",
  subleader = "p",
  mappings = {
    S = { cmd = "<cmd>Lazy health<CR>", desc = "[P]lugin [S]tatus" },
    h = { cmd = "<cmd>Lazy help<CR>", desc = "[P]lugin [h]elp" },
    e = {
      cmd = "<cmd>e ~/.config/nvim/lua/plugins/init.lua<CR>",
      desc = "[E]dit Plugins",
      dashboard = true,
      icon = "ui.Gear",
    },
    i = { cmd = "<cmd>Lazy install<CR>", desc = "[P]lugin [i]nstall" },
    s = {
      cmd = "<cmd>Lazy sync<CR>",
      desc = "[P]lugins [s]ync",
      dashboard = true,
      icon = "ui.Sync",
    },
  },
})
M.set_group("session", {
  title = "Session",
  subleader = "b",
  mappings = {
    F = {
      cmd = "<cmd>SearchSession<CR>",
      desc = "Find Session",
      dashboard = true,
      icon = "ui.SignIn",
    },
    R = {
      cmd = "<cmd>RestoreSession<CR>",
      desc = "Recent Project",
      icon = "ui.Calendar",
      dashboard = true,
    },
    s = { cmd = "<cmd>SaveSession<CR>", desc = "Save Session" },
    x = { cmd = "<cmd>DeleteSession<CR>", desc = "Delete Session" },
  },
})
M.set_group("treesitter", {
  title = "Tree-sitter",
  subleader = "t",
  mappings = {
    h = { cmd = "<cmd>TSHighlightCapturesUnderCursor<cr>", desc = "Highlight" },
    p = { cmd = "<cmd>TSPlaygroundToggle<cr>", desc = "Playground" },
    r = { cmd = "<cmd>TSToggle rainbow<cr>", desc = "Rainbow" },
  },
})

M.set_group("telescope", {
  title = "Search",
  subleader = "s",
  mappings = {
    B = { cmd = "<cmd>Telescope buffers<CR>", desc = "[S]earch Existing [B]uffers", primary = true },
    C = { cmd = "<cmd>Telescope commands<CR>", desc = "[S]earch [C]ommands" },
    F = {
      cmd = "<cmd>lua require('cange.telescope').live_grep()<CR>",
      desc = "[S]earch by Grep",
      primary = true,
      dashboard = true,
      icon = "ui.List",
    },
    N = { cmd = "<cmd>Telescope notify<CR>", desc = "[S]earch [N]otifications" },
    W = { cmd = '<cmd>lua require("telescope.builtin").grep_string<CR>', desc = "[S]earch current [W]ord" },
    H = { cmd = '<cmd>lua require("telescope.builtin").highlights()<CR>', desc = "[S]earch [H]ighlights" },
    a = { cmd = '<cmd>lua require("harpoon.mark").add_file()<CR>', desc = "[A]dd bookmark" },
    b = { cmd = '<cmd>lua require("cange.telescope").file_browser()<CR>', desc = "[S]earch [B]rowse files" },
    c = { cmd = "<cmd>Telescope colorscheme<CR>", desc = "[S]witch [C]olorscheme" },
    f = {
      cmd = "<cmd>Telescope find_files<CR>",
      desc = "[S]earch [F]iles",
      primary = true,
      dashboard = true,
      icon = "ui.Search",
    },
    h = { cmd = "<cmd>Telescope help_tags<CR>", desc = "[S]earch [H]elp" },
    k = { cmd = "<cmd>Telescope keymaps<CR>", desc = "[S]earch [K]eybindings" },
    m = { cmd = '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', desc = "Bookmarks [m]enu" },
    n = { cmd = '<cmd>lua require("cange.telescope").browse_nvim()<CR>', desc = "Browse [N]vim" },
    p = {
      cmd = "<cmd>lua require('telescope').extensions.project.project()<CR>",
      desc = "[S]earch [P]rojects",
      dashboard = true,
      icon = "ui.Project",
    },
    r = {
      cmd = "<cmd>Telescope oldfiles<CR>",
      desc = "[R]ecently Opened Files",
      dashboard = true,
      icon = "ui.Calendar",
    },
    w = { cmd = '<cmd>lua require("cange.telescope").browse_workspace()<CR>', desc = "Browse [W]orkspace" },
    ["/"] = {
      cmd = '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>',
      desc = "Search current buffer",
    },
  },
})

return M
