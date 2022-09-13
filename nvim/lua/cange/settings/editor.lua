--- Provides general settings
local M = {}

--- Lists of providers for certain language_server, linter, and formatter
-- @table lsp
M.lsp = {
  -- Contains table of language servers
  -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
  providers = {
    language_servers = {
      -- 'solargraph', -- ruby
      'emmet_ls', -- html
      'bashls', -- bash
      'cssls', -- css
      'cssmodules_ls', -- css
      'tailwindcss', -- css
      'cucumber_language_server', -- cucumber, ruby
      'dockerls', -- docker
      'eslint', -- javascript
      'html', -- html
      'tsserver', -- javascript, typepscript, etc.
      'jsonls', -- json
      'sumneko_lua', -- lua
      'marksman', -- markdown
      'stylelint_lsp', -- stylelint
      'svelte', -- svelte
      'vimls', -- vim
      'vuels', -- vue
      'volar', --vue 3
      'yamlls', -- yaml
    },
    linters = {
      'eslint_d', -- javascript
      'shfmt', -- shell
      'prettier', -- javascript, typepscript, etc
      'luaformatter', -- lua
      -- 'rubocop', --ruby
      'yamlfmt', -- yaml
    },
    formatters = {
      'stylua', -- lua
      'markdownlint', -- markdown
      'yamllint', -- yaml
    },
  },
  meta = {
    subleader = 'l',
  },
  mappings = {
    I = { command = '<cmd>LspInstallInfo<CR>',                          label = 'Installer Info' },
    S = { command = '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>', label = 'Workspace Symbols' },
    a = { command = '<cmd>lua vim.lsp.buf.code_action()<CR>',           label = 'Code Action' },
    d = { command = '<cmd>Telescope lsp_document_diagnostics<CR>',      label = 'Document Diagnostics' },
    f = { command = '<cmd>lua vim.lsp.buf.formatting()<CR>',            label = 'Format' },
    i = { command = '<cmd>LspInfo<CR>',                                 label = 'Info' },
    j = { command = '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',      label = 'Next Diagnostic' },
    k = { command = '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',      label = 'Prev Diagnostic' },
    l = { command = '<cmd>lua vim.lsp.codelens.run()<CR>',              label = 'CodeLens Action' },
    m = { command = '<cmd>Mason<CR>',                                   label = 'Update LSP services' },
    q = { command = '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>',    label = 'Quickfix' },
    r = { command = '<cmd>lua vim.lsp.buf.rename()<CR>',                label = 'Rename' },
    s = { command = '<cmd>Telescope lsp_document_symbols<CR>',          label = 'Document Symbols' },
    w = { command = '<cmd>Telescope lsp_workspace_diagnostics<CR>',     label = 'Workspace Diagnostics' },
  },
}

--- List of Treesitters support parsers
-- @table treesitter
M.treesitter = {
  parsers = { ---- A list of parser names, or "all"
    'bash',
    'cmake',
    'css',
    'dart',
    'dockerfile',
    'elixir',
    'erlang',
    'gitattributes',
    'gitignore',
    'go',
    'graphql',
    'html',
    'http',
    'java',
    'javascript',
    'jsdoc',
    'json',
    'json5',
    'jsonc',
    'lua',
    'make',
    'markdown',
    'markdown_inline',
    'pug',
    'python',
    'query',
    'regex',
    'ruby',
    'scss',
    'sql',
    'svelte',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'vue',
    'yaml',
  },
}

--- Settings for prettier formatter
-- @table prettier
M.prettier = {
  filetypes = {
    'css',
    'graphql',
    'html',
    'javascript',
    'javascriptreact',
    'json',
    'less',
    'markdown',
    'scss',
    'typescript',
    'typescriptreact',
    'vue',
    'yaml',
  },
}

