return {
  settings = {
    yaml = {
      hover = true,
      completion = true,
      format = { enable = true },
      validate = true,
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        ["https://json.schemastore.org/markdownlint.json"] = "/*.markdownlint.y*ml",
        ["https://json.schemastore.org/swagger-2.0.json"] = "/*swagger.y*ml",
        ["https://json.schemastore.org/yamllint.json"] = "/*yamllint.y*ml",
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "/*docker-compose.y*ml",
        ["https://yarnpkg.com/configuration/yarnrc.json"] = "/*.yarnrc.y*ml",
        [vim.fn.expand("$HOME/workspace/services/wlw_styleguide/schemas/docs.schema.json")]= "documentation.y*ml",
      },
      schemaStore = {
        url = "https://www.schemastore.org/json",
        enable = true,
      },
    },
  },
}
