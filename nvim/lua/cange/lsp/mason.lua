local found, mason = pcall(require, 'mason')
if not found then
  return
end

local found_icons, icons = pcall(require, 'cange.icons')
if not found_icons then
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
