local M = {}
local AUGROUP_NAME = 'lsp_format_on_save'

function M.setup()
  local icons = require('cange.icons')
  local signs = {
    { name = 'DiagnosticSignError', text = icons.diagnostics.Error },
    { name = 'DiagnosticSignWarn', text = icons.diagnostics.Warning },
    { name = 'DiagnosticSignHint', text = icons.diagnostics.Hint },
    { name = 'DiagnosticSignInfo', text = icons.diagnostics.Information },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end
end

function M.format()
  vim.lsp.buf.formatting_sync()
  vim.notify 'Run LSP formatting'
end

function M.enable_auto_format()
  vim.api.nvim_create_augroup(AUGROUP_NAME, { clear = true })
  vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    command = ':lua require("cange.lsp.handlers").format()'
  })
  vim.notify 'Enabled format on save'
end

function M.disable_auto_format()
  M.remove_augroup(AUGROUP_NAME)
  vim.notify 'Disabled format on save'
end

function M.toggle_auto_format()
  if vim.fn.exists('#' .. AUGROUP_NAME) == 0 then
    M.enable_auto_format()
  else
    M.disable_auto_format()
  end
end

function M.remove_augroup(name)
  vim.api.nvim_del_augroup_by_name(name)
end

vim.cmd [[
command! Format execute 'lua require("cange.lsp.handlers").format()'
command! LspToggleAutoFormat execute 'lua require("cange.lsp.handlers").toggle_auto_format()'
]]

return M
