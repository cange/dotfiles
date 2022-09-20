local lsp = _G.bulk_loader('mason', { { 'mason', 'mason' } })
local utils = _G.bulk_loader('mason', { { 'cange.icons', 'icons' } })

lsp.mason.setup({
  ui = {
    border = 'rounded',
    icons = utils.icons.mason,
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
})
