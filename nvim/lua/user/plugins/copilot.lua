-- inspired by https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/coding/copilot-chat.lua

local M = {}

---@param kind string
function M.pick(kind)
  return function()
    local actions = require("CopilotChat.actions")
    local items = actions[kind .. "_actions"]()
    if not items then return vim.notify("No '" .. kind .. "' found on the current line", vim.log.levels.WARN) end
    require("CopilotChat.integrations.telescope").pick(items)
  end
end

local function prompts()
  local context_check = "\n\t - Check for context given files #files:*.mdc"
    .. "\n\t - Confirm when context file has been found"

  return {
    Commit = "> #git:staged\n\nPlease write a conventional commit message for the change with commitizen convention."
      .. "\n\t - Keep the title under 50 characters and wrap message at 72 characters."
      .. "\n\t - Format as a gitcommit code block."
      .. "\n\t - Add additional a message only when it provides meaningful context."
      .. "\n\t - Keep any additional messages concise.",
    Tests = "> /COPILOT_GENERATE\n\nPlease explain how the selected code works, then generate unit tests for it."
      .. context_check
      .. "\n\t - Assume **Vitest** is installed and the API methods are globally available and does not need to import."
      .. "\n\t - Use all #buffers as assistant context"
      .. "\n\t - Use **Vitest** instead of Jest as test runner if not other already defined."
      .. "\n\t - Use **imperative** instead of descriptive formulation for test case descriptions. e.g. it('returns true', ...)"
      .. "\n\t - Use `beforeEach`-method to reduce redundancies, if possible.",
    Review = "Please review the following code and provide suggestions for improvement."
      .. context_check
      .. "\n\t - Ignore line length limitations",
    VueConvert = "> /COPILOT_GENERATE\n\nPlease convert the Vue.js component to composition API."
      .. "\n\t - Use `<script setup>` notation over `setup()`"
      .. "\n\t - Use TypeScript as base language`",

    -- stylua: ignore start
    -- Code related prompts
    FixCode       = "> /COPILOT_GENERATE\n\nPlease fix the following code to make it work as intended.",
    FixError      = "> /COPILOT_GENERATE\n\nPlease explain the error in the following text and provide a solution.",
    FixTypeError  = "> /COPILOT_GENERATE\n\nPlease fix the type declaration problems in my code.",
    Explain       = "> /COPILOT_GENERATE\n\nPlease explain how the following code works.",
    Refactor      = "> /COPILOT_GENERATE\n\nPlease refactor the following code to improve its clarity and readability.",
    BetterNamings = "Please provide better names for the following variables and functions.",
    Documentation = "Please provide documentation for the following code.",
    -- Text related prompts
    Concise       = "> /COPILOT_GENERATE\n\nPlease rewrite the following text to make it more concise.",
    Spelling      = "> /COPILOT_GENERATE\n\nPlease correct any grammar and spelling errors in the following text.",
    Summarize     = "> /COPILOT_GENERATE\n\nPlease summarize the following text.",
    Translate     = "> /COPILOT_GENERATE\n\nPlease translate all Chinese wording to English in this file.",
    Wording       = "> /COPILOT_GENERATE\n\nPlease improve the grammar and wording of the following text.",
    -- stylua: ignore end
  }
end

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "VeryLazy",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    cmd = "CopilotChat",
    opts = function()
      local user = (vim.env.USER or "User"):gsub("^%l", string.upper)
      local model = "claude-3.7-sonnet"
      return {
        answer_header = string.format("%s Copilot — %s", Icon.plugin.Copilot, model),
        auto_insert_mode = true,
        chat_autocomplete = true,
        context = "buffer",
        model = model,
        question_header = string.format("%s %s ", Icon.ui.Person, user),
        show_help = true,
        window = {
          width = 0.4,
        },
        selection = function(source)
          local select = require("CopilotChat.select")
          return select.visual(source) or select.buffer(source)
        end,
        prompts = prompts(),
        mappings = {
          -- Use tab for completion
          complete = {
            detail = "Use @<Tab> or /<Tab> for options.",
            insert = "<Tab>",
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
      local group = vim.api.nvim_create_augroup("copilot_chat", { clear = true })
      vim.api.nvim_create_autocmd("BufEnter", {
        group = group,
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
        end,
      })
      vim.api.nvim_create_autocmd("VimLeavePre", {
        group = group,
        desc = "Close chat before closing editor",
        command = "CopilotChatClose",
      })
    end,
  },

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
