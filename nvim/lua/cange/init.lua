-- Order is important

-- 1st : setup plugin manager
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

vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.rtp:prepend(lazypath)

-- Basic Keymaps
-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 2nd : initialize
require("lazy").setup("plugins", {
  checker = {
    enabled = true, -- allows to get the number of pending updates when true
  },
})

-- 3rd : globals
Cange = require("cange.utils")

-- 4th : rest
Cange.reload("cange.core")
Cange.reload("cange.keymaps")
Cange.reload("cange.telescope")
