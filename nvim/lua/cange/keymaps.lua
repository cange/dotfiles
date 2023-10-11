local function help_under_cursor() vim.cmd("help " .. (vim.bo.filetype == "lua" and vim.fn.expand("<cword>") or "")) end
local keymaps = {
  { "n", "<F1>", help_under_cursor, { desc = "Help for keyword under cursor" } },
  { "v", "<F5>", ":sort<CR>gv=gv", { desc = "Sort selected lines" } },
  { "v", "p", '"_dP', { desc = "Clipboard: keep content" } },
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
---@type KeymapsMappingGroup[]
M.groups = {
  {
    name = "Goto",
    leader = "g",
    mappings = {
      { "D", vim.lsp.buf.declaration,                                           "LSP Goto symbol Declaration" },
      { "d", vim.lsp.buf.definition,                                            "LSP Goto symbol Definition" },
      { "i", vim.lsp.buf.implementation,                                        "LSP List symbol Implementation" },
      { "r", "<cmd>Telescope lsp_references<CR>",                               "LSP Symbol References" },
    },
  },
  {
    name = "Prev",
    leader = "[",
    mappings = {
      { "g", "<cmd>Gitsigns prev_hunk<CR>",                                     "Git hunk" },
      { "b", '<cmd>bprevious<CR>',                                              "Buffer" },
      { "c", '<cmd>lua R("copilot.suggestion").prev()<CR>',                     "Copilot suggestion" },
      { "d", vim.diagnostic.goto_prev,                                          "Diagnostic" },
      { "m", '<cmd>lua R("harpoon.ui").nav_prev()<CR>',                         "Bookmark" },
      { "p", '<cmd>lua R("copilot.panel").jump_prev()<CR>',                     "Copilot panel" },
    },
  },
  {
    name = "Next",
    leader = "]",
    mappings = {
      { "g", "<cmd>Gitsigns next_hunk<CR>",                                     "Git hunk" },
      { "b", '<cmd>bnext<CR>',                                                  "Buffer" },
      { "c", '<cmd>lua R("copilot.suggestion").next()<CR>',                     "Copilot suggestion" },
      { "d", vim.diagnostic.goto_next,                                          "Diagnostic" },
      { "m", '<cmd>lua R("harpoon.ui").nav_next()<CR>',                         "Bookmark" },
      { "p", '<cmd>lua R("copilot.panel").jump_next()<CR>',                     "Copilot panel" },
    },
  },
  {
    name = "Primary",
    leader = "<leader>",
    mappings = {
      { "<F2>", '<cmd>lua R("cange.lsp").format({ force = true })<CR>',         "Format" },
      { "-", "<C-W>s",                                                          "Split window below" },
      { "/", "<cmd>Telescope current_buffer_fuzzy_find<CR>",                    "Search in current file" },
      { "a", '<cmd>lua R("harpoon.mark").add_file()<CR>',                       "Add bookmark" },
      { "d", vim.lsp.buf.type_definition,                                       "LSP Goto type Definition" },
      { "f", "<cmd>Telescope find_files<CR>",                                   "Search Files" },
      { "m", '<cmd>lua R("harpoon.ui").toggle_quick_menu()<CR>',                "Show bookmarks" },
      { "n", "<cmd>lua vim.o.relativenumber = not vim.o.relativenumber<CR>",    "Toggle relative number" },
      { "r", vim.lsp.buf.rename,                                                "LSP Rename symbol"},
      { "w", "<cmd>w!<CR>",                                                     "Save file" },
      { "z", "<cmd>ZenMode<CR>",                                                "Toggle Zen Mode" },
      { "|", "<C-W>v",                                                          "Split window right" },
    },
  },
  {
    name = "Secondary",
    leader = "<localleader>",
    mappings = {
      { "a", "gg<S-v>G",                                                        "Select all content" },
      { "f", "<cmd>lua R('cange.telescope').live_grep()<CR>",                   "Search in Files" },
      { "r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>]],            "Replace under cursor"  },
      {
        "x",
        "<cmd>write<CR><cmd>lua R('cange'); Log:info(vim.fn.expand('%@'), 'File saved and executed!')<CR>",
        "Reload current file",
      },
      { "o", "<cmd>lua R('spec_toggler').only()<CR>",                           "Only it/describe/test toggle" },
      { "s", "<cmd>lua R('spec_toggler').skip()<CR>",                           "Skip it/describe/test toggle" },
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
      { "5", '<cmd>lua R("cange.telescope").browse_snippets()<CR>',             "Edit snippets" },
      { "6", "<cmd>e ~/.config/nvim/lua/cange/keymaps.lua<CR>",                 "Edit keymaps" },
      { "7", "<cmd>e ~/.config/nvim/lua/cange/options.lua<CR>",                 "Edit options" },
      { "8", "<cmd>e ~/.config/nvim/lua/cange/config.lua<CR>",                  "Edit config" },
      -- session
      { "R", "<cmd>SessionRestore<CR>",                                         "Recent session" },
      { "s", "<cmd>SessionSave<CR>",                                            "Save session" },
      { "X", "<cmd>SessionDelete<CR>",                                          "Delete session" },
      -- others
      { "l", "<cmd>lua R('cange.lsp.toggle').format_on_save()<CR>",             "Toggle format on save" },
      { "S", "<cmd>lua vim.o.spell = not vim.o.spell<CR>",                      "Toggle spelling" },
      { "c", "<cmd>Telescope colorscheme<CR>",                                  "Change colorscheme" },
      { "C", '<cmd>lua R("luasnip").cleanup()<CR>',                             "Reset snippets UI" },
      { "p", "<cmd>lua R('telescope').extensions.project.project()<CR>",        "Switch workspace" },
      {
        "N",
        "<cmd>lua R('telescope').extensions.notify.notify({ layout_strategy = 'vertical' })<CR>",
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
      { "I", '<cmd>lua R("gitsigns").blame_line({ full = true })<CR>',          "Commit full info" },
      { "R", "<cmd>Gitsigns reset_buffer<CR>",                                  "Reset file" },
      { "S", "<cmd>Gitsigns stage_buffer<CR>",                                  "Stage file" },
      { "D", "<cmd>Gitsigns diffthis HEAD<CR>",                                 "Git diff" },
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
      { "d", "<cmd>lua R('cange.lsp.toggle').virtual_text()<CR>",               "Toggle inline virtual text" },
      { "l", '<cmd>lua R("cange.telescope").diagnostics_lo()<CR>',              "File diagnostics" },
      -- formatter
      { "r", "<cmd>LspRestart;<CR><cmd>lua Log:info('Restarted', 'LSP')<CR>",   "Restart LSP" },
      { "c", "<cmd>TextCaseOpenTelescope<CR>",                                  "Change Case", mode = { "v", "n" } },
      { "f", "<cmd>lua R('cange.lsp.format').toggle_format_on_save()<CR>",      "Toggle format on save" },
      { "l", '<cmd>lua R("cange.telescope").diagnostics_lo()<CR>',              "File diagnostics" },
      -- copilot
      { "A", "<cmd>lua R('copilot.panel').accept()<CR>",                        "Accept Copilot panel" },
      { "S", "<cmd>Copilot status<CR>",                                         "Copilot status" },
      { "o", "<cmd>Copilot toggle<CR>",                                         "Toggle Copilot" },
      { "p", "<cmd>Copilot panel<CR>",                                          "Toggle Copilot panel" },
      {
        "R",
        "<cmd>lua R('copilot.panel').refresh();<CR><cmd>lua Log:info('Refresh panel', 'Copilot')<CR>",
        "Refresh Copilot panel"
      },
      { "s", "<cmd>Copilot suggestion<CR>",                                     "Toggle Copilot suggestion" },
      { "t", "<cmd>lua R('copilot.suggestion').toggle_auto_trigger()<CR>",      "Toggle Copilot suggestion auto trigger" },
    },
  },
  {
    name = "Search",
    leader = "<leader>s",
    mappings = {
      { "B", "<cmd>Telescope buffers<CR>",                                      "Buffers" },
      { "C", "<cmd>Telescope commands<CR>",                                     "Commands" },
      { "H", '<cmd>Telescope highlights<CR>',                                   "Highlights" },
      { "W", '<cmd>lua R("cange.telescope").browse_workspace()<CR>',            "Current workspace" },
      { "b", '<cmd>lua R("cange.telescope").file_browser()<CR>',                "In current directory" },
      { "h", "<cmd>Telescope help_tags<CR>",                                    "Nvim help" },
      { "k", "<cmd>Telescope keymaps<CR>",                                      "Keybindings" },
      { "n", '<cmd>lua R("cange.telescope").browse_nvim()<CR>',                 "Nvim config" },
      { "m", '<cmd>Telescope harpoon marks<CR>',                                "Search bookmarks" },
      { "r", "<cmd>Telescope oldfiles<CR>",                                     "Recently opened files" },
      { "s", '<cmd>lua R("auto-session.session-lens").search_session()<CR>',    "Recent Sessions" },
      { "t", "<cmd>TodoTelescope<CR>",                                          "Todo comments" },
      { "w", "<cmd>Telescope grep_string<CR>",                                  "Current word" },
    },
  },
}
-- stylua: ignore end

return M
