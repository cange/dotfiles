local function help_under_cursor() vim.cmd("help " .. (vim.bo.filetype == "lua" and vim.fn.expand("<cword>") or "")) end
local replace_under_cursor = [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>]]

local keymaps = {
  { "<F1>", help_under_cursor, { desc = "Help for keyword under cursor" } },
  { "<Leader><Leader>", "<C-^>", { desc = "Toggle between previous buffer" } },
  { "[b", "<cmd>bprev<CR>", { desc = "Prev Buffer" } },
  { "]b", "<cmd>bnext<CR>", { desc = "Next Buffer" } },
  { "p", '"_dP', { desc = "Clipboard: keep content" }, { "v" } },

  -- Scrolling
  { "<C-u>", "<C-u>zz", { desc = "Scroll full page up centered" } },
  { "<C-f>", "<C-f>zz", { desc = "Scroll full page down centered" } },
  { "<C-b>", "<C-b>zz", { desc = "Scroll half page up centered" } },
  { "<C-d>", "<C-d>zz", { desc = "Scroll half page down centered" } },

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
  { "<Leader>w", "<cmd>w!<CR>", { desc = "Save file" } },
  { "<Leader>bc", "<cmd>%bdelete|e#<CR>", { desc = "Close other buffers" } },
  { "<LocalLeader>wo", "<cmd>only<CR>", { desc = "Close all windows except current" } },
  { "<LocalLeader>a", "gg<S-v>G", { desc = "Select all content" } },
  { "<LocalLeader>a", "gg<S-v>G", { desc = "Select all content" } },
  { "<LocalLeader>r", replace_under_cursor, { desc = "Replace under cursor" } },
  {
    "<LocalLeader>x",
    "<cmd>.lua<CR><cmd>lua Notify.info('executed', { title = 'Current line' })<CR>",
    { desc = "Execute the current line" },
  },
  {
    "<LocalLeader><LocalLeader>x",
    "<cmd>source %<CR><cmd>lua Notify.info('executed', { title = vim.fn.expand('%:t') })<CR>",
    { desc = "Execute the current file" },
  },
  { "<LocalLeader>S", ":sort<CR>gv=gv", { desc = "Sort selected lines" }, { "v" } },
  { "<ESC><ESC>", "<C-\\><C-n>", { desc = "Escape nvim terminal mode" }, { "t" } },
  {
    "<LocalLeader>d",
    function()
      vim.cmd.new()
      vim.cmd.term()
      vim.cmd.wincmd("J")
      vim.api.nvim_win_set_height(0, 10)
    end,
    { desc = "Terminal (horizontal)" },
  },
  {
    "<LocalLeader>D",
    function()
      vim.cmd.vnew()
      vim.cmd.term()
      vim.cmd.wincmd("L")
    end,
    { desc = "Terminal (vertical)" },
  },
}

for _, map in pairs(keymaps) do
  local lhs = map[1]
  local rhs = map[2]
  local opts = map[3]
  local mode = map[4] ~= nil and map[4] or { "n" }

  vim.keymap.set(mode, lhs, rhs, opts)
end
