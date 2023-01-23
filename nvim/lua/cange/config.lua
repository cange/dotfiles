return {
  author = {
    display_name = "Christian",
  },
  colorscheme = "terafox",
  snippets = {
    path = "./../snippets",
  },
  lsp = {
    diagnostic_virtual_text = false,
    format_on_save = true,
    server_sources = {
      "cssls", -- css
      "eslint", -- javascript
      "jsonls", -- json
      "html", -- html
      "ruby_ls", -- ruby
      "sumneko_lua", -- lua
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
      "stylua",
      "yamllint",
      "zsh",
    },
  },
  treesitter = {
    sources = {
      "bash",
      "css",
      "dockerfile",
      "elixir",
      "gitattributes",
      "gitignore",
      "go",
      "javascript",
      "json",
      "html",
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
  },
}
