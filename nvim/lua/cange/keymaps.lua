local function help_under_cursor() vim.cmd("help " .. (vim.bo.filetype == "lua" and vim.fn.expand("<cword>") or "")) end
local keymaps = {
  { "n", "<F1>", help_under_cursor, { desc = "Help for keyword under cursor" } },
  { "n", "<leader><leader>", "<C-^>", { desc = "Switch last recent 2 buffers" } },
  { "n", "[b", "<cmd>bprev<CR>", { desc = "Prev Buffer" } },
  { "n", "]b", "<cmd>bnext<CR>", { desc = "Next Buffer" } },
  { "v", "p", '"_dP', { desc = "Clipboard: keep content" } },

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

  -- Window movements
  { "n", "w<left>", "<C-w>h", { desc = "Switch to left" } },
  { "n", "w<down>", "<C-w>j", { desc = "Switch to down" } },
  { "n", "w<up>", "<C-w>k", { desc = "Switch to up" } },
  { "n", "w<right>", "<C-w>l", { desc = "Switch to right" } },
  { "n", "wh", "<C-w>h", { desc = "Switch to left" } },
  { "n", "wj", "<C-w>j", { desc = "Switch to down" } },
  { "n", "wk", "<C-w>k", { desc = "Switch to up" } },
  { "n", "wl", "<C-w>l", { desc = "Switch to right" } },

  -- Keep selection marked when indenting
  { "v", "<", "<gv", { desc = "Indent: left" } },
  { "v", ">", ">gv", { desc = "Indent: right" } },
  { "v", "<Tab>", ">gv", { desc = "Indent: left" } },
  { "v", "<S-Tab>", "<gv", { desc = "Indent: right" } },

  -- convenience shortcuts
  { "c", "Xa", "xa", { desc = "Write all buffer and exit Vim (convenience)" } },
  { "c", "Qa", "qa", { desc = "Exit Vim (convenience)" } },

  -- others
  { "n", "<leader>eS", "<cmd>lua vim.o.spell = not vim.o.spell<CR>", { desc = "Toggle spelling" } },
  { "n", "<leader>-", "<C-W>s", { desc = "Split window below" } },
  { "n", "<leader>n", "<cmd>lua vim.o.rnu= not vim.o.rnu<CR>", { desc = "Toggle relative number" } },
  { "n", "<leader>w", "<cmd>w!<CR>", { desc = "Save file" } },
  { "n", "<leader>|", "<C-W>v", { desc = "Split window right" } },
  { "n", "<localleader>a", "gg<S-v>G", { desc = "Select all content" } },
  { "n", "<localleader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>]], { desc = "Replace under cursor" } },
  {
    "n",
    "<localleader>x",
    "<cmd>write<CR><cmd>lua R('cange'); Log:info(vim.fn.expand('%@'), 'File saved/executed!')<CR>",
    { desc = "Reload current file" },
  },
  { "v", "<localleader>S", ":sort<CR>gv=gv", { desc = "Sort selected lines" } },
}

for _, km in pairs(keymaps) do
  local mode = km[1]
  local lhs = km[2]
  local rhs = km[3]
  local opts = km[4] ~= nil and km[4] or {}

  vim.keymap.set(mode, lhs, rhs, opts)
end
