---@class cange.configGroup[]
local M = {}

M.ui = {
  colorscheme = "terafox",
  border = "rounded", -- nvim_open_win: none, single, double, rounded, shadow
}

M.snippets = {
  path = "./../snippets",
}

M.lsp = {
  diagnostic_virtual_text = false,
  format_on_save = true,
  server_sources = {
    "bashls", -- bash
    "cssls", -- css
    "html", -- html
    "jsonls", -- json
    "ruby_ls", -- ruby
    "svelte", -- svelte
    "tsserver", -- javascript, typescript, etc.
    "volar", --vue 3 and 2
    "yamlls", -- yaml
  },
  null_ls_sources = {
    -- Language servers
    "css-lsp",
    "dockerfile-language-server",
    "eslint-lsp",
    "html-lsp",
    "json-lsp",
    "lua-language-server",
    "stylelint-lsp",
    "svelte-language-server",
    "typescript-language-server",
    "vue-language-server",
    "yaml-language-server",

    -- Linting and formatting
    "eslint_d",
    "jsonlint",
    "prettierd",
    "rubocop",
    "shfmt", -- shell formatting
    "stylua",
    "yamllint",
    "zsh",
  },
}
M.treesitter = {
  sources = {
    "bash",
    "css",
    "dockerfile",
    "elixir",
    "gitattributes",
    "gitignore",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "python",
    "regex",
    "ruby",
    "rust",
    "scss",
    "svelte",
    "tsx",
    "typescript",
    "vue",
    "yaml",
  },
}

return M
