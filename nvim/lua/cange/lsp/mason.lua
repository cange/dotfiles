local ns = 'cange.lsp.mason'
local found, mason = pcall(require, 'mason')
if not found then
  print('[' .. ns .. '] "mason" not found')
  return
end
local found_icons, icons = pcall(require, 'cange.utils.icons')
if not found_icons then
  print('[' .. ns .. '] "cange.utils.icons" not found')
  return
end
-- config
mason.setup({
  ui = {
    border = 'rounded',
    icons = icons.mason,
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
})
