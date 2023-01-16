return {
  ---@type table<string, string>
  author = {
    ---@type string # Name to personalise editor session
    display_name = "Christian",
  },
  ---@type string # Variant name of nightfox theme
  colorscheme = "terafox",
  ---@type table<string, string> # Snippets relative path to nvim root directory
  snippets = {
    ---@type string
    path = "./../snippets",
  },
  lsp = {
    ---@type boolean # Boolean to show or hide inline hint text
    diagnostic_virtual_text = true,
    ---@type boolean # Boolean to toggle on/off auto formatting on save
    format_on_save = true,
    ---@type table<string[]> # List of LSP servers
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
    ---@type table<string[]> # List of supported formatter, diagnostics servers
    null_ls_sources = {
      "eslint_d",
      "jsonlint",
      "prettierd",
      "rubocop",
      "stylua",
      "yamllint",
      "zsh",
    },
  },
  ---@type table<string, any>
  treesitter = {
    ---@type table<string[]> # List of supported language parser
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
