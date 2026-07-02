return {
  -- Command and arguments to start the server.
  cmd = { "emmylua_ls" },
  -- Filetypes to automatically attach to.
  filetypes = { "lua" },
  -- Sets the workspace "root" to the directory where any of these files is found.
  -- Files sharing a root will reuse the LSP client/connection.
  -- Nested lists indicate equal priority, see |vim.lsp.Config|.
  root_markers = { { ".emmyrc.json", ".luarc.json" }, ".git" },
  -- Server-specific settings. https://github.com/EmmyLuaLs/emmylua-analyzer-rust/blob/main/docs/config/emmyrc_json_EN.md
  settings = {
    runtime = {
      version = "LuaJIT",
    },
  },
}
