local loaded, comment = pcall(require, 'Comment')

if (not loaded) then return end

-- https://github.com/numToStr/Comment.nvim#configuration-optional
comment.setup({
  ---LHS of toggle mappings in NORMAL mode
  ---@type table
  toggler = {
    ---Line-comment toggle keymap
    line = '<leader>c<Space>',
    ---Block-comment toggle keymap
    block = '<leader>b<Space>',
  },
  ---LHS of operator-pending mappings in NORMAL and VISUAL mode
  opleader = {
    ---Line-comment keymap
    line = '<leader>c',
    ---Block-comment keymap
    block = '<leader>b',
  },
})
