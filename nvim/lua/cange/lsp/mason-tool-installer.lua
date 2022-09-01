local ok, mti = pcall(require, "mason-tool-installer")
if not ok then return end

mti.setup {
  -- a list of all tools you want to ensure are installed upon
  -- start; they should be the names Mason uses for each tool
  ensure_installed = {
    -- you can turn off/on auto_update per tool
    -- { 'bash-language-server', auto_update = true },

    -- lsp
    'css-lsp',
    'eslint-lsp',
    'html-lsp',
    'json-lsp',

    -- lint
    'eslint_d',
    'markdownlint',
    'shellcheck',
    'yamllint',

    -- formatter
    'prettier',
    'xmlformatter',

    -- server
    'cssmodules-language-server',
    'lua-language-server',
    'svelte-language-server',
    'tailwindcss-language-server',
    'typescript-language-server',
    'vim-language-server',
    'vue-language-server',
    'yaml-language-server',
  },

  -- if set to true this will check each tool for updates. If updates
  -- are available the tool will be updated. This setting does not
  -- affect :MasonToolsUpdate or :MasonToolsInstall.
  -- Default: false
  auto_update = false,

  -- automatically install / update on startup. If set to false nothing
  -- will happen on startup. You can use :MasonToolsInstall or
  -- :MasonToolsUpdate to install tools and check for updates.
  -- Default: true
  run_on_start = true,

  -- set a delay (in ms) before the installation starts. This is only
  -- effective if run_on_start is set to true.
  -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
  -- Default: 0
  start_delay = 3000, -- 3 second delay
}
