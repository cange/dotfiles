local found_git, git = pcall(require, "git")
if not found_git then
  return
end

git.setup({
  keymaps = {
    -- Open blame window
    blame = "<leader>Gb",
    -- Open file/folder in git repository
    browse = "<leader>Go",
  },
})
