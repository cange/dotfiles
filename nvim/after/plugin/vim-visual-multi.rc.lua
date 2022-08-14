local loaded, vmulti = pcall(require, 'vim-visual-multi')
if (not loaded) then return end

vmulti.setup()
