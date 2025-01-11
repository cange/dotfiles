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
    dependencies = {
      "EdenEast/nightfox.nvim",
      "folke/lazy.nvim",
      "nvim-tree/nvim-web-devicons",
      "AndreM222/copilot-lualine",
    },
    opts = function()
      local custom_theme = require("lualine.themes.terafox")
      -- set the bg of lualine_c section to non-transparent

      return {
        options = {
          globalstatus = true,
          component_separators = { left = Icon.ui.Pipe, right = Icon.ui.Pipe },
          section_separators = { left = "", right = "" },
          theme = custom_theme,
          disabled_filetypes = exclude_filetypes,
        },
        sections = {
          lualine_a = {
            { "mode", fmt = function(str) return str:sub(1, 1) end },
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
              icon = Icon.git.Branch,
              on_click = function() vim.cmd("Telescope git_branches") end,
              padding = { left = 0, right = 1 },
              separator = Icon.ui.Pipe,
            },
            {
              "diagnostics",
              symbols = {
                error = Icon.diagnostics.Error .. " ",
                warn = Icon.diagnostics.Warn .. " ",
                info = Icon.diagnostics.Info .. " ",
                hint = Icon.diagnostics.Hint .. " ",
              },
            },
          },
          lualine_x = {
            {
              "git_blame_line",
              padding = { right = 1 },
              icon = Icon.git.Commit,
              fmt = function(name)
                local w = vim.o.columns
                return strUtil.truncate(name, w > 172 and 80 or w > 112 and 48 or w > 92 and 24 or 0)
              end,
              separator = Icon.ui.Pipe,
            },
            { require("lazy.status").updates, cond = require("lazy.status").has_updates },
            { "inlay_hints" },
          },
          lualine_y = {
            { "format_clients", separator = "" },
            { "lsp_clients", padding = { left = 1, right = 2 }, separator = "" },
            {
              "copilot",
              separator = "",
              padding = { left = 0, right = 0 },
              symbols = { spinners = vim.split(Icon.sets.spinner, " ") },
            },
            { "encoding", separator = "" },
            { "location", padding = { left = 0, right = 0 }, separator = "" },
            { "progress", padding = { left = 1, right = 0 }, separator = "" },
          },
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
          modified = Icon.ui.DotFill,
          separator = Icon.ui.ChevronRight,
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
