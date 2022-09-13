local found, auto_session = pcall(require, 'auto-session')
if not found then return end

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

local opts = {
  log_level = 'info',
  auto_session_enable_last_session = false,
  auto_session_root_dir = vim.fn.stdpath 'data' .. '/sessions/',
  auto_session_enabled = true,
  auto_save_enabled = nil,
  auto_restore_enabled = nil,
  auto_session_suppress_dirs = { '~/', '~/workspace' },
  auto_session_use_git_branch = nil,
  -- the configs below are lua only
  -- bypass_session_save_file_types = { 'alpga' },
}

vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'

telescope.load_extension('session-lens')

session_lens.setup({
  path_display = { 'shorten' },
  previewer = true,
  prompt_title = 'Sessions',
})

auto_session.setup(opts)
