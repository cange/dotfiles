local icons = require("user.icons")
-- inspired by https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/coding/copilot-chat.lua

local M = {}

---@param kind string
function M.pick(kind)
  return function()
    local actions = require("CopilotChat.actions")
    local items = actions[kind .. "_actions"]()
    if not items then
      User:warn("No " .. kind .. " found on the current line", { title = "[CopilotChat]" })
      return
    end
    local ok = pcall(require, "fzf-lua")
    require("CopilotChat.integrations." .. (ok and "fzflua" or "telescope")).pick(items)
  end
end

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    cmd = "CopilotChat",
    opts = function()
      local user = vim.env.USER or "User"
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        context = "buffer", -- Default context to use, 'buffers', 'buffer' or none (can be specified manually in prompt via @).
        auto_insert_mode = true,
        show_help = true,
        question_header = string.format("%s %s ", icons.ui.Person, user),
        answer_header = string.format("%s Copilot ", icons.plugin.Copilot),
        window = {
          width = 0.4,
        },
        selection = function(source)
          local select = require("CopilotChat.select")
          return select.visual(source) or select.buffer(source)
        end,
      }
    end,
    keys = {
      { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
      { "<leader>a", "", desc = "+AI", mode = { "n", "v" } },
      { "<leader>aa", "<cmd>CopilotChatToggle<CR>", desc = "Toggle (CopilotChat)", mode = { "n", "v" } },
      { "<leader>ax", "<cmd>CopilotChatReset<CR>", desc = "Clear (CopilotChat)", mode = { "n", "v" } },
      {
        "<leader>aq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then require("CopilotChat").ask(input) end
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },
      -- Show help actions with telescope
      { "<leader>ah", M.pick("help"), desc = "Diagnostic Help (CopilotChat)", mode = { "n", "v" } },
      -- Show prompts actions with telescope
      { "<leader>ap", M.pick("prompt"), desc = "Prompt Actions (CopilotChat)", mode = { "n", "v" } },
    },
    config = function(_, opts)
      require("CopilotChat.integrations.cmp").setup()

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })

      require("CopilotChat").setup(opts)
    end,
  },

  { -- AI code suggestions
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      panel = { enabled = false, auto_refresh = true },
      suggestion = { enabled = false, auto_refresh = true },
    },
    keys = function()
      -- stylua: ignore start
      return {
        { "<localleader>cA", "<cmd>Copilot panel accept<CR>",  desc = "Accept Copilot panel" },
        { "<localleader>cR", "<cmd>Copilot panel refresh<CR>", desc = "Refresh Copilot panel" },
        { "<localleader>cS", "<cmd>Copilot status<CR>",        desc = "Copilot status" },
        { "<localleader>co", "<cmd>Copilot toggle<CR>",        desc = "Toggle Copilot" },
        { "<localleader>cp", "<cmd>Copilot panel<CR>",         desc = "Toggle Copilot panel" },
        { "<localleader>cs", "<cmd>Copilot suggestion<CR>",    desc = "Toggle Copilot suggestion" },
        { "[c", '<cmd>Copilot suggestion prev<CR>',            desc = "Prev Copilot suggestion" },
        { "[p", '<cmd>Copilot panel jump_prev<CR>',            desc = "Prev Copilot panel" },
        { "]c", '<cmd>Copilot suggestion next<CR>',            desc = "Next Copilot suggestion" },
        { "]p", '<cmd>Copilot panel jump_next<CR>',            desc = "Next Copilot panel" },
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
