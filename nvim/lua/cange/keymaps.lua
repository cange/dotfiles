local keymaps = {
  { "v", "p", '"_dP', { desc = "Clipboard: keep content" } },
  { "n", "<C-a>", "gg<S-v>G", { desc = "Select all content" } },
  { "v", "<F5>", ":sort<CR>gv=gv", { desc = "Sort selected lines" } },
  { "n", "<leader><leader>", "<C-^>", { desc = "Switch last recent 2 buffers" } },

  -- Moving lines up and down
  { "n", "<A-down>", ":move .+1<CR>==", { desc = "Line move: down" } },
  { "n", "<A-up>", ":move .-2<CR>==", { desc = "Line move: up" } },
  { "x", "<A-down>", ":move'>+<CR>='[gv", { desc = "Line move: down" } },
  { "x", "<A-up>", ":move-2<CR>='[gv", { desc = "Line move: up" } },
  { "x", "j", ":move'>+<CR>='[gv", { desc = "Line move: down" } },
  { "x", "k", ":move-2<CR>='[gv", { desc = "Line move: up" } },

  { "n", "<C-down>", ":resize +4<CR>", { desc = "Window resize: down" } },
  { "n", "<C-left>", ":vertical resize -4<CR>", { desc = "Window resize: left" } },
  { "n", "<C-up>", ":resize -4<CR>", { desc = "Window resize: up" } },
  { "n", "<C-right>", ":vertical resize +4<CR>", { desc = "Window resize: right" } },

  -- Keep selection marked when indenting
  { "v", "<", "<gv", { desc = "Indent: left" } },
  { "v", ">", ">gv", { desc = "Indent: right" } },
  { "v", "<Tab>", ">gv", { desc = "Indent: left" } },
  { "v", "<S-Tab>", "<gv", { desc = "Indent: right" } },
}

for _, km in pairs(keymaps) do
  local mode = km[1]
  local lhs = km[2]
  local rhs = km[3]
  local opts = km[4] ~= nil and km[4] or {}

  vim.keymap.set(mode, lhs, rhs, opts)
end

local M = {}

-- All main key bindings to open certain function are defined here. Individual plugin internal bindings are handled in
-- each plugin by it self.

