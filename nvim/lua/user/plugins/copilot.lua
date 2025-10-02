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
    keys = {
        -- stylua: ignore start
        { "<Leader>as", "<cmd>Copilot suggestion toggle_auto_trigger<CR>", desc = "[copilot] Toggle suggestion" },
        { "<Leader>at", "<cmd>Copilot toggle<CR>",                         desc = "[copilot] Toggle" },
        { "[p", '<cmd>Copilot panel jump_prev<CR>',                        desc = "[copilot] Prev panel" },
        { "]p", '<cmd>Copilot panel jump_next<CR>',                        desc = "[copilot] Next panel" },
      -- stylua: ignore end
    },
  },
}
