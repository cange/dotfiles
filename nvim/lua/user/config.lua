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
    ---@type "none" | "single" | "double" | "rounded" | "shadow"
    border = "rounded",
  },
}
