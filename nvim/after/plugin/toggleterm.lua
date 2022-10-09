local found_toggleterm, toggleterm = pcall(require, "toggleterm")
if not found_toggleterm then
  return
end

toggleterm.setup({
  open_mapping = [[<C-\>]],
})

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<ESC>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-left>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-down>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-up>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-right>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "none",
    width = 100000,
    height = 100000,
  },
  on_open = function(_)
    vim.cmd("startinsert!")
    -- vim.cmd "set laststatus=0"
  end,
  on_close = function(_)
    -- vim.cmd "set laststatus=3"
  end,
  count = 99,
})

function CangeLazygitToggle()
  lazygit:toggle()
end
