local ns = "cange.keymaps.common"
local found_utils, utils = pcall(require, "cange.utils")
if not found_utils then
  print("[" .. ns .. '] "cange.utils" not found')
  return
end
local keymap = utils.keymap
--[[
  FIRST: Set leader key
  Leader needs to be defined before any other keymaps definintions
]]
vim.g.mapleader = " "

-- sort line
keymap("v", "<F5>", ":sort<CR>gv=gv")

keymap("v", "p", '"_dP') -- Keep clipboard content instead of overriding it

-- greatest remap ever
keymap("x", "<leader>p", '"_dP')
--
-- -- next greatest remap ever : asbjornHaland
keymap({ "n", "v" }, "<leader>y", '"+y')
keymap({ "n", "v" }, "<leader>d", '"_d')
keymap("n", "<leader>Y", '"+Y', { noremap = false })
--
-- Select all content
keymap("n", "<C-a>", "gg<S-v>G")
--
-- New tab "ctrl+w + t"
keymap("n", "<C-w>t", ":tabedit<CR>")

-- Move window "w+<direction>"
keymap("", "w<left>", "<C-w>h")
keymap("", "w<down>", "<C-w>j")
keymap("", "w<up>", "<C-w>k")
keymap("", "w<right>", "<C-w>l")
keymap("", "wh", "<C-w>h")
keymap("", "wj", "<C-w>j")
keymap("", "wk", "<C-w>k")
keymap("", "wl", "<C-w>l")

-- Moving lines up and down
keymap("n", "<A-down>", ":move .+1<CR>==")
keymap("n", "<A-up>", ":move .-2<CR>==")
keymap("x", "<A-down>", ":move'>+<CR>='[gv")
keymap("x", "<A-up>", ":move-2<CR>='[gv")
keymap("x", "j", ":move'>+<CR>='[gv")
keymap("x", "k", ":move-2<CR>='[gv")

--- Resize window with arrows
keymap("n", "<C-down>", ":resize +4<CR>")
keymap("n", "<C-left>", ":vertical resize -4<CR>")
keymap("n", "<C-up>", ":resize -4<CR>")
keymap("n", "<C-right>", ":vertical resize +4<CR>")

-- Keep selection marked when indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")
keymap("v", "<Tab>", ">gv")
keymap("v", "<S-Tab>", "<gv")

-- switch between the last recent open two files
keymap("n", "<leader><leader>", "<C-^>")

-- Reload current file
keymap(
  "n",
  "<leader><leader>x",
  ':write<CR>:luafile %<CR>:lua vim.notify("File saved and executed", '
    .. vim.log.levels.INFO
    .. ', { title = "Executed!" })<CR>'
)

-- Format
keymap("n", "<F2>", ":lua vim.lsp.buf.format({ async = true, timeout_ms = 10000 })<CR>")
