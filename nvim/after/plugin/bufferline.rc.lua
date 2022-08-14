local loaded, bufferline = pcall(require, 'bufferline')
if (not loaded) then return end

vim.opt.termguicolors = true
vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})

local loaded, nightfox = pcall(require, 'nightfox')

if (not loaded) then return end

local color = require('nightfox.palette').load('terafox')
-- print(vim.inspect(color))

bufferline.setup({
  options = {
    mode = 'tabs',
    separator_style = 'slant',
    always_show_bufferline = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = true,
    diagnostics = 'nvim_lsp',
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match('error') and " " or " "
      return " " .. icon .. count
    end
  },

  highlights = {
    fill = {
      fg = color.bg0,
      -- bg = color.bg0,
    },
    background = {
      --   fg = color.red.base,
      bg = color.bg0,
    },
    tab = {
      fg = color.bg0,
    },
    warning_selected = {
      bold = true,
      italic = false,
    },
    error_selected = {
      bold = true,
      italic = false,
    },
    buffer_selected = {
      bold = true,
      italic = false,
    },
  },
})
