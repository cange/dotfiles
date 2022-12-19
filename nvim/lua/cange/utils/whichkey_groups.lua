local ns = "[cange.utils.whichkey_groups]"

-- All main key bindings to open certain function are defined here. Individual plugin internal bindings are handled in
-- each plugin by it self.

---@class WhichKeyCommand
---@field desc string Description of the keybinding
---@field cmd string Command of the keybinding
---@field dashboard? boolean Determines whether or not to on "alpha" start page
---@field icon? CoreIcon The icon which shown on "alpha" start page
---@field primary? boolean Determines whether or not to show a on inital "which-key" window

---@class WhichKeyGroup
---@field mappings table<string, WhichKeyCommand> The actual key bindings
---@field subleader string Additional key to enter the certain group
---@field title string Is displayed as group name

---@class WhichKeyGroups
---@field config WhichKeyGroup
---@field git WhichKeyGroup
---@field lsp WhichKeyGroup Language related syntax analytics
---@field packer WhichKeyGroup Install, update neovims plugins
---@field search WhichKeyGroup Finding stuff
---@field session WhichKeyGroup
---@field treesitter WhichKeyGroup

local M = {}

---@class WhichKeyGroups
local groups = {}

---Adds given mapping to the which key menu
---@param group_id string Letter starting name of the group
---@param group WhichKeyGroup
function M.register_group(group_id, group)
  group_id = vim.trim(group_id):lower():gsub("%W", "-")
  groups[group_id] = group
  -- vim.pretty_print(ns, "register_group", group_id, vim.tbl_keys(group))
  return groups[group_id]
end

---Returns all defined groups
---@return WhichKeyGroups
function M.get()
  return groups
end

M.register_group("editor", {
  title = "Editor",
  subleader = "c",
  mappings = {
    E = {
      cmd = "<cmd>enew <BAR>startinsert<CR>",
      desc = "New File",
      dashboard = true,
      icon = "documents.NewFile",
    },
    a = { cmd = "<cmd>Alpha<CR>", desc = "Start Screen", primary = true },
    e = { cmd = "<cmd>NvimTreeToggle<CR>", desc = "File Explorer", primary = true },
    k = { cmd = "<cmd>e ~/.config/nvim/lua/cange/keymaps/M.groups.lua<CR>", desc = "Edit Keymaps" },
    m = { cmd = "<cmd>e ~/.config/nvim/lua/cange/config.lua<CR>", desc = "Edit Config" },
    o = { cmd = "<cmd>e ~/.config/nvim/lua/cange/options.lua<CR>", desc = "Edit Options" },
    q = {
      cmd = "<cmd>quitall!<CR>",
      desc = "Quit",
      primary = true,
      dashboard = true,
      icon = "ui.SignOut",
    },
    w = { cmd = "<cmd>w!<CR>", desc = "Save", primary = true },
  },
})
M.register_group("git", {
  title = "Git",
  subleader = "g",
  mappings = {
    B = { cmd = "<cmd>Telescope git_branches<CR>", desc = "Checkout branch" },
    C = { cmd = "<cmd>Telescope git_commits<CR>", desc = "Checkout commit" },
    R = { cmd = "<cmd>Gitsigns reset_buffer<CR>", desc = "Reset buffer" },
    d = { cmd = "<cmd>Gitsigns diffthis HEAD<CR>", desc = "Diff" },
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
M.register_group("lsp", {
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
    d = { cmd = '<cmd>lua require("cange.telescope.custom").diagnostics_log()<CR>', desc = "Diagnostics log" },
    f = { cmd = "<cmd>CangeLSPToggleAutoFormat<CR>", desc = "Toggle Auto Formatting" },
    i = { cmd = "<cmd>LspInfo<CR>", desc = "Info LSP" },
    q = { cmd = vim.lsp.buf.code_action, desc = "Quickfix issue" },
    s = { cmd = "<cmd>Mason<CR>", desc = "Sync LSP (Mason)" },
  },
})
M.register_group("packer", {
  title = "Packer",
  subleader = "p",
  mappings = {
    S = { cmd = "<cmd>PackerStatus<CR>", desc = "[P]acker [S]tatus" },
    c = { cmd = "<cmd>PackerCompile<CR>", desc = "[P]acker [C]ompile" },
    e = {
      cmd = "<cmd>e ~/.config/nvim/lua/cange/plugins.lua<CR>",
      desc = "[E]dit Plugins",
      dashboard = true,
      icon = "ui.Gear",
    },
    i = { cmd = "<cmd>PackerInstall<CR>", desc = "[P]acker [I]nstall" },
    s = {
      cmd = "<cmd>PackerSync<CR>",
      desc = "[P]lugins [S]ync",
      dashboard = true,
      icon = "ui.Sync",
    },
  },
})
M.register_group("session", {
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
M.register_group("treesitter", {
  title = "Tree-sitter",
  subleader = "t",
  mappings = {
    h = { cmd = "<cmd>TSHighlightCapturesUnderCursor<cr>", desc = "Highlight" },
    p = { cmd = "<cmd>TSPlaygroundToggle<cr>", desc = "Playground" },
    r = { cmd = "<cmd>TSToggle rainbow<cr>", desc = "Rainbow" },
  },
})

return M