---Mappings tries to organise global used keybindings on one place
--- Pattern: <block_key> = { { <key> = { command = '...', label = '...' } } }
--- @table mappings
M.telescope = {
  meta = {
    subleader = 'f',
  },
  mappings = {
    C = { command = '<cmd>Telescope commands<CR>',    label = 'Commands' },
    F = { command = '<cmd>Telescope live_grep<CR>',   label = 'Find text' },
    M = { command = '<cmd>Telescope man_pages<CR>',   label = 'Man pages' },
    P = { command = '<cmd>Telescope projects<CR>',    label = 'Open projects' },
    c = { command = '<cmd>Telescope colorscheme<CR>', label = 'Change colorscheme' },
    h = { command = '<cmd>Telescope help_tags<CR>',   label = 'Find help' },
    k = { command = '<cmd>Telescope keymaps<CR>',     label = 'Keymaps' },
    p = { command = '<cmd>Telescope find_files<CR>',  label = 'Find files' },
  },
}
M.git = {
  meta = {
    subleader = 'g',
  },
  mappings = {
    l = { command = '<cmd>Gitsigns toggle_current_line_blame<CR>',        label = 'Line blame' },
    R = { command = '<cmd>Gitsigns reset_buffer<CR>',                     label = 'Reset buffer' },
    b = { command = '<cmd>Telescope git_branches<CR>',                    label = 'Checkout branch' },
    c = { command = '<cmd>Telescope git_commits<CR>',                     label = 'Checkout commit' },
    d = { command = '<cmd>Gitsigns diffthis HEAD<CR>',                    label = 'Diff' },
    g = { command = '<cmd>lua _LAZYGIT_TOGGLE()<CR>',                     label = 'Lazygit' },
    o = { command = '<cmd>Telescope git_status<CR>',                      label = 'Open changed file' },
    j = { command = '<cmd>lua require("gitsigns").next_hunk()<CR>',       label = 'Next hunk' },
    k = { command = '<cmd>lua require("gitsigns").prev_hunk()<CR>',       label = 'Prev hunk' },
    p = { command = '<cmd>lua require("gitsigns").preview_hunk()<CR>',    label = 'Preview hunk' },
    r = { command = '<cmd>lua require("gitsigns").reset_hunk()<CR>',      label = 'Reset hunk' },
    s = { command = '<cmd>lua require("gitsigns").stage_hunk()<CR>',      label = 'Stage hunk' },
    u = { command = '<cmd>lua require("gitsigns").undo_stage_hunk()<CR>', label = 'Undo stage hunk' },
  },
}
M.packer = {
  meta = {
    subleader = 'p',
  },
  mappings = {
    S = { command = '<cmd>PackerStatus<CR>',  label = 'Status' },
    c = { command = '<cmd>PackerCompile<CR>', label = 'Compile' },
    i = { command = '<cmd>PackerInstall<CR>', label = 'Install' },
    s = { command = '<cmd>PackerSync<CR>',    label = 'Sync' },
    u = { command = '<cmd>PackerUpdate<CR>',  label = 'Update' },
  },
}
M.session = {
  meta = {
    subleader = 's',
  },
  mappings = {
    R = { command = '<cmd>RestoreSession<CR>',      label = 'Recent session' },
    d = { command = '<cmd>Autosession delete<CR>',  label = 'Find delete session' },
    f = { command = '<cmd>SearchSession<CR>',       label = 'Find session' },
    r = { command = '<cmd>Telescope oldfiles<CR>',  label = 'Recent files' },
    s = { command = '<cmd>SaveSession<CR>',         label = 'Save session' },
    x = { command = '<cmd>DeleteSession<CR>',       label = 'Delete session' },
  },
}

---Defines global keybindings by certain worklows like Git
local function keymaps_setup()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  for _, workflow_settings in pairs(M) do
    if not vim.tbl_contains(vim.tbl_keys(workflow_settings), 'mappings') then
      return
    end
    for key, mapping in pairs(workflow_settings.mappings) do
      local leader = workflow_settings.meta and workflow_settings.meta.leader or ''
      local subleader = workflow_settings.meta and workflow_settings.meta.subleader or ''

      keymap('n', '<leader>' .. subleader .. key, mapping.command, opts)
    end
  end
end

M.keymaps = {
  setup = keymaps_setup,
}
return M
