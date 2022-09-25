local found, bufferline = pcall(require, 'bufferline')
if not found then
  return
end

-- local utils = Cange.bulk_loader('bufferline', {
--   { 'cange.colorscheme', 'colorscheme' },
-- })
-- local c = utils.colorscheme.palette()
--
-- -- vim.pretty_print('colors', c)
--
bufferline.setup({
  options = {
    mode = 'tabs',
    separator_style = 'thick',
    always_show_bufferline = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = true,
  },
  -- highlights = {
  --   fill = {
  --     fg = c.magenta.base,
  --     bg = c.bg0,
  --   },
  --   separator = {
  --     fg = c.bg2,
  --     bg = c.bg0,
  --   },
  --   separator_selected = {
  --     fg = c.bg1,
  --   },
  --   background = {
  --     fg = c.fg1,
  --     bg = c.bg0,
  --   },
  --   buffer_selected = {
  --     fg = c.fg2,
  --     bold = false,
  --     italic = false,
  --   },
  -- },
})
