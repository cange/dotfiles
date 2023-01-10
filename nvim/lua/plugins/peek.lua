return {
  -- Markdown
  "toppair/peek.nvim",
  build = "deno task --quiet build:fast",
  confif = function()
    local ns = "[plugin/peek]"
    local peek = require("peek")

    peek.setup({ -- https://github.com/toppair/peek.nvim
      auto_load = true, -- whether to automatically load preview when entering another markdown buffer
      close_on_bdelete = true, -- close preview window on buffer delete
      syntax = true, -- enable syntax highlighting, affects performance
      theme = "dark", -- 'dark' or 'light'
      update_on_change = true,

      -- relevant if update_on_change is true
      throttle_at = 200000, -- start throttling when file exceeds this amount of bytes in size
      throttle_time = "auto", -- minimum amount of time in milliseconds that has to pass before starting new render
    })

    local function toggle_markdown_preview()
      local method = peek.is_open() and "close" or "open"
      vim.notify(method .. " markdown preview", vim.log.levels.INFO, { title = ns })
      peek[method]()
    end

    vim.keymap.set("n", "<leader>md", toggle_markdown_preview)
  end,
}
