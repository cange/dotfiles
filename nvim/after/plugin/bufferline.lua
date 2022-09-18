local found, bufferline = pcall(require, 'bufferline')
local found_theme, colors = pcall(require, 'colorscheme.palette')
if not found or not found_theme then
  return
end

-- print(vim.inspect(colors)

bufferline.setup({
  options = {
    mode = 'tabs',
    separator_style = 'thick',
    always_show_bufferline = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = true,
  },
  highlights = {
    fill = {
      fg = colors.magenta.base,
      bg = colors.green.base,
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
      bg = '#002b36',
    },
    buffer_selected = {
      fg = colors.fg2,
      bold = false,
      italic = false,
    },
  },
})

vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})
