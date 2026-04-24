local M = {}

M.plugin = {
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

  {
    {
      "CopilotC-Nvim/CopilotChat.nvim",
      dependencies = {
        { "nvim-lua/plenary.nvim", branch = "master" },
      },
      build = "make tiktoken",
      opts = function()
        local model = "claude-sonnet-4-6"
        return {
          prompts = {
            Concise = { prompt = "Please rewrite the following text to make it more concise." },
            Naming = { prompt = "Please provide better names for the following variables and functions." },
            Wording = { prompt = "Please improve the grammar and wording of the following text." },
          },
          model = model,
          sticky = "buffer",
          auto_insert_mode = true, -- Enter insert mode when opening
          chat_autocomplete = true,
          show_help = true,
        }
      end,
      keys = {
        { "<Leader>cc", "<cmd>CopilotChatToggle<CR>", desc = "Toggle [copilot chat]", mode = { "n", "v" } },
        { "<Leader>cf", "<cmd>CopilotChatFix<cr>", desc = "Fix Diagnostic [copilot chat]", mode = { "n", "v" } },
        { "<Leader>cp", "<cmd>CopilotChatPrompts<CR>", desc = "Prompt [copilot chat]", mode = { "n", "v" } },
        { "<Leader>cs", "<cmd>CopilotChatStop<CR>", desc = "Stop [copilot chat]", mode = { "n", "v" } },
        { "<Leader>cx", "<cmd>CopilotChatReset<CR>", desc = "Clear [copilot chat]", mode = { "n", "v" } },
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
  },
  {
    "folke/sidekick.nvim",
    opts = {
      cli = { win = { split = { width = 0 } } },
    },
    keys = function()
      local cli = require("sidekick.cli")
      local nes = require("sidekick.nes")

      return {
        {
          "<tab>",
          function()
            -- if there is a next edit, jump to it, otherwise apply it if any
            if not require("sidekick").nes_jump_or_apply() then
              return "<Tab>" -- fallback to normal tab
            end
            return ""
          end,
          expr = true,
          desc = "Goto/Apply Next Edit Suggestion [sidekick]",
        },
        -- stylua: ignore start
        { "<c-.>", function() cli.focus() end, mode = { "n", "x", "i", "t" },               desc = "[sidekick] Switch Focus" },
        { "<leader>aS", function() cli.select({ filter = { installed = true } }) end,       desc = "[sidekick] Select CLI" },
        { "<leader>aa", function() cli.toggle({ name = "opencode", focus = true }) end,     desc = "[sidekick] Toggle" },
        { "<leader>ad", function() cli.close() end,                                         desc = "[sidekick] Detach Session" },
        { "<leader>ap", function() cli.prompt({ msg = "{this}" }) end, mode = { "n", "x" }, desc = "[sidekick] Select Prompt" },
        { "<leader>af", function() cli.send({ msg = "{file}" }) end,                        desc = "[sidekick] Send File" },
        { "<leader>av", function() cli.send({ msg = "{selection}" }) end, mode = { "x" },   desc = "[sidekick] Send Visual Selection", },
        { "<leader>at", function() cli.send({ msg = "{this}" }) end, mode = { "x", "n" },   desc = "[sidekick] Send this" },
        { "<leader>an", function() nes.toggle() end,                                        desc = "[sidekick] Toggle NES" },
        -- stylua: ignore end
      }
    end,
  },
}

M.icons = {
  Copilot = "", -- nf-oct-copilot
  CopilotError = "", -- nf-oct-copilot_error
  CopilotWarning = "", -- nf-oct-copilot_warning
}

M.lsp_servers = {
  copilot = {},
}

M.which_key = {
  { "<Leader>ac", group = "CopilotChat", mode = { "n", "v" } },
  { "<LocalLeader>c", group = "Copilot" },
}
M.lualine_dependencies = {
  -- https://github.com/AndreM222/copilot-lualine
  "AndreM222/copilot-lualine",
}
M.lualine_component = {
  "copilot",
  on_click = function() vim.cmd("Copilot status") end,
  padding = { left = 1, right = 0 },
  separator = "",
  symbols = { spinners = vim.split(Icon.sets.spinner, " ") },
}

return M
