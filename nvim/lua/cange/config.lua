---@class cange.configGroup[]

return {
  log = {
    level = "info",
  },
  lsp = {
    diagnostic_virtual_text = true,
    format_on_save = true,
  },
  snippets = {
    path = "./../snippets",
  },
  ui = {
    colorscheme = "terafox",
    border = "rounded", -- nvim_open_win: none, single, double, rounded, shadow
  },
}
