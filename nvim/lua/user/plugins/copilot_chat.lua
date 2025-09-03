local function prompts()
  return {
    Commit = {
      sticky = "#gitdiff:staged",
      prompt = "Write commit message for the change with commitizen convention"
        .. "\n\t - Keep the title under 50 characters and wrap message at 72 characters."
        .. "\n\t - Format as a gitcommit code block."
        .. "\n\t - Add additional a message only when it provides meaningful context."
        .. "\n\t - Keep any additional messages concise.",
    },
    Tests = {
      sticky = "buffer",
      prompt = "Please explain how the selected code works, then generate unit tests for it."
        .. "\n\t - When selected code is JavaScript or TypeScript"
        .. "\n\t\t - use /vitest-dev/vitest"
        .. "\n\t\t - Use **Vitest** instead of Jest as test runner if not other already defined."
        .. "\n\t\t - Assume **Vitest** is installed in injected via auto import (global access). So, do not import for vi API needed."
        .. "\n\t - Use **imperative** instead of descriptive formulation for test case descriptions. e.g. it('returns true', ...)"
        .. "\n\t - Use `beforeEach`-method to reduce redundancies, if possible."
        .. "\n\t - Use behaviour tests of properties / keys tests. So, test the outcome not the internal API."
        .. "\n\t - When selected code is a Vue component then:"
        .. "\n\t\t - use /vuejs/docs"
        .. "\n\t\t - use /vuejs/devtools"
        .. "\n\t - When selected code is a pinia store then:"
        .. "\n\t\t - use /vuejs/pinia"
        .. "\n\t\t - use 'actions', 'getters' and 'state' describe blocks to separate these types from each other",
    },
    Review = {
      sticky = "buffer",
      prompt = "Please review the following code and provide suggestions for improvement."
        .. "\n\t - Ignore line length limitations",
      system_prompt = "COPILOT_REVIEW",
    },
    VueConvert = {
      sticky = "buffer",
      prompt = "Please convert the Vue.js component to composition API."
        .. "\n\t - Use `<script setup>` notation over `setup()`"
        .. "\n\t - Use TypeScript as base language"
        .. "\n\t - Use the order: script, template, style blocks to structure a component"
        .. "\n\t - Convert all non-english comments into English language"
        .. "\n\t - fetch @context7_resolve_library_id /vuejs/docs use /vuejs/docs",
    },

    -- Code related prompts
    FixCode = { prompt = "Please fix the following code to make it work as intended." },
    FixError = { prompt = "Please explain the error in the following text and provide a solution." },
    FixTypeError = { prompt = "Please fix the type declaration problems in my code." },
    Explain = { prompt = "Please explain how the following code works." },
    Refactor = {
      system_prompt = "COPILOT_REVIEW",
      prompt = "Please refactor the following code to improve its clarity and readability.",
    },
    BetterNamings = {
      system_prompt = "COPILOT_REVIEW",
      prompt = "Please provide better names for the following variables and functions.",
    },
    Documentation = { prompt = "Please provide documentation for the following code." },
    -- Text related prompts
    Concise = { prompt = "Please rewrite the following text to make it more concise." },
    Spelling = { prompt = "Please correct any grammar and spelling errors in the following text." },
    Summarize = { prompt = "Please summarize the following text." },
    Translate = { prompt = "Please translate all Chinese wording to English in this file." },
    Wording = { prompt = "Please improve the grammar and wording of the following text." },
  }
end
local user = (vim.env.USER or "User"):gsub("^%l", string.upper)
local model = "claude-sonnet-4"
-- local model = "gpt-4.1"

return {
  {
    -- version = "v3.12.2",
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "VeryLazy",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    cmd = "CopilotChat",
    opts = {
      -- input
      model = model,
      sticky = "buffer",
      prompts = prompts(),
      -- behaviour
      auto_insert_mode = true, -- Enter insert mode when opening
      chat_autocomplete = true,
      show_help = true,
      -- ui
      window = {
        width = 0.4, -- 50% of screen width
        title = Icon.plugin.Copilot .. " AI Assistant",
      },
      headers = {
        user = ("%s %s: "):format(Icon.ui.Person, user),
        assistant = ("%s Copilot — %s "):format(Icon.plugin.Copilot, model),
      },
    },
    keys = {
      { "<Leader>ac", "<cmd>CopilotChatToggle<CR>", desc = "Toggle [copilot chat]", mode = { "n", "v" } },
      { "<Leader>af", "<cmd>CopilotChatFix<cr>", desc = "Fix Diagnostic [copilot chat]", mode = { "n", "v" } },
      { "<Leader>am", "<cmd>CopilotChatModels<CR>", desc = "Switch Models [copilot chat]" },
      { "<Leader>ap", "<cmd>CopilotChatPrompts<CR>", desc = "Prompt [copilot chat]", mode = { "n", "v" } },
      { "<Leader>ah", "<cmd>CopilotChatStop<CR>", desc = "Stop [copilot chat]", mode = { "n", "v" } },
      { "<Leader>ax", "<cmd>CopilotChatReset<CR>", desc = "Clear [copilot chat]", mode = { "n", "v" } },
    },
    config = function(_, opts)
      local select = require("CopilotChat.select")
      require("CopilotChat").setup(vim.tbl_extend("force", opts, {
        -- Use buffer selection, fallback visual
        selection = function(source) return select.buffer(source) or select.visual(source) end,
      }))
    end,
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
  {
    -- version = "v5.13.0",
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "bundled_build.lua", -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
    opts = {
      use_bundled_binary = true, -- Use the bundled binary
      extensions = {
        avante = {
          make_slash_commands = true, -- make /slash commands from MCP server prompts
        },
        copilotchat = {
          enabled = true,
          convert_tools_to_functions = true, -- Convert MCP tools to CopilotChat functions
          convert_resources_to_functions = true, -- Convert MCP resources to CopilotChat functions
          add_mcp_prefix = false, -- Add "mcp_" prefix to function names
        },
      },
      ui = { window = { border = "none" } },
      -- This sets vim.g.mcphub_auto_approve to true by default (can also be toggled from the HUB UI with `ga`)
      auto_approve = true,
    },
    config = function(_, opts) require("mcphub").setup(opts) end,
    -- keys = { { "<Leader>e5", "<cmd>MCPHub<CR>", desc = "Show MCPHub" } },
  },
}
