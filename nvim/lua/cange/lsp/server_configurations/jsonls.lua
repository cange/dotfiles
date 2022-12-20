local found, schemastore = pcall(require, "schemastore")
if not found then
  print('[cange.lsp.server_configurations.jsonls] "schemastore" not found')
  return
end

return {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas({
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
