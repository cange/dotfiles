local i = Cange.get_icon
local strUtil = require("cange.utils.string")
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
      custom_theme.normal.c.bg = Cange.get_hl_hex("NormalFloat", "bg").bg

      return {
        options = {
          component_separators = { left = " ", right = " " },
          globalstatus = true,
          section_separators = { left = "", right = "" },
          theme = custom_theme,
        },
        sections = {
          lualine_a = {
            { "mode", fmt = function(str) return str:sub(1, 1) end },
          },
          lualine_b = {
            { "branch", icon = i("git.Branch") },
          },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = i("diagnostics.Error", { right = 1 }),
                warn = i("diagnostics.Warn", { right = 1 }),
                info = i("diagnostics.Info", { right = 1 }),
                hint = i("diagnostics.Hint", { right = 1 }),
              },
            },
          },
          lualine_x = {
            {
              "git_blame_line",
              padding = { right = 1 },
              icon = i("git.Commit"),
              fmt = function(name)
                local w = vim.o.columns
                return strUtil.truncate(name, w > 172 and 80 or w > 112 and 48 or w > 92 and 24 or 0)
              end,
            },
            { require("lazy.status").updates, cond = require("lazy.status").has_updates },
          },
          lualine_y = {
            { "inlay_hints", exclude_filetypes = exclude_filetypes },
            { "format_clients", exclude_filetypes = exclude_filetypes },
            { "lsp_clients", exclude_filetypes = exclude_filetypes },
            "copilot_status",
            {
              "progress",
              separator = "",
              padding = { left = 1, right = 0 },
            },
            {
              "location",
              separator = "",
              padding = { left = 1, right = 0 },
            },
            {
              function() return i("ui.Tab", { right = 1 }) .. vim.api.nvim_get_option_value("shiftwidth", { buf = 0 }) end,
              separator = "",
              padding = { left = 1, right = 0 },
            },
            "encoding",
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
          modified = i("ui.DotFill"),
          separator = i("ui.ChevronRight"),
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
