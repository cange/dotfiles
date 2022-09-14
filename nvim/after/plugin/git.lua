local found_git, git = pcall(require, 'git')
if not found_git then
  return
end

git.setup({
  keymaps = {
    -- Open blame window
    blame = '<Leader>gb',
    -- Open file/folder in git repository
    browse = '<Leader>go',
  },
})
