-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
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

require("lazy").setup("cange.plugins", {
  checker = {
    notify = false, -- get a notification when new updates are found
    enabled = true, -- automatically check for plugin updates
  },
  ui = {
    size = { width = 0.6 }, -- a number <1 is a percentage., >1 is a fixed size
  },
  change_detection = { notify = false },
})
