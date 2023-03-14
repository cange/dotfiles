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
      { "d", vim.lsp.buf.definition, desc = "Definition" },
      { "r", "<cmd>Telescope lsp_references<CR>", desc = "References" },
      { "I", vim.lsp.buf.implementation, desc = "Implementation" },
      { "D", vim.lsp.buf.declaration, desc = "Declaration" },
      { "T", vim.lsp.buf.type_definition, desc = "Type definition" },
    },
  },
  {
    name = "Prev",
    leader = "[",
    mappings = {
      { "i", vim.diagnostic.goto_prev, desc = "Prev issue" },
      { "g", "<cmd>Gitsigns prev_hunk<CR>", desc = "Prev Git hunk" },
    },
  },
  {
    name = "Next",
    leader = "]",
    mappings = {
      { "i", vim.diagnostic.goto_next, desc = "Next issue" },
      { "g", "<cmd>Gitsigns next_hunk<CR>", desc = "Next Git hunk" },
    },
  },
  {
    name = "Primary",
    leader = "<leader>",
    mappings = {
      { "<F2>", '<cmd>lua require("cange.lsp.format").format()<CR>', desc = "Format" },
      { "\\", "<cmd>NvimTreeToggle<CR>", desc = "File Explorer" },
      { "ff", "<cmd>lua require('cange.telescope').live_grep()<CR>", desc = "Search in Files" },
      { "a", '<cmd>lua require("harpoon.mark").add_file()<CR>', desc = "Add Bookmark" },
      { "f", "<cmd>Telescope find_files<CR>", desc = "Search Files" },
      { "m", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', desc = "Bookmarks Menu" },
      { "n", "<cmd>lua vim.o.relativenumber = not vim.o.relativenumber<CR>", desc = "Toggle Relativenumber" },
      { "w", "<cmd>w!<CR>", desc = "Save file" },
    },
  },
  {
    name = "Editor",
    leader = "<leader>e",
    mappings = {
      { "c", "<cmd>Telescope colorscheme<CR>", desc = "Switch Colorscheme" },
      { "k", "<cmd>e ~/.config/nvim/lua/cange/keymaps/M.groups.lua<CR>", desc = "Edit Keymaps" },
      { "o", "<cmd>e ~/.config/nvim/lua/cange/options.lua<CR>", desc = "Edit Options" },
      -- session
      { "F", "<cmd>SearchSession<CR>", desc = "Find Session" },
      { "R", "<cmd>RestoreSession<CR>", desc = "Recent Project" },
      { "s", "<cmd>SaveSession<CR>", desc = "Save Session" },
      { "x", "<cmd>DeleteSession<CR>", desc = "Delete Session" },
      -- workspace
      { "a", vim.lsp.buf.add_workspace_folder, desc = "Add Workspace" },
      { "r", vim.lsp.buf.remove_workspace_folder, desc = "Remove Workspace" },
      { "p", "<cmd>lua require('telescope').extensions.project.project()<CR>", desc = "Switch Workspace" },
    },
  },
  {
    name = "Git",
    leader = "<leader>g",
    mappings = {
      { "B", "<cmd>Telescope git_branches<CR>", desc = "Checkout branch" },
      { "C", "<cmd>Telescope git_commits<CR>", desc = "Checkout commit" },
      { "R", "<cmd>Gitsigns reset_buffer<CR>", desc = "Reset file" },
      { "S", "<cmd>Gitsigns stage_buffer<CR>", desc = "Stage file" },
      { "d", "<cmd>Gitsigns diffthis HEAD<CR>", desc = "Git diff" },
      { "i", "<cmd>Gitsigns blame_line<CR>", desc = "Commit info" },
      { "I", '<cmd>lua require("gitsigns").blame_line({ full = true })<CR>', desc = "Commit full info" },
      { "l", "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "Line blame" },
      { "o", "<cmd>Telescope git_status<CR>", desc = "Open changed file" },
      { "p", "<cmd>Gitsigns preview_hunk<CR>", desc = "Preview hunk" },
      { "r", "<cmd>Gitsigns reset_hunk<CR>", desc = "Reset hunk" },
      { "s", "<cmd>Gitsigns stage_hunk<CR>", desc = "Stage hunk" },
      { "u", "<cmd>Gitsigns undo_stage_hunk<CR>", desc = "Undo stage hunk" },
    },
  },
  {
    name = "Code",
    leader = "<leader>c",
    mappings = {
      { "C", '<cmd>lua require("luasnip").cleanup()<CR>', desc = "Reset snippets UI" },
      { "D", "<cmd>Telescope diagnostics<CR>", desc = "LSP List of Issues" },
      { "H", "<cmd>TSHighlightCapturesUnderCursor<CR>", desc = "Highlight info" },
      { "N", "<cmd>NullLsInfo<CR>", desc = "Null-ls info" },
      { "S", "<cmd>Telescope lsp_document_symbols", desc = "Document Symbols" },
      { "a", vim.lsp.buf.code_action, desc = "Code actions" },
      { "c", "<cmd>TextCaseOpenTelescope<CR>", desc = "Change Case", mode = { "v", "n" } },
      { "d", '<cmd>lua require("cange.telescope").diagnostics_log()<CR>', desc = "Diagnostics log" },
      { "f", "<cmd>LspToggleFormatOnSave<CR>", desc = "Toggle format on save" },
      { "i", "<cmd>LspInfo<CR>", desc = "Info LSP" },
      { "p", "<cmd>TSPlaygroundToggle<CR>", desc = "Playground" },
      { "q", vim.lsp.buf.code_action, desc = "Quickfix issue" },
      { "s", "<cmd>Mason<CR>", desc = "Sync LSP (Mason)" },
    },
  },
  {
    name = "Plugins",
    leader = "<leader>p",
    mappings = {
      { "S", "<cmd>Lazy health<CR>", desc = "Plugin Status" },
      { "h", "<cmd>Lazy help<CR>", desc = "Plugin Help" },
      { "s", "<cmd>Lazy sync<CR>", desc = "Plugins Sync" },
      { "i", "<cmd>Lazy show<CR>", desc = "Plugins Show" },
    },
  },
  {
    name = "Search",
    leader = "<leader>s",
    mappings = {
      { "B", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
      { "C", "<cmd>Telescope commands<CR>", desc = "Commands" },
      { "H", '<cmd>lua require("telescope.builtin").highlights()<CR>', desc = "Highlights" },
      { "N", "<cmd>Telescope notify<CR>", desc = "Notifications" },
      { "b", '<cmd>lua require("cange.telescope").file_browser()<CR>', desc = "Current Directory" },
      { "h", "<cmd>Telescope help_tags<CR>", desc = "Help" },
      { "k", "<cmd>Telescope keymaps<CR>", desc = "Keybindings" },
      { "n", '<cmd>lua require("cange.telescope").browse_nvim()<CR>', desc = "Nvim Config" },
      { "r", "<cmd>Telescope oldfiles<CR>", desc = "Recently Opened Files" },
      { "w", '<cmd>lua require("cange.telescope").browse_workspace()<CR>', desc = "Current Workspace" },
      {
        "/",
        '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>',
        desc = "Current buffer",
      },
    },
  },
}

return M
