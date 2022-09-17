--- Provides general settings
local M = {}

---Mappings tries to organise global used keybindings on one place
--- Pattern: <block_key> = { { <key> = { command = '...', label = '...' } } }
--- @table mappings

--- Language related syntax analytics
M.mappings = {
  language = {
    leader = 'l',
    mappings = {
      I = { command = '<cmd>LspInstallInfo<CR>',                                label = 'Installer Info' },
      S = { command = '<cmd>Telescope local sp_dynamic_workspace_symbols<CR>',  label = 'Workspace Symbols' },
      a = { command = '<cmd>lua vim.lsp.buf.code_action()<CR>',                 label = 'Code Action' },
      d = { command = '<cmd>Telescope lsp_document_diagnostics<CR>',            label = 'Document Diagnostics' },
      f = { command = '<cmd>lua vim.lsp.buf.formatting()<CR>',                  label = 'Format' },
      i = { command = '<cmd>LspInfo<CR>',                                       label = 'Info' },
      j = { command = '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',            label = 'Next Diagnostic' },
      k = { command = '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',            label = 'Prev Diagnostic' },
      l = { command = '<cmd>lua vim.lsp.codelens.run()<CR>',                    label = 'CodeLens Action' },
      m = { command = '<cmd>Mason<CR>',                                         label = 'Update LSP services' },
      q = { command = '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>',          label = 'Quickfix' },
      r = { command = '<cmd>lua vim.lsp.buf.rename()<CR>',                      label = 'Rename' },
      s = { command = '<cmd>Telescope lsp_document_symbols<CR>',                label = 'Document Symbols' },
      w = { command = '<cmd>Telescope lsp_workspace_diagnostics<CR>',           label = 'Workspace Diagnostics' },
    },
  },

  ---Finding stuff
  search = {
    leader = 'f',
    mappings = {
      C = { command = '<cmd>Telescope commands<CR>',    label = 'Commands' },
      F = { command = '<cmd>Telescope live_grep<CR>',   label = 'Find text' },
      M = { command = '<cmd>Telescope man_pages<CR>',   label = 'Man pages' },
      c = { command = '<cmd>Telescope colorscheme<CR>', label = 'Change colorscheme' },
      f = { command = '<cmd>Telescope find_files<CR>',  label = 'Find files' },
      h = { command = '<cmd>Telescope help_tags<CR>',   label = 'Find help' },
      k = { command = '<cmd>Telescope keymaps<CR>',     label = 'Keymaps' },
      p = { command = '<cmd>Telescope projects<CR>',    label = 'Open projects' },
    },
  },

  git = {
    leader = 'g',
    mappings = {
      l = { command = '<cmd>Gitsigns toggle_current_line_blame<CR>',        label = 'Line blame' },
      R = { command = '<cmd>Gitsigns reset_buffer<CR>',                     label = 'Reset buffer' },
      B = { command = '<cmd>Telescope git_branches<CR>',                    label = 'Checkout branch' },
      C = { command = '<cmd>Telescope git_commits<CR>',                     label = 'Checkout commit' },
      d = { command = '<cmd>Gitsigns diffthis HEAD<CR>',                    label = 'Diff' },
      -- t = { command = '<cmd>lua _LAZYGIT_TOGGLE()<CR>',                     label = 'Lazygit' },
      o = { command = '<cmd>Telescope git_status<CR>',                      label = 'Open changed file' },
      j = { command = '<cmd>lua require("gitsigns").next_hunk()<CR>',       label = 'Next hunk' },
      k = { command = '<cmd>lua require("gitsigns").prev_hunk()<CR>',       label = 'Prev hunk' },
      p = { command = '<cmd>lua require("gitsigns").preview_hunk()<CR>',    label = 'Preview hunk' },
      r = { command = '<cmd>lua require("gitsigns").reset_hunk()<CR>',      label = 'Reset hunk' },
      s = { command = '<cmd>lua require("gitsigns").stage_hunk()<CR>',      label = 'Stage hunk' },
      u = { command = '<cmd>lua require("gitsigns").undo_stage_hunk()<CR>', label = 'Undo stage hunk' },
    },
  },

  ---Install, update neovims plugins
  packer = {
    leader = 'p',
    mappings = {
      S = { command = '<cmd>PackerStatus<CR>',                            label = 'Status' },
      c = { command = '<cmd>PackerCompile<CR>',                           label = 'Compile' },
      i = { command = '<cmd>PackerInstall<CR>',                           label = 'Install' },
      s = { command = '<cmd>PackerSync<CR>',                              label = 'Sync' },
      u = { command = '<cmd>PackerUpdate<CR>',                            label = 'Update' },
      C = { command = '<cmd>e ~/.config/nvim/lua/cange/plugins.lua<CR>',  label = 'Config' },
    },
  },
  session = {
    leader = 's',
    mappings = {
      R = { command = '<cmd>RestoreSession<CR>',      label = 'Recent session' },
      d = { command = '<cmd>Autosession delete<CR>',  label = 'Find delete session' },
      f = { command = '<cmd>SearchSession<CR>',       label = 'Find session' },
      r = { command = '<cmd>Telescope oldfiles<CR>',  label = 'Recent files' },
      s = { command = '<cmd>SaveSession<CR>',         label = 'Save session' },
      x = { command = '<cmd>DeleteSession<CR>',       label = 'Delete session' },
    },
  },
  -- terminal = {
  --   leader = 't',
  --   mappings = {
  --     n = { command = '<cmd>lua _NODE_TOGGLE()<CR>',                      label = 'Node' },
  --     u = { command = '<cmd>lua _NCDU_TOGGLE()<CR>',                      label = 'NCDU' },
  --     t = { command = '<cmd>lua _HTOP_TOGGLE()<CR>',                      label = 'Htop' },
  --     p = { command = '<cmd>lua _PYTHON_TOGGLE()<CR>',                    label = 'Python' },
  --     f = { command = '<cmd>ToggleTerm direction=float<CR>',              label = 'Float' },
  --     h = { command = '<cmd>ToggleTerm size=10 direction=horizontal<CR>', label = 'Horizontal' },
  --     v = { command = '<cmd>ToggleTerm size=80 direction=vertical<CR>',   label = 'Vertical' },
  --   },
  -- },
}

---Defines global keybindings by certain worklows like Git
M.setup = function(opts)
  local opts = vim.tbl_extend('force', opts or {}, { noremap = true, silent = true })

  for _, workflow in pairs(M.mappings) do
    if not vim.tbl_contains(vim.tbl_keys(workflow), 'mappings') then
      return
    end
    local leader = workflow.leader or ''
    for key, mapping in pairs(workflow.mappings) do
      leader = mapping.leader or leader

      vim.keymap.set('n', leader .. key, mapping.command, opts)
    end
  end
end

return M
