local ok, lualine = pcall(require, 'lualine')
if not ok then return end

-- see https://github.com/nvim-lualine/lualine.nvim#configuring-lualine-in-initvim

lualine.setup()
