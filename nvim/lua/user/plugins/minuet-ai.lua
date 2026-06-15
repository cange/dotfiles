local provider_option = {
  OPENCODE = {
    api_key = "OPENCODE_ZEN_NVIM_API_KEY",
    end_point = "https://opencode.ai/zen/v1/chat/completions",
    model = "deepseek-v4-flash-free",
    name = "Opencode Zen",
    optional = {
      max_tokens = 56,
      top_p = 0.9,
      -- disable thinking to avoid first token latency
      thinking = { type = "disabled" },
    },
  },
  LM_STUDIO = {
    api_key = "TERM", -- no key required
    end_point = "http://127.0.0.1:1234/v1/chat/completions",
    model = "google/gemma-4-e2b-qat",
    name = "LM Studio",
    optional = {
      max_tokens = 56,
      top_p = 0.9,
      thinking = { type = "disabled" },
    },
  },
}

return {
  "milanglacier/minuet-ai.nvim",
  dependencies = { "hrsh7th/nvim-cmp" },
  event = "BufReadPre",
  opts = {
    -- provider
    provider = "openai_compatible",
    n_completions = 1, -- recommend for local model for resource saving
    -- I recommend beginning with a small context window size and incrementally
    -- expanding it, depending on your local computing power. A context window
    -- of 512, serves as an good starting point to estimate your computing
    -- power. Once you have a reliable estimate of your local computing power,
    -- you should adjust the context window to a larger value.
    context_window = 512,
    provider_options = {
      openai_compatible = provider_option.LM_STUDIO,
    },
    -- NES (Next Edit Prediction)
    duet = {
      provider = "openai_compatible",
      provider_options = {
        openai_compatible = vim.tbl_extend("force", provider_option.LM_STUDIO, {
          optional = {
            -- Disable thinking is recommended.
            reasoning_effort = "none",
            -- prioritize throughput for faster completion
            provider = { sort = "throughput" },
          },
        }),
      },
    },
    -- ui
    virtualtext = {
      auto_trigger_ft = { "*" },
      auto_trigger_ignore_ft = {
        "NvimTree",
        "snacks_terminal",
        "TelescopePrompt",
      },
      keymap = {
        -- accept whole completion
        accept = "<Tab>",
        -- accept one line
        accept_line = "<C-e>",
        -- accept n lines (prompts for number)
        accept_n_lines = "<C-z>",
        -- Cycle to prev completion item, or manually invoke completion
        prev = "<C-[>",
        -- Cycle to next completion item, or manually invoke completion
        next = "<C-]>",
        dismiss = "<C-c>",
      },
      -- Whether show virtual text suggestion when the completion menu
      -- (nvim-cmp or blink-cmp) is visible.
      show_on_completion_menu = false,
    },
  },
  keys = {
    -- stylua: ignore start
    { '<C-p>', '<cmd>Minuet duet predict<cr>', mode={'n', 'i'}, desc = '[minuet] NES predict' },
    { '<C-e>', '<cmd>Minuet duet apply<cr>', mode={'n', 'i'},   desc = '[minuet] NES apply' },
    { '<C-c>', '<cmd>Minuet duet dismiss<cr>', mode={'n', 'i'}, desc = '[minuet] NES dismiss' },
    -- stylua: ignore end
  },
}
