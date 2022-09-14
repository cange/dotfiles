local found, gitsigns = pcall(require, 'gitsigns')
if not found then
  return
end

gitsigns.setup({
  signs = {
    add          = { hl = 'GitSignsAdd',    text = '▎', numhl = 'GitSignsAddNr',    linehl = 'GitSignsAddLn' },
    change       = { hl = 'GitSignsChange', text = '▎', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    delete       = { hl = 'GitSignsDelete', text = '', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    topdelete    = { hl = 'GitSignsDelete', text = '', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '▎', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
  },
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 800,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = ' <author>, <author_time:%Y-%m-%d> • <summary>',
})
-- increase contrast
-- vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { link = 'Comment' })
