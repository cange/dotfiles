---@class cange

-- Order is important

-- 1st : setup
Cange = require("cange.utils")
Cange.reload("cange.options")
Log = Cange.reload("cange.utils.log")

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

-- 2nd : initialize
require("lazy").setup("cange.plugins", {
  checker = {
    enabled = true, -- allows to get the number of pending updates when true
  },
})

-- 3th : rest
Cange.reload("cange.autocommands")
Cange.reload("cange.keymaps")
Cange.reload("cange.telescope")
