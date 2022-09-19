local lsp = BULK_LOADER('mason', { { 'mason', 'mason' } })
local utils = BULK_LOADER('mason', { { 'cange.icons', 'icons' } })

lsp.mason.setup({
  ui = {
    border = 'rounded',
    icons = utils.icons.mason,
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
})
