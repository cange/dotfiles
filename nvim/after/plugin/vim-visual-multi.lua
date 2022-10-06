local ns = "after.plugin.vim-visual-multi"
local found_utils, utils = pcall(require, "cange.utils")
if not found_utils then
  print("[" .. ns .. '] "cange.utils" not found')
  return
end
local keymap = utils.keymap

-- unmap unwanted key mappings of vim-viual-multi
vim.keymap.del("n", "<C-down>")
vim.keymap.del("n", "<C-up>")

--- Resize window with arrows
keymap("n", "<C-down>", ":resize +4<CR>")
keymap("n", "<C-left>", ":vertical resize -4<CR>")
keymap("n", "<C-right>", ":vertical resize +4<CR>")
keymap("n", "<C-up>", ":resize -4<CR>")
