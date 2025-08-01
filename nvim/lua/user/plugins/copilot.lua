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
  return {
    Commit = "> #git:staged\n\nPlease write a conventional commit message for the change with commitizen convention."
      .. "\n\t - Keep the title under 50 characters and wrap message at 72 characters."
      .. "\n\t - Format as a gitcommit code block."
      .. "\n\t - Add additional a message only when it provides meaningful context."
      .. "\n\t - Keep any additional messages concise.",
    Tests = "> /COPILOT_GENERATE\n\nPlease explain how the selected code works, then generate unit tests for it."
      .. "\n\t - Assume **Vitest** is installed in injected via auto import (global access). So, do not import for vi API needed."
      .. "\n\t - Use **Vitest** instead of Jest as test runner if not other already defined."
      .. "\n\t - Use **imperative** instead of descriptive formulation for test case descriptions. e.g. it('returns true', ...)"
      .. "\n\t - Use `beforeEach`-method to reduce redundancies, if possible."
      .. "\n\t - Use behaviour tests of properties / keys tests. So, test the outcome not the internal API."
      .. "\n\t - Use context7",
    Review = "Please review the following code and provide suggestions for improvement."
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
        answer_header = string.format("%s Copilot — %s ", Icon.plugin.Copilot, model),
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
      { "<Leader>aca", M.pick("prompt"), desc = "copilot chat: Code Actions", mode = { "n", "v" } },
      { "<Leader>acc", "<cmd>CopilotChatToggle<CR>", desc = "copilot chat: Toggle", mode = { "n", "v" } },
      { "<Leader>acx", "<cmd>CopilotChatReset<CR>", desc = "copilot chat: Clear", mode = { "n", "v" } },
      { "<Leader>acm", "<cmd>CopilotChatModels<CR>", desc = "copilot chat: Switch Models" },
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
        { "<Leader>acR", "<cmd>Copilot panel refresh<CR>", desc = "copilot: Refresh panel" },
        { "<Leader>acp", "<cmd>Copilot panel<CR>",         desc = "copilot: Toggle panel" },
        { "<Leader>acP", "<cmd>Copilot panel accept<CR>",  desc = "copilot: Accept panel" },
        { "<Leader>acs", "<cmd>Copilot suggestion toggle_auto_trigger<CR>", desc = "copilot: Toggle suggestion" },
        { "<Leader>acS", "<cmd>Copilot status<CR>",        desc = "copilot: status" },
        { "<Leader>act", "<cmd>Copilot toggle<CR>",        desc = "copilot: Toggle" },
        { "[p", '<cmd>Copilot panel jump_prev<CR>',       desc = "copilot: Prev panel" },
        { "]p", '<cmd>Copilot panel jump_next<CR>',       desc = "copilot: Next panel" },
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
