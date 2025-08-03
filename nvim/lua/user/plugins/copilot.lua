return {
  { -- AI code suggestions
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      suggestion = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          accept = "<C-CR>",
          next = "<C-.>", -- Ctrl + .
          prev = "<C-,>", -- Ctrl + ,
          dismiss = "<C-c>",
        },
      },
    },
    init = function()
      local ok, cmp = pcall(require, "cmp")
      if ok then
        -- hide copilot suggestions when cmp menu is open
        cmp.event:on("menu_opened", function() vim.b.copilot_suggestion_hidden = true end)
        cmp.event:on("menu_closed", function() vim.b.copilot_suggestion_hidden = false end)
      end
    end,
    keys = function()
      -- stylua: ignore start
      return {
        { "<Leader>aR", "<cmd>Copilot panel refresh<CR>", desc = "Refresh panel [copilot]" },
        { "<Leader>ap", "<cmd>Copilot panel<CR>",         desc = "Toggle panel [copilot]" },
        { "<Leader>aP", "<cmd>Copilot panel accept<CR>",  desc = "Accept panel [copilot]" },
        { "<Leader>as", "<cmd>Copilot suggestion toggle_auto_trigger<CR>", desc = "Toggle suggestion [copilot]" },
        { "<Leader>aS", "<cmd>Copilot status<CR>",        desc = "status [copilot]" },
        { "<Leader>at", "<cmd>Copilot toggle<CR>",        desc = "Toggle [copilot]" },
        { "[p", '<cmd>Copilot panel jump_prev<CR>',       desc = "Prev panel [copilot]" },
        { "]p", '<cmd>Copilot panel jump_next<CR>',       desc = "Next panel [copilot]" },
      }
      -- stylua: ignore end
    end,
  },

  { -- improved chat window layout
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        ft = "copilot-chat",
        title = "Copilot Chat",
        size = { width = 50 },
      })
    end,
  },
}
