local loaded, autotag = pcall(require, 'nvim-ts-autotag')
if (not loaded) then return end

autotag.setup()
