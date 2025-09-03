local sources = {
  "bash",
  "cmake",
  "css",
  "csv",
  "diff",
  "dockerfile",
  "gitignore",
  "html",
  "java",
  "javascript",
  "jsdoc",
  "json",
  "jsonc",
  "json5",
  "kotlin",
  "lua",
  "luadoc",
  "make",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "ruby",
  "rust",
  "scss",
  "svelte",
  "slim",
  "toml",
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
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter").install(sources)
      for _, filetype in pairs(sources) do
        -- enable features by filetype
        -- https://github.com/nvim-treesitter/nvim-treesitter/tree/main?tab=readme-ov-file#supported-features
        vim.api.nvim_create_autocmd("FileType", {
          pattern = { filetype },
          callback = function()
            -- indentation
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            -- highlighting
            vim.treesitter.start()
            -- folding
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          end,
        })
      end
    end,
  },

  {
    -- contextual comment in embedded language files like Vue.JS
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    init = function()
      -- enable native commenting https://github.com/JoosepAlviste/nvim-ts-context-commentstring/wiki/Integrations#native-commenting-in-neovim-010
      local get_option = vim.filetype.get_option
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.filetype.get_option = function(filetype, option)
        return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
          or get_option(filetype, option)
      end
    end,
  },
}
