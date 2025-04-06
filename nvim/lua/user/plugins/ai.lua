return {
  { -- Avante
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- NOTE: Never set this value to "*"! Never!
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons",
      { "zbirenbaum/copilot.lua" },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "markdown", "Avante" } },
        ft = { "markdown", "Avante" },
      },
    },
    opts = {
      ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
      provider = "copilot",
      copilot = {
        model = "claude-3.7-sonnet",
      },
      ollama = {
        endpoint = "http://127.0.0.1:11434", -- Note that there is no /v1 at the end.
        model = "qwen3:8b",
      },
      windows = { width = 50 },
      file_selector = {
        provider = "telescope",
        provider_opts = {},
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
      { "<leader>ax", "<cmd>AvanteClear<CR>", desc = "avante: Clear", mode = { "n", "v" } },
    },
  },

  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
    },
    -- uncomment the following line to load hub lazily
    --cmd = "MCPHub",  -- lazy load
    build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
    -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
    -- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
    config = function() require("mcphub").setup() end,
  },

  {
    "ravitemer/mcphub.nvim",
    enabled = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "MCPHub", -- lazily start the hub when `MCPHub` is called
    build = "bun add -g mcp-hub@latest", -- Installs required mcp-hub npm module
    opts = {
      -- Required options
      port = 6969, -- Port for MCP Hub server
      config = vim.fn.expand("~/.config/nvim/mcpservers.json"), -- Absolute path to config file

      log = {
        level = vim.log.levels.WARN,
        to_file = false,
        file_path = nil,
        prefix = "MCPHub",
      },
    },
  },
}
