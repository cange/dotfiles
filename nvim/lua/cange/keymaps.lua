local keymaps = {
  { "v", "p", '"_dP', { desc = "Clipboard: keep content" } },
  { "n", "<C-a>", "gg<S-v>G", { desc = "Select all content" } },
  { "v", "<F5>", ":sort<CR>gv=gv", { desc = "Sort selected lines" } },
  { "n", "<leader><leader>", "<C-^>", { desc = "Switch last recent 2 buffers" } },
  {
    "n",
    "<leader><leader>x",
    ':write<CR>:luafile %<CR>:lua Cange.log("File saved and executed", { title = "Executed!" })<CR>',
    { desc = "Reload current file" },
  },

  -- Move window scope
  { "", "w<left>", "<C-w>h", { desc = "Window scope: left" } },
  { "", "w<down>", "<C-w>j", { desc = "Window scope: down" } },
  { "", "w<up>", "<C-w>k", { desc = "Window scope: up" } },
  { "", "w<right>", "<C-w>l", { desc = "Window scope: right" } },
  { "", "wh", "<C-w>h", { desc = "Window scope: left" } },
  { "", "wj", "<C-w>j", { desc = "Window scope: down" } },
  { "", "wk", "<C-w>k", { desc = "Window scope: up" } },
  { "", "wl", "<C-w>l", { desc = "Window scope: right" } },

  -- Moving lines up and down
  { "n", "<A-down>", ":move .+1<CR>==", { desc = "Line move: down" } },
  { "n", "<A-up>", ":move .-2<CR>==", { desc = "Line move: up" } },
  { "x", "<A-down>", ":move'>+<CR>='[gv", { desc = "Line move: down" } },
  { "x", "<A-up>", ":move-2<CR>='[gv", { desc = "Line move: up" } },
  { "x", "j", ":move'>+<CR>='[gv", { desc = "Line move: down" } },
  { "x", "k", ":move-2<CR>='[gv", { desc = "Line move: up" } },

  { "n", "<leader>-", "<C-W>s", { desc = "Window split: below" } },
  { "n", "<leader>|", "<C-W>v", { desc = "Window split: right" } },

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

---@type cange.keymapsMappingGroup[]
M.groups = {
  {
    name = "Goto",
    leader = "g",
    mappings = {
      { "d", vim.lsp.buf.definition, "Definition" },
      { "r", "<cmd>Telescope lsp_references<CR>", "References" },
      { "I", vim.lsp.buf.implementation, "Implementation" },
      { "D", vim.lsp.buf.declaration, "Declaration" },
      { "T", vim.lsp.buf.type_definition, "Type definition" },
    },
  },
  {
    name = "Prev",
    leader = "[",
    mappings = {
      { "i", vim.diagnostic.goto_prev, "Next issue" },
      { "g", "<cmd>Gitsigns prev_hunk<CR>", "Next Git hunk" },
    },
  },
  {
    name = "Next",
    leader = "]",
    mappings = {
      { "i", vim.diagnostic.goto_next, "Prev issue" },
      { "g", "<cmd>Gitsigns next_hunk<CR>", "Prev Git hunk" },
    },
  },
  {
    name = "Primary",
    leader = "<leader>",
    mappings = {
      { "<F2>", '<cmd>lua require("cange.lsp.format").format()<CR>', "Format" },
      { "\\", "<cmd>NvimTreeToggle<CR>", "File Explorer" },
      { "ff", "<cmd>lua require('cange.telescope').live_grep()<CR>", "Search in Files" },
      { "a", '<cmd>lua require("harpoon.mark").add_file()<CR>', "Add bookmark" },
      { "f", "<cmd>Telescope find_files<CR>", "Search Files" },
      { "m", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', "Show bookmarks" },
      { "n", "<cmd>lua vim.o.relativenumber = not vim.o.relativenumber<CR>", "Toggle relative number" },
      { "w", "<cmd>w!<CR>", "Save file" },
    },
  },
  {
    name = "Editor",
    leader = "<leader>e",
    mappings = {
      { "S", '<cmd>lua require("luasnip").cleanup()<CR>', "Reset snippets UI" },
      { "c", "<cmd>Telescope colorscheme<CR>", "Switch Colorscheme" },
      { "k", "<cmd>e ~/.config/nvim/lua/cange/keymaps.lua<CR>", "Edit keymaps" },
      { "c", "<cmd>e ~/.config/nvim/lua/cange/config.lua<CR>", "Edit config" },
      -- session
      { "F", "<cmd>SearchSession<CR>", "Find session" },
      { "R", "<cmd>RestoreSession<CR>", "Recent session" },
      { "s", "<cmd>SaveSession<CR>", "Save session" },
      { "x", "<cmd>DeleteSession<CR>", "Delete session" },
      -- workspace
      { "a", vim.lsp.buf.add_workspace_folder, "Add workspace" },
      { "r", vim.lsp.buf.remove_workspace_folder, "Remove workspace" },
      { "p", "<cmd>lua require('telescope').extensions.project.project()<CR>", "Switch workspace" },
    },
  },
  {
    name = "Git",
    leader = "<leader>g",
    mappings = {
      { "B", "<cmd>Telescope git_branches<CR>", "Checkout branch" },
      { "C", "<cmd>Telescope git_commits<CR>", "Checkout commit" },
      { "I", '<cmd>lua require("gitsigns").blame_line({ full = true })<CR>', "Commit full info" },
      { "R", "<cmd>Gitsigns reset_buffer<CR>", "Reset file" },
      { "S", "<cmd>Gitsigns stage_buffer<CR>", "Stage file" },
      { "d", "<cmd>Gitsigns diffthis HEAD<CR>", "Git diff" },
      { "i", "<cmd>Gitsigns blame_line<CR>", "Commit info" },
      { "l", "<cmd>Gitsigns toggle_current_line_blame<CR>", "Line blame" },
      { "o", "<cmd>Telescope git_status<CR>", "Open changed file" },
      { "p", "<cmd>Gitsigns preview_hunk<CR>", "Preview hunk" },
      { "r", "<cmd>Gitsigns reset_hunk<CR>", "Reset hunk" },
      { "s", "<cmd>Gitsigns stage_hunk<CR>", "Stage hunk" },
      { "u", "<cmd>Gitsigns undo_stage_hunk<CR>", "Undo stage hunk" },
    },
  },
  {
    name = "Code",
    leader = "<leader>c",
    mappings = {
      -- code issues
      { "D", "<cmd>Telescope diagnostics<CR>", "Workspace diagnostics" },
      { "d", '<cmd>lua require("cange.telescope").diagnostics_log()<CR>', "File diagnosticss" },
      { "a", vim.lsp.buf.code_action, "Code actions" },
      -- LSP tools
      { "n", "<cmd>NullLsInfo<CR>", "Null-ls info" },
      { "m", "<cmd>Mason<CR>", "Mason LSP sync LSP" },
      { "i", "<cmd>LspInfo<CR>", "LSP info" },
      -- formatter
      { "f", "<cmd>LspToggleFormatOnSave<CR>", "Toggle format on save" },
      { "c", "<cmd>TextCaseOpenTelescope<CR>", "Change Case", mode = { "v", "n" } },
      --
      { "s", "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
      { "h", "<cmd>TSHighlightCapturesUnderCursor<CR>", "Highlight info" },
      { "p", "<cmd>TSPlaygroundToggle<CR>", "Playground" },
    },
  },
  {
    name = "Plugins",
    leader = "<leader>p",
    mappings = {
      { "S", "<cmd>Lazy health<CR>", "Plugins status" },
      { "h", "<cmd>Lazy help<CR>", "Plugins help" },
      { "s", "<cmd>Lazy sync<CR>", "Plugins sync" },
      { "i", "<cmd>Lazy show<CR>", "Plugins show" },
    },
  },
  {
    name = "Search",
    leader = "<leader>s",
    mappings = {
      { "B", "<cmd>Telescope buffers<CR>", "Search buffers" },
      { "C", "<cmd>Telescope commands<CR>", "Search commands" },
      { "H", '<cmd>lua require("telescope.builtin").highlights()<CR>', "Search highlights" },
      { "N", "<cmd>Telescope notify<CR>", "Search notifications" },
      { "b", '<cmd>lua require("cange.telescope").file_browser()<CR>', "Search in current directory" },
      { "h", "<cmd>Telescope help_tags<CR>", "Search nvim help" },
      { "k", "<cmd>Telescope keymaps<CR>", "Search keybindings" },
      { "n", '<cmd>lua require("cange.telescope").browse_nvim()<CR>', "Search nvim config" },
      { "r", "<cmd>Telescope oldfiles<CR>", "Search recently opened files" },
      { "w", '<cmd>lua require("cange.telescope").browse_workspace()<CR>', "Search current workspace" },
      {
        "/",
        '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>',
        "Search in current file",
      },
    },
  },
}

return M
