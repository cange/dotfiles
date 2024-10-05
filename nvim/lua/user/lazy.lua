-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
vim.keymap.set("n", "<leader>e1", "<cmd>Lazy show<CR>", { desc = "Plugin info" })

require("lazy").setup("user.plugins", {
  checker = {
    notify = false, -- get a notification when new updates are found
    enabled = true, -- automatically check for plugin updates
  },
  change_detection = { notify = false },
})
