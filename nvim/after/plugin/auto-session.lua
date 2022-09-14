local found, auto_session = pcall(require, 'auto-session')
if not found then
  return
end

local found_telescope, telescope = pcall(require, 'telescope')
if not found_telescope then
  vim.notify('auto-session: "telescope" could not be found')
  return
end

local found_lens, session_lens = pcall(require, 'session-lens')
if not found_lens then
  vim.notify('auto-session: "session-lens" could not be found')
  return
end

local found_lualine, lualine = pcall(require, 'lualine')
vim.notify('auto-session: "lualine" could not be found')
if not found_lualine then
  return
end

local settings = {
  log_level = 'info',
  -- auto_restore_enabled = nil, -- Enables/disables auto restoring
  -- auto_save_enabled = nil, -- Enables/disables auto saving
  -- auto_session_allowed_dirs = nil, -- Allow session create/restore if in one of the list of dirs
  -- auto_session_create_enabled = true, -- Enables/disables the plugin's session auto creation
  auto_session_enable_last_session = true, -- Loads the last loaded session if session for cwd does not exist
  -- auto_session_enabled = true, -- Enables/disables the plugin's auto save and restore features
  -- auto_session_root_dir = vim.fn.stdpath('data') .. '/sessions/', -- Changes the root dir for sessions
  auto_session_suppress_dirs = { '~/', '~/workspace' }, -- Suppress session create/restore if in one of the list of dirs
  auto_session_use_git_branch = nil, -- Use the git branch to differentiate the session name

  cwd_change_handling = {
    -- restore_upcoming_session = true, -- already the default, no need to specify like this, only here as an example
    -- pre_cwd_changed_hook = nil, -- already the default, no need to specify like this, only here as an example
    post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
      lualine.refresh() -- refresh lualine so the new session name is displayed in the status bar
    end,
  },
}

-- better experience with the plugin overall using this config for sessionoptions is recommended.
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'

telescope.load_extension('session-lens')
session_lens.setup({
  path_display = { 'shorten' },
  previewer = true,
  prompt_title = 'Sessions',
})

auto_session.setup(settings)
