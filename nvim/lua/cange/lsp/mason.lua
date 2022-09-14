local ok, mason = pcall(require, 'mason')
if not ok then
  return
end

local icons_ok, icons = pcall(require, 'cange.icons')
if not icons_ok then
  return
end

mason.setup({
  ui = {
    border = 'rounded',
    icons = icons.mason,
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
})
