local function help_under_cursor() vim.cmd("help " .. (vim.bo.filetype == "lua" and vim.fn.expand("<cword>") or "")) end
local replace_under_cursor = [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>]]

local keymaps = {
  { "<F1>", help_under_cursor, { desc = "Help for keyword under cursor" } },
  { "<leader><leader>", "<C-^>", { desc = "Toggle between previous buffer" } },
  { "[b", "<cmd>bprev<CR>", { desc = "Prev Buffer" } },
  { "]b", "<cmd>bnext<CR>", { desc = "Next Buffer" } },
  { "p", '"_dP', { desc = "Clipboard: keep content" }, { "v" } },

  -- Moving lines up and down
  { "<M-down>", ":move .+1<CR>==", { desc = "Line move: down" } },
  { "<M-up>", ":move .-2<CR>==", { desc = "Line move: up" } },
  { "<M-down>", ":move'>+<CR>='[gv", { desc = "Line move: down" }, { "v" } },
  { "<M-up>", ":move-2<CR>='[gv", { desc = "Line move: up" }, { "v" } },
  { "j", ":move'>+<CR>='[gv", { desc = "Line move: down" }, { "v" } },
  { "k", ":move-2<CR>='[gv", { desc = "Line move: up" }, { "v" } },

  { "<C-M-left>", "<C-W>5<", { desc = "Resize left" } },
  { "<C-M-down>", "<C-W>-", { desc = "Resize down" } },
  { "<C-M-up>", "<C-W>+", { desc = "Resize up" } },
  { "<C-M-right>", "<C-W>5>", { desc = "Resize right" } },

  -- Window movements
  { "w<left>", "<C-w>h", { desc = "Switch to left" } },
  { "w<down>", "<C-w>j", { desc = "Switch to down" } },
  { "w<up>", "<C-w>k", { desc = "Switch to up" } },
  { "w<right>", "<C-w>l", { desc = "Switch to right" } },
  { "wh", "<C-w>h", { desc = "Switch to left" } },
  { "wj", "<C-w>j", { desc = "Switch to down" } },
  { "wk", "<C-w>k", { desc = "Switch to up" } },
  { "wl", "<C-w>l", { desc = "Switch to right" } },

  -- Keep selection marked when indenting
  { "<", "<gv", { desc = "Indent: left" }, { "v" } },
  { ">", ">gv", { desc = "Indent: right" }, { "v" } },
  { "<Tab>", ">gv", { desc = "Indent: left" }, { "v" } },
  { "<S-Tab>", "<gv", { desc = "Indent: right" }, { "v" } },

  -- others
  { "<leader>w", "<cmd>w!<CR>", { desc = "Save file" } },
  { "<localleader>a", "gg<S-v>G", { desc = "Select all content" } },
  { "<localleader>r", replace_under_cursor, { desc = "Replace under cursor" } },
  { "<localleader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" } },
  { "<localleader><localleader>x", "<cmd>source %<CR>", { desc = "Execute the current file" } },
  { "<localleader>S", ":sort<CR>gv=gv", { desc = "Sort selected lines" }, { "v" } },
}

for _, map in pairs(keymaps) do
  local lhs = map[1]
  local rhs = map[2]
  local opts = map[3]
  local mode = map[4] ~= nil and map[4] or { "n" }

  vim.keymap.set(mode, lhs, rhs, opts)
end
