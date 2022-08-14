local loaded, lualine = pcall(require, 'lualine')

if (not loaded) then return end

-- see https://github.com/nvim-lualine/lualine.nvim#configuring-lualine-in-initvim

lualine.setup()
