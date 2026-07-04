local ignore_filetypes = {
  "",
  "NvimTree",
  "TelescopePrompt",
  "gitcommit",
  "markdown",
  "help",
  "lazy",
  "mason",
}

---@param model 'gemma-4-e4b'|'gemma-4-e4b-it-qat'|'qwen3.5-9b-deepseek-v4-flash'
local function ml_studio_config(model)
  local preset = {
    api_key = "TERM", -- placeholder / not required for local model
    end_point = "http://127.0.0.1:1234/v1/chat/completions",
    model = model,
    name = "LM Studio",
    optional = {
      max_tokens = 164,
      top_p = 0.9,
      thinking = { type = "disabled" },
    },
  }

  return {
    provider = "openai_compatible",
    provider_options = {
      openai_compatible = vim.tbl_deep_extend("force", preset, {}),
    },
    duet = { -- NES (Next Edit Prediction)
      provider = "openai_compatible",
      provider_options = {
        openai_compatible = vim.tbl_deep_extend("force", preset, {
          optional = {
            -- Disable thinking is recommended.
            reasoning_effort = "none",
            -- prioritize throughput for faster completion
            provider = { sort = "throughput" },
          },
        }),
      },
    },
  }
end

vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
  pattern = ignore_filetypes,
  callback = function()
    local keys = { "<C-p>", "<C-e>", "<C-c>" }
    for _, key in ipairs(keys) do
      pcall(vim.keymap.del, key, { mode = "n", silent = true })
      pcall(vim.keymap.del, key, { mode = "i", silent = true })
    end
  end,
})

return {
  "sergioahp/minuet-ai.nvim",
  dependencies = { "hrsh7th/nvim-cmp" },
  event = "BufReadPre",
  opts = vim.tbl_extend("force", {
    n_completions = 2, -- provide minimum completions
    context_window = 12000,
    throttle = 1000,
    debounce = 400,
    request_timeout = 3,
    before_cursor_filter_length = 0,
    after_cursor_filter_length = 0,
    -- ui
    virtualtext = {
      auto_trigger_ft = { "lua", "javascript", "typescript", "ruby", "eruby", "html", "css" },
      auto_trigger_ignore_ft = ignore_filetypes,
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
      show_on_completion_menu = true,
    },
  }, ml_studio_config("gemma-4-e4b")),
  keys = function()
    local a = require("minuet.duet").action

    vim.defer_fn(function() vim.api.nvim_set_hl(0, "MinuetVirtualText", { link = "CmpGhostText" }) end, 1000)

    return {
      -- stylua: ignore start
      { '<C-p>',     a.predict,    mode = { 'n', 'i' }, desc = '[minuet] NES predict' },
      { '<C-e>',     a.apply,      mode = { 'n', 'i' }, desc = '[minuet] NES apply' },
      { '<C-c>',     a.dismiss,    mode = { 'n', 'i' }, desc = '[minuet] NES dismiss' },
      { '<C-]>',     a.next_chunk, mode = { 'n', 'i' }, desc = '[minuet] NES next' },
      { '<C-right>', a.cycle,      mode = { 'n', 'i' }, desc = '[minuet] NES cycle' },
      -- stylua: ignore end
    }
  end,
}
