local found_prettier, prettier = pcall(require, 'prettier')
if not found_prettier then return end

prettier.setup({
  bin = 'prettierd', -- pretty fast prettier version
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
})
