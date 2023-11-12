local ok, schemastore = pcall(require, "schemastore")
if not ok then
  error('[cange.lsp.server_configurations.jsonls] "schemastore" not found')
  return
end

return {
  settings = {
    json = {
      schemas = schemastore.json.schemas({
        select = {
          ".eslintrc",
          ".stylelintrc",
          "cypress.json",
          "jsconfig.json",
          "package.json",
          "prettierrc.json",
          "tsconfig.json",
        },
      }),
      validate = { enable = true },
    },
  },
}
