-- local ns = "[cange.keymaps.common]"
vim.keymap.set("v", "p", '"_dP') -- Keep clipboard content instead of overriding it

-- greatest remap ever
vim.keymap.set("x", "<leader>p", '"_dP')
--
-- -- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')
vim.keymap.set("n", "<leader>Y", '"+Y', { noremap = false })
--
-- Select all content
vim.keymap.set("n", "<C-a>", "gg<S-v>G")
--
-- New tab "ctrl+w + t"
vim.keymap.set("n", "<C-w>t", ":tabedit<CR>")

-- Move window "w+<direction>"
vim.keymap.set("", "w<left>", "<C-w>h")
vim.keymap.set("", "w<down>", "<C-w>j")
vim.keymap.set("", "w<up>", "<C-w>k")
vim.keymap.set("", "w<right>", "<C-w>l")
vim.keymap.set("", "wh", "<C-w>h")
vim.keymap.set("", "wj", "<C-w>j")
vim.keymap.set("", "wk", "<C-w>k")
vim.keymap.set("", "wl", "<C-w>l")

-- Moving lines up and down
vim.keymap.set("n", "<A-down>", ":move .+1<CR>==")
vim.keymap.set("n", "<A-up>", ":move .-2<CR>==")
vim.keymap.set("x", "<A-down>", ":move'>+<CR>='[gv")
vim.keymap.set("x", "<A-up>", ":move-2<CR>='[gv")
vim.keymap.set("x", "j", ":move'>+<CR>='[gv")
vim.keymap.set("x", "k", ":move-2<CR>='[gv")

vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split window right" })

--- Resize window with arrows
vim.keymap.set("n", "<C-down>", ":resize +4<CR>")
vim.keymap.set("n", "<C-left>", ":vertical resize -4<CR>")
vim.keymap.set("n", "<C-up>", ":resize -4<CR>")
vim.keymap.set("n", "<C-right>", ":vertical resize +4<CR>")

-- Keep selection marked when indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")

-- switch between the last recent open two files
vim.keymap.set("n", "<leader><leader>", "<C-^>")

-- Reload current file
vim.keymap.set(
  "n",
  "<leader><leader>x",
  ':write<CR>:luafile %<CR>:lua Cange.log.info("File saved and executed", "Executed!")<CR>'
)

-- Format
vim.keymap.set("n", "<F2>", ":lua vim.lsp.buf.format({ async = true })<CR>")

-- Sort lines
vim.keymap.set("v", "<F5>", ":sort<CR>gv=gv")
