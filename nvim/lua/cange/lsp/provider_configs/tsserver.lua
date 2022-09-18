return {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'javascript.jsx',
    'javascriptreact',
    'typescript',
    'typescript.tsx',
    'typescriptreact',
  },
  init_options = {
    hostInfo = 'neovim',
  },
}
