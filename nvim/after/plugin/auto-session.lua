local found, auto_session = pcall(require, "auto-session")
if not found then
  return
end

local found_lens, session_lens = pcall(require, "session-lens")
if not found_lens then
  print('[auto-session] "session-lens" not found')
  return
end

local settings = {
  log_level = "info",
  auto_restore_enabled = nil,
  auto_save_enabled = nil,
  auto_session_enable_last_session = false, -- Loads the last loaded session if session for cwd does not exist
  auto_session_enabled = true,
  auto_session_suppress_dirs = { "~/", "~/workspace" }, -- Suppress session create/restore if in one of the list of dirs
  auto_session_use_git_branch = nil, -- Use the git branch to differentiate the session name
  -- the configs below are lua only
  bypass_session_save_file_types = { "alpha" },
}

-- better experience with the plugin overall using this config for sessionoptions is recommended.
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

session_lens.setup({
  path_display = { "shorten" },
  previewer = true,
  prompt_title = "Sessions",
})

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

auto_session.setup(settings)
