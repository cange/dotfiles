local ns = "[plugin/peek]"
local found, peek = pcall(require, "peek")
if not found then
  return
end

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

local found_utils, utils = pcall(require, "cange.utils")
if not found_utils then
  print(ns, '"cange.utils" not found')
  return
end
local keymap = utils.keymap

local function toggle_markdown_preview()
  local method = peek.is_open() and "close" or "open"
  vim.notify(method .. " markdown preview", vim.log.levels.INFO, { title = ns })
  peek[method]()
end

keymap("n", "<leader>md", toggle_markdown_preview)
