--- Prefer this to `get_package`, since the package might not always be
--- available yet and trigger errors.
---@param pkg string
---@param path string
local function get_pkg_path(pkg, path)
  pcall(require, "mason") -- make sure Mason is loaded. Will fail when generating docs
  local root = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
  local pkg_path = root .. "/packages/" .. pkg .. "/" .. path

  if not vim.loop.fs_stat(pkg_path) then
    vim.notify(
      ("Package path not found for **%s**:\n- `%s`\nForce update the package."):format(pkg, path),
      vim.log.levels.INFO
    )
  end
  return pkg_path
end

return {
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#vtsls
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = "@vue/typescript-plugin",
            location = get_pkg_path("vue-language-server", "node_modules/@vue/language-server"),
            languages = { "vue" },
            configNamespace = "typescript",
          },
        },
      },
    },
  },
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
}