-- stylua: ignore start
---@type cange.keymapsMappingGroup[]
M.groups = {
  {
    name = "Goto",
    leader = "g",
    mappings = {
      { "d", vim.lsp.buf.definition,                                            "Definition" },
      { "r", "<cmd>Telescope lsp_references<CR>",                               "References" },
      { "I", vim.lsp.buf.implementation,                                        "Implementation" },
      { "D", vim.lsp.buf.declaration,                                           "Declaration" },
      { "T", vim.lsp.buf.type_definition,                                       "Type definition" },
    },
  },
  {
    name = "Prev",
    leader = "[",
    mappings = {
      { "b", '<cmd>bprevious<CR>',                                              "Previous buffer" },
      { "c", '<cmd>require("copilot.suggestion").prev()<CR>',                   "Previous Copilot suggestion" },
      { "d", vim.diagnostic.goto_prev,                                          "Previous diagnostic" },
      { "g", "<cmd>Gitsigns prev_hunk<CR>",                                     "Previous Git hunk" },
      { "m", '<cmd>lua require("harpoon.ui").nav_prev()<CR>',                   "Previous bookmark" },
    },
  },
  {
    name = "Next",
    leader = "]",
    mappings = {
      { "b", '<cmd>bnext<CR>',                                                  "Next buffer" },
      { "c", '<cmd>require("copilot.suggestion").next()<CR>',                   "Next Copilot suggestion" },
      { "d", vim.diagnostic.goto_next,                                          "Next diagnostic" },
      { "g", "<cmd>Gitsigns next_hunk<CR>",                                     "Next Git hunk" },
      { "m", '<cmd>lua require("harpoon.ui").nav_next()<CR>',                   "Next bookmark" },
    },
  },
  {
    name = "Primary",
    leader = "<leader>",
    mappings = {
      { "<F2>", '<cmd>lua require("cange.lsp.format").format()<CR>',            "Format" },
      { "\\", "<cmd>NvimTreeToggle<CR>",                                        "File Explorer" },
      { "ff", "<cmd>lua require('cange.telescope').live_grep()<CR>",            "Search in Files" },
      { "a", '<cmd>lua require("harpoon.mark").add_file()<CR>',                 "Add bookmark" },
      { "f", "<cmd>Telescope find_files<CR>",                                   "Search Files" },
      { "m", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>',          "Show bookmarks" },
      { "n", "<cmd>lua vim.o.relativenumber = not vim.o.relativenumber<CR>",    "Toggle relative number" },
      { "w", "<cmd>w!<CR>",                                                     "Save file" },
      { "-", "<C-W>s",                                                          "Split window below" },
      { "/", "<cmd>Telescope current_buffer_fuzzy_find<CR>",                    "Search in current file" },
      { "|", "<C-W>v",                                                          "Split window right" },
      { "<leader>c", "<cmd>CangeUpdateColorscheme<CR>",                         "Update colorscheme highlights" },
      { "z", "<cmd>ZenMode<CR>",                                                "Toggle Zen Mode" },
      {
        "<leader>x",
        "<cmd>write<CR><cmd>lua Cange.reload('cange'); Cange.log('Saved and executed', { title = 'File' })<CR>",
        "Reload current file",
      },
    },
  },
  {
    name = "Window",
    leader = "w",
    mappings = {
      { "<left>", "<C-w>h",                                                     "Switch to left" },
      { "<down>", "<C-w>j",                                                     "Switch to down" },
      { "<up>", "<C-w>k",                                                       "Switch to up" },
      { "<right>", "<C-w>l",                                                    "Switch to right" },
      { "h", "<C-w>h",                                                          "Switch to left" },
      { "j", "<C-w>j",                                                          "Switch to down" },
      { "k", "<C-w>k",                                                          "Switch to up" },
      { "l", "<C-w>l",                                                          "Switch to right" },
    },
  },
  {
    name = "Editor",
    leader = "<leader>e",
    mappings = {
      -- toolings
      { "1", "<cmd>Lazy show<CR>",                                              "Plugin info" },
      { "2", "<cmd>Mason<CR>",                                                  "Mason info" },
      { "3", "<cmd>NullLsInfo<CR>",                                             "Null-ls info" },
      { "4", "<cmd>LspInfo<CR>",                                                "LSP info" },
      -- edits
      { "5", '<cmd>lua require("cange.telescope").browse_snippets()<CR>',       "Edit snippets" },
      { "6", "<cmd>e ~/.config/nvim/lua/cange/keymaps.lua<CR>",                 "Edit keymaps" },
      { "7", "<cmd>e ~/.config/nvim/lua/cange/options.lua<CR>",                 "Edit options" },
      { "8", "<cmd>e ~/.config/nvim/lua/cange/config.lua<CR>",                  "Edit config" },
      -- session
      { "R", "<cmd>SessionRestore<CR>",                                         "Recent session" },
      { "S", "<cmd>SessionSave<CR>",                                            "Save session" },
      { "X", "<cmd>SessionDelete<CR>",                                          "Delete session" },
      -- others
      { "l", "<cmd>lua require('cange.lsp.format').toggle_format_on_save()<CR>","Toggle format on save" },
      { "s", "<cmd>lua vim.o.spell = not vim.o.spell<CR>",                      "Toggle spelling" },
      { "c", "<cmd>Telescope colorscheme<CR>",                                  "Change colorscheme" },
      { "C", '<cmd>lua require("luasnip").cleanup()<CR>',                       "Reset snippets UI" },
      { "p", "<cmd>lua require('telescope').extensions.project.project()<CR>",  "Switch workspace" },
      {
        "N",
        "<cmd>lua require('telescope').extensions.notify.notify({ layout_strategy = 'vertical' })<CR>",
        "Show notifications",
      },
    },
  },
  {
    name = "Git",
    leader = "<leader>g",
    mappings = {
      { "B", "<cmd>Telescope git_branches<CR>",                                 "Checkout branch" },
      { "C", "<cmd>Telescope git_commits<CR>",                                  "Checkout commit" },
      { "I", '<cmd>lua require("gitsigns").blame_line({ full = true })<CR>',    "Commit full info" },
      { "R", "<cmd>Gitsigns reset_buffer<CR>",                                  "Reset file" },
      { "S", "<cmd>Gitsigns stage_buffer<CR>",                                  "Stage file" },
      { "d", "<cmd>Gitsigns diffthis HEAD<CR>",                                 "Git diff" },
      { "i", "<cmd>Gitsigns blame_line<CR>",                                    "Commit info" },
      { "l", "<cmd>Gitsigns toggle_current_line_blame<CR>",                     "Line blame" },
      { "o", "<cmd>Telescope git_status<CR>",                                   "Open changed file" },
      { "p", "<cmd>Gitsigns preview_hunk<CR>",                                  "Preview hunk" },
      { "r", "<cmd>Gitsigns reset_hunk<CR>",                                    "Reset hunk" },
      { "s", "<cmd>Gitsigns stage_hunk<CR>",                                    "Stage hunk" },
      { "u", "<cmd>Gitsigns undo_stage_hunk<CR>",                               "Undo stage hunk" },
    },
  },
  {
    name = "Code/Copilot",
    leader = "<leader>c",
    mappings = {
      -- code issues
      { "D", "<cmd>Telescope diagnostics<CR>",                                  "Workspace diagnostics" },
      { "a", vim.lsp.buf.code_action,                                           "Code actions/Quickfixes" },
      { "d", "<cmd>lua require('cange.lsp').toggle_virtual_text()<CR>",         "Toggle inline virtual text" },
      { "l", '<cmd>lua require("cange.telescope").diagnostics_log()<CR>',       "File diagnostics" },
      -- formatter
      { "R", "<cmd>LspRestart<CR>",                                             "Restart LSP" },
      { "c", "<cmd>TextCaseOpenTelescope<CR>",                                  "Change Case", mode = { "v", "n" } },
      { "f", "<cmd>lua require('cange.lsp.format').toggle_format_on_save()<CR>","Toggle format on save" },
      { "l", '<cmd>lua require("cange.telescope").diagnostics_log()<CR>',       "File diagnosticss" },
      -- copilot
      { "p", "<cmd>Copilot panel<CR>",                                          "Toggle Copilot panel" },
      { "r", "<cmd>lua require('copilot.panel').refresh()<CR>",                 "Refresh Copilot panel" },
      { "s", "<cmd>Copilot suggestion<CR>",                                     "Toggle Copilot suggestion" },
      { "t", "<cmdrequire('copilot.suggestion').toggle_auto_trigger()<CR>",     "Toggle Copilot suggestion auto trigger" },
      { "o", "<cmd>Copilot toggle<CR>",                                         "Toggle Copilot" },
      { "S", "<cmd>Copilot status<CR>",                                         "Copilot status" },
    },
  },
  {
    name = "Search",
    leader = "<leader>s",
    mappings = {
      { "B", "<cmd>Telescope buffers<CR>",                                      "Search buffers" },
      { "C", "<cmd>Telescope commands<CR>",                                     "Search commands" },
      { "H", '<cmd>Telescope highlights<CR>',                                   "Search highlights" },
      { "b", '<cmd>lua require("cange.telescope").file_browser()<CR>',          "Search in current directory" },
      { "h", "<cmd>Telescope help_tags<CR>",                                    "Search nvim help" },
      { "k", "<cmd>Telescope keymaps<CR>",                                      "Search keybindings" },
      { "n", '<cmd>lua require("cange.telescope").browse_nvim()<CR>',           "Search nvim config" },
      { "r", "<cmd>Telescope oldfiles<CR>",                                     "Search recently opened files" },
      { "s", '<cmd>lua require("auto-session.session-lens").search_session()<CR>', "Search Recent Sessions" },
      { "w", '<cmd>lua require("cange.telescope").browse_workspace()<CR>',      "Search current workspace" },
    },
  },
}
-- stylua: ignore end

return M
