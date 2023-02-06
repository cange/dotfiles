-- local ns = "[cange.keymaps.common]"
--
local keymaps = {
  -- Keep clipboard content instead of overriding i
  { "v", "p", '"_dP' },

  -- greatest remap ever
  { "x", "<leader>p", '"_dP' },
  --
  -- -- next greatest remap ever : asbjornHaland
  { { "n", "v" }, "<leader>y", '"+y' },
  { { "n", "v" }, "<leader>d", '"_d' },
  { "n", "<leader>Y", '"+Y', { noremap = false } },
  --
  -- Select all content
  { "n", "<C-a>", "gg<S-v>G" },
  --
  -- New tab "ctrl+w + t"
  { "n", "<C-w>t", ":tabedit<CR>" },

  -- Move window "w+<direction>"
  { "", "w<left>", "<C-w>h" },
  { "", "w<down>", "<C-w>j" },
  { "", "w<up>", "<C-w>k" },
  { "", "w<right>", "<C-w>l" },
  { "", "wh", "<C-w>h" },
  { "", "wj", "<C-w>j" },
  { "", "wk", "<C-w>k" },
  { "", "wl", "<C-w>l" },

  -- Moving lines up and down
  { "n", "<A-down>", ":move .+1<CR>==" },
  { "n", "<A-up>", ":move .-2<CR>==" },
  { "x", "<A-down>", ":move'>+<CR>='[gv" },
  { "x", "<A-up>", ":move-2<CR>='[gv" },
  { "x", "j", ":move'>+<CR>='[gv" },
  { "x", "k", ":move-2<CR>='[gv" },

  { "n", "<leader>-", "<C-W>s", { desc = "Split window below" } },
  { "n", "<leader>|", "<C-W>v", { desc = "Split window right" } },

  --- Resize window with arrows
  { "n", "<C-down>", ":resize +4<CR>" },
  { "n", "<C-left>", ":vertical resize -4<CR>" },
  { "n", "<C-up>", ":resize -4<CR>" },
  { "n", "<C-right>", ":vertical resize +4<CR>" },

  -- Keep selection marked when indenting
  { "v", "<", "<gv" },
  { "v", ">", ">gv" },
  { "v", "<Tab>", ">gv" },
  { "v", "<S-Tab>", "<gv" },

  -- switch between the last recent open two files
  { "n", "<leader><leader>", "<C-^>" },

  -- Reload current file
  {
    "n",
    "<leader><leader>x",
    ':write<CR>:luafile %<CR>:lua Cange.log.info("File saved and executed", "Executed!")<CR>',
  },

  -- Sort lines
  { "v", "<F5>", ":sort<CR>gv=gv" },
}

for _, km in pairs(keymaps) do
  local mode = km[1]
  local lhs = km[2]
  local rhs = km[3]
  local opts = km[4] ~= nil and km[4] or {}

  vim.keymap.set(mode, lhs, rhs, opts)
end
