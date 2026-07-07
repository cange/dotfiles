local sources = {
  "bash",
  "cmake",
  "comment",
  "css",
  "csv",
  "diff",
  "dockerfile",
  "ecma", -- JS/TS support
  "gitignore",
  "html",
  "html_tags",
  "java",
  "javascript",
  "jsdoc",
  "json",
  "json5",
  "jsx", -- JS support
  "kotlin",
  "lua",
  "luadoc",
  "make",
  "markdown",
  "markdown_inline",
  "mermaid",
  "nginx",
  "python",
  "query",
  "regex",
  "ruby",
  "rust",
  "scss",
  "svelte",
  "toml",
  "tsv", -- CSV support
  "tsx",
  "typescript",
  "vimdoc",
  "vue",
  "xml",
  "yaml",
  "zig",
}

return {
  {
    "neovim-treesitter/nvim-treesitter",
    dependencies = { "neovim-treesitter/treesitter-parser-registry" },
    lazy = false,
    build = ":TSUpdate",
    event = { "FileType", "BufEnter", "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter").install(sources)
      -- see https://github.com/nvim-treesitter/nvim-treesitter/tree/main?tab=readme-ov-file#supported-features
      vim.api.nvim_create_autocmd("FileType", {
        pattern = sources,
        callback = function()
          -- enable Neovim's syntax highlighting
          vim.treesitter.start()
          -- enable Neovim's treesitter-based folding
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo.foldmethod = "indent" -- foldmethod = "expr" hides full folded block + does not work in eruby
          -- enable plugin's treesitter-based indentation
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
