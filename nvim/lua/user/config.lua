return {
  lsp = {
    ---@type vim.diagnostic.Opts.VirtualText
    diagnostics = {
      virtual_type = "virtual_text", -- 'virtual_text' | 'virtual_lines'
    },
    format_on_save = true,
  },
  ui = {
    ---@type "none" | "single" | "double" | "rounded" | "shadow"
    border = "rounded",
  },
}
