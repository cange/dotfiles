return {
  lsp = {
    ---@type vim.diagnostic.Opts.VirtualText
    diagnostic_virtual_text = {
      current_line = true,
    },
    format_on_save = true,
  },
  ui = {
    ---@type "none" | "single" | "double" | "rounded" | "shadow"
    border = "rounded",
  },
}
