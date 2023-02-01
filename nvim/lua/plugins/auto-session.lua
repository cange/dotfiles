-- local ns = "[plugins.session]"

return {
  "rmagatti/auto-session", -- small automated session manager
  dependencies = {
    "rmagatti/session-lens", -- extends auto-session through Telescope
  },
  config = function()
    -- better experience with the plugin overall using this config for sessionoptions is recommended.
    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

    require("auto-session").setup({
      log_level = "info",
      auto_restore_enabled = nil,
      auto_save_enabled = nil,
      auto_session_enable_last_session = false, -- Loads the last loaded session if session for cwd does not exist
      auto_session_enabled = true,
      auto_session_suppress_dirs = { "~/", "~/workspace" }, -- Suppress session create/restore if in one of the list of dirs
      auto_session_use_git_branch = nil, -- Use the git branch to differentiate the session name
    })
  end,
}
