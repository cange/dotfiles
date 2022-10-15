-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/volar.lua

-- local lsp_util = require("lspconfig.util")
--
-- -- config
-- local function get_typescript_server_path(root_dir)
--   local project_root = lsp_util.find_node_modules_ancestor(root_dir)
--   return project_root and (lsp_util.path.join(project_root, 'node_modules', 'typescript', 'lib')) or ''
-- end

return {
  -- filetypes = {
  --   "typescript",
  --   "javascript",
  --   "javascriptreact",
  --   "typescriptreact",
  --   "vue",
  --   "json",
  -- },
  init_options = {
    -- typescript = {
    --   tsdk = '',
    -- },
    languageFeatures = {
      -- implementation = true,
      -- -- not supported - https://github.com/neovim/neovim/pull/14122
      -- semanticTokens = false,
      -- references = true,
      -- definition = true,
      -- typeDefinition = true,
      -- callHierarchy = true,
      -- hover = true,
      -- rename = true,
      -- renameFileRefactoring = true,
      -- signatureHelp = true,
      -- codeAction = true,
      completion = {
        defaultTagNameCase = "pascaleCase",
        defaultAttrNameCase = "kebabCase",
      },
      -- schemaRequestService = true,
      -- documentHighlight = true,
      -- documentLink = true,
      -- codeLens = true,
      -- diagnostics = true,
    },
    -- documentFeatures = {
    --   -- not supported - https://github.com/neovim/neovim/pull/13654
    --   documentColor = false,
    --   selectionRange = true,
    --   foldingRange = true,
    --   linkedEditingRange = true,
    --   documentSymbol = true,
    --   documentFormatting = {
    --     defaultPrintWidth = 100,
    --   },
  },
  -- on_new_config = function(new_config, new_root_dir)
  --   local path = get_typescript_server_path(new_root_dir)
  --   new_config.init_options.typescript.serverPath = path
  -- end,
}
