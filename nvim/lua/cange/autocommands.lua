-- autocmd! remove all autocommands, if entered under a group it will clear that group
vim.cmd [[
  augroup _autoindent_on_save
  autocmd!
  autocmd BufWritePre * :normal migg=G`i
  augroup end
]]
