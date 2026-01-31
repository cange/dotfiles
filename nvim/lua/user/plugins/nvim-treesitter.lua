local sources = {
  "bash",
  "cmake",
  "css",
  "csv",
  "comment",
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
            -- syntax highlighting, provided by Neovim
            vim.treesitter.start()
            -- folds, provided by Neovim
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.wo.foldmethod = "expr"
            -- indentation, provided by nvim-treesitter
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end,
        })
      end
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter/nvim-treesitter",
    branch = "main", -- needed for nvim-treesitter's `main` branch
    opts = {
      select = {
        -- Automatically jump forward to textobj
        lookahead = true,
      },
    },
    -- this is a sentence. without it i can't live?
    keys = function()
      local select = require("nvim-treesitter-textobjects.select").select_textobject
      local move = require("nvim-treesitter-textobjects.move")
      return {
        -- select
        { "af", function() select("@function.outer", "textobjects") end, desc = "outer func", mode = { "x", "o" } },
        { "if", function() select("@function.inner", "textobjects") end, desc = "inner func", mode = { "x", "o" } },
        { "ac", function() select("@class.outer", "textobjects") end, desc = "outer class", mode = { "o", "x" } },
        { "ic", function() select("@class.inner", "textobjects") end, desc = "inner class", mode = { "x", "o" } },
        -- move
        {
          "]f",
          function() move.goto_next_start("@function.outer", "textobjects") end,
          desc = "next outer func",
          mode = { "n", "x", "o" },
        },
        {
          "[f",
          function() move.goto_previous_start("@function.outer", "textobjects") end,
          desc = "previous outer func",
          mode = { "n", "x", "o" },
        },
      }
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
