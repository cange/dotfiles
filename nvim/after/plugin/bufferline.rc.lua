local ok, bufferline = pcall(require, "bufferline")
local theme_ok, _ = pcall(require, 'nightfox')
if not ok or not theme_ok then return end


local color = require('nightfox.palette').load('terafox')
-- print(vim.inspect(color))

bufferline.setup({
  options = {
    mode = 'tabs',
    separator_style = 'thick',
    always_show_bufferline = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = true
  },
  highlights = {
    fill = {
      fg = color.magenta.base,
      bg = color.green.base,
    },
    separator = {
      fg = '#073642',
      bg = '#002b36',
    },
    separator_selected = {
      fg = '#073642',
    },
    background = {
      fg = '#657b83',
      bg = '#002b36'
    },
    buffer_selected = {
      fg = color.fg2,
      bold = false,
      italic = false
    },
  },
})

vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})
