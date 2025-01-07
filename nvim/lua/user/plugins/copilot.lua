-- inspired by https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/coding/copilot-chat.lua

local M = {}

---@param kind string
function M.pick(kind)
  return function()
    local actions = require("CopilotChat.actions")
    local items = actions[kind .. "_actions"]()
    if not items then error("No '" .. kind .. "' found on the current line") end
    require("CopilotChat.integrations.telescope").pick(items)
  end
end

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
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
        chat_autocomplete = true, -- Enable chat autocompletion (when disabled, requires manual `mappings.complete` trigger)
        show_help = true,
        question_header = string.format("%s %s ", Icon.ui.Person, user),
        answer_header = string.format("%s Copilot ", Icon.plugin.Copilot),
        window = {
          width = 0.4,
        },
        selection = function(source)
          local select = require("CopilotChat.select")
          return select.visual(source) or select.buffer(source)
        end,
        prompts = {
          FixTypeErrors = {
            prompt = "> /COPILOT_GENERATE\n\nThere are type declaration problems in my code."
              .. "\n\t - Rewrite the code to show it with the bug fixed."
              .. "\n\t - Use all #files as assistant context"
              .. "\n\t - Explain the made changes",
          },
          Tests = {
            prompt = "> /COPILOT_GENERATE\n\nPlease generate tests for my code."
              .. "\n\t - Assume **Vitest** it is installed and the API methods are globally available and does not need to import."
              .. "\n\t - Use all #files as assistant context"
              .. "\n\t - Use **Vitest** instead of Jest as test runner."
              .. "\n\t - Use **imperative** instead of descriptive formulation for test case descriptions. e.g. it('returns true', ...)"
              .. "\n\t - Use `beforeEach`-method to reduce redundancies, if possible.",
          },
        },
      }
    end,
    keys = {
      -- stylua: ignore start
      { "<leader>aa", M.pick("prompt"), desc = "Code Actions (CopilotChat)", mode = { "n", "v" } },
      { "<leader>ac", "<cmd>CopilotChatToggle<CR>", desc = "Toggle (CopilotChat)", mode = { "n", "v" } },
      { "<leader>ah", M.pick("help"), desc = "Diagnostic Help (CopilotChat)", mode = { "n", "v" } },
      { "<leader>ao", "<cmd>CopilotChatOptimize<CR>", desc = "Optimise (CopilotChat)", mode = { "n", "v" } },
      { "<leader>at", "<cmd>CopilotChatTests<CR>", desc = "Tests (CopilotChat)", mode = { "n", "v" } },
      { "<leader>ax", "<cmd>CopilotChatReset<CR>", desc = "Clear (CopilotChat)", mode = { "n", "v" } },
      { "<leader>aX", "<cmd>CopilotChatExplain<CR>", desc = "Explain (CopilotChat)", mode = { "n", "v" } },
      {
        "<leader>aq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then require("CopilotChat").ask(input) end
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },
      -- stylua: ignore end
    },
    init = function()
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })
      -- prevents error: .../CopilotChat/ui/overlay ... already exists
      vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
        group = vim.api.nvim_create_augroup("close_chat_before_closing", { clear = true }),
        desc = "Close chat before closing editor",
        command = "CopilotChatClose",
      })
    end,
  },

  { -- AI code suggestions
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      suggestion = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          accept = "<C-CR>",
          next = "<C-.>", -- Ctrl + >
          prev = "<C-,>", -- Ctrl + <
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
        { "<leader>aR", "<cmd>Copilot panel refresh<CR>", desc = "Refresh panel (Copilot)" },
        { "<leader>ap", "<cmd>Copilot panel<CR>",         desc = "Toggle panel (Copilot)" },
        { "<leader>aP", "<cmd>Copilot panel accept<CR>",  desc = "Accept panel (Copilot)" },
        { "<leader>as", "<cmd>Copilot suggestion toggle_auto_trigger<CR>", desc = "Toggle suggestion (Copilot)" },
        { "<leader>aS", "<cmd>Copilot status<CR>",        desc = "Copilot status" },
        { "<leader>at", "<cmd>Copilot toggle<CR>",        desc = "Toggle (Copilot)" },
        { "[p", '<cmd>Copilot panel jump_prev<CR>',       desc = "Prev panel (Copilot)" },
        { "]p", '<cmd>Copilot panel jump_next<CR>',       desc = "Next panel (Copilot)" },
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
