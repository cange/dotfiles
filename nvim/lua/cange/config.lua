return {
  log = {
    level = "info",
  },
  lsp = {
    diagnostic_virtual_text = true,
    format_on_save = true,
    -- points to the global node_modules system location
    mason_packages_path = vim.fn.expand("~") .. "/.local/share/nvim/mason/packages",
  },
  snippets = {
    path = "./../snippets",
  },
  ui = {
    colorscheme = {
      dark = "terafox",
      light = "dayfox",
    },
    border = "rounded", -- nvim_open_win: none, single, double, rounded, shadow
  },
}
