local icons = require("user.icons")
local strUtil = require("user.utils.string")
local exclude_filetypes = {
  "",
  "NvimTree",
  "TelescopePrompt",
  "gitcommit",
  "harpoon",
  "help",
  "lazy",
  "mason",
}

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "EdenEast/nightfox.nvim",
      "folke/lazy.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = function()
      local custom_theme = require("lualine.themes.terafox")
      -- set the bg of lualine_c section to non-transparent

      return {
        options = {
          globalstatus = true,
          component_separators = { left = icons.ui.Pipe, right = icons.ui.Pipe },
          section_separators = { left = "", right = "" },
          theme = custom_theme,
        },
        sections = {
          lualine_a = {
            -- { "mode", fmt = function(str) return str:sub(1, 1) end },
          },
          lualine_b = {},
          lualine_c = {
            {
              "workspace",
              on_click = function() vim.cmd("Telescope project") end,
              suffix = " on",
              separator = "",
            },
            {
              "branch",
              icon = icons.git.Branch,
              on_click = function() vim.cmd("Telescope git_branches") end,
              padding = { left = 0, right = 1 },
              separator = icons.ui.Pipe,
            },
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error .. " ",
                warn = icons.diagnostics.Warn .. " ",
                info = icons.diagnostics.Info .. " ",
                hint = icons.diagnostics.Hint .. " ",
              },
            },
          },
          lualine_x = {
            {
              "git_blame_line",
              padding = { right = 1 },
              icon = icons.git.Commit,
              fmt = function(name)
                local w = vim.o.columns
                return strUtil.truncate(name, w > 172 and 80 or w > 112 and 48 or w > 92 and 24 or 0)
              end,
              separator = icons.ui.Pipe,
            },
            { require("lazy.status").updates, cond = require("lazy.status").has_updates },
            { "inlay_hints", exclude_filetypes = exclude_filetypes },
            { "format_clients", exclude_filetypes = exclude_filetypes, separator = "" },
            { "lsp_clients", exclude_filetypes = exclude_filetypes, padding = { left = 1, right = 2 }, separator = "" },
            -- { "copilot_status", padding = { left = 1, right = 2 }, },
            { "encoding", separator = "" },
            { "location", padding = { left = 1, right = 0 }, separator = "" },
            { "progress", padding = { left = 1, right = 0 }, separator = "" },
          },
          lualine_y = {},
          lualine_z = {},
        },
      }
    end,
  },

  { -- winbar with LSP context symbols
    "utilyre/barbecue.nvim",
    name = "barbecue",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("barbecue").setup({
        symbols = {
          modified = icons.ui.DotFill,
          separator = icons.ui.ChevronRight,
        },
        show_modified = true,
        exclude_filetypes = exclude_filetypes,
        create_autocmd = false, -- prevent barbecue from updating itself automatically
      })
      -- Gain better performance when moving the cursor around
      vim.api.nvim_create_autocmd({
        "WinResized",
        "BufWinEnter",
        "CursorHold",
        "InsertLeave",
        "BufModifiedSet", -- if `show_modified` to `true`
      }, {
        group = vim.api.nvim_create_augroup("barbecue.updater", {}),
        callback = function() require("barbecue.ui").update() end,
      })
    end,
  },
}
