local found, mason = pcall(require, 'mason')
if not found then
  print('[cange.lsp.mason] "mason" not found')
  return
end

mason.setup({
  ui = {
    border = 'rounded',
    icons = Cange.icons.mason,
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
})
