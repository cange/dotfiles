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
