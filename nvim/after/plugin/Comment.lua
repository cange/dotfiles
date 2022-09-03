local ok, comment = pcall(require, 'Comment')
if not ok then return end

-- https://github.com/numToStr/Comment.nvim#configuration-optional
comment.setup()
