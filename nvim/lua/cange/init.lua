-- [[ Plugin manager ]]
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

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--[[ Order is important ]]
Cange = require("cange.utils") -- 1st
require("lazy").setup("plugins") -- 2nd
-- [[ Other stuff ]]
Cange.reload("cange.cmp")
Cange.reload("cange.core")
Cange.reload("cange.keymaps")
Cange.reload("cange.lsp")
Cange.reload("cange.telescope")
