return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- NOTE: Never set this value to "*"! Never!
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "folke/snacks.nvim", -- for input provider snacks
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "markdown", "Avante" } },
        ft = { "markdown", "Avante" },
      },
    },
    opts = {
      ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
      provider = "copilot",
      providers = {
        copilot = {
          model = "claude-3.7-sonnet",
        },
        ollama = {
          endpoint = "http://127.0.0.1:11434", -- Note that there is no /v1 at the end.
          model = "qwen3:8b",
        },
      },
      windows = { width = 50 },
      file_selector = {
        provider = "telescope",
        provider_opts = {},
      },
      -- The system_prompt type supports both a string and a function that
      -- returns a string. Using a function here allows dynamically updating the
      -- prompt with mcphub
      system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ""
      end,
      -- The custom_tools type supports both a list and a function that returns
      -- a list. Using a function here prevents requiring mcphub before it's
      -- loaded
      custom_tools = function() return { require("mcphub.extensions.avante").mcp_tool() } end,
      disabled_tools = {
        "list_files", -- Built-in file operations
        "search_files",
        "read_file",
        "create_file",
        "rename_file",
        "delete_file",
        "create_dir",
        "rename_dir",
        "delete_dir",
        "bash", -- Built-in terminal access
      },
    },
    config = function(_, opts)
      require("avante").setup(opts)
      vim.g.mcphub_auto_approve = true

      -- Ensure Avante UI windows close before Neovim exits
      vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
        group = vim.api.nvim_create_augroup("before_avante_windows_close", { clear = true }),
        desc = "Close Avante UI windows",
        callback = function() require("avante").close_sidebar() end,
      })
    end,
    keys = {
      { "<Leader>ax", "<cmd>AvanteClear<CR>", desc = "avante: Clear", mode = { "n", "v" } },
      { "<Leader>am", "<cmd>AvanteModels<CR>", desc = "avante: Switch model" },
    },
  },

  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "yetone/avante.nvim",
    },
    build = "bundled_build.lua", -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
    opts = {
      port = 6969, -- Port for MCP Hub server
      config = vim.fn.expand("~/.config/nvim/mcpservers.json"), -- Absolute path to config file
      use_bundled_binary = true, -- Use the bundled binary
      extensions = {
        avante = {
          make_slash_commands = true, -- make /slash commands from MCP server prompts
        },
      },
      ui = { window = { border = "none" } },
      -- This sets vim.g.mcphub_auto_approve to true by default (can also be toggled from the HUB UI with `ga`)
      auto_approve = true,
    },
    keys = { { "<Leader>e5", "<cmd>MCPHub<CR>", desc = "Show MCPHub" } },
  },
}
