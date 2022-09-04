local ok, schemastore = pcall(require, 'schemastore')
if not ok then return end

return {
  init_options = {
    provideFormatter = false,
  },
  settings = {
    json = {
      schemas = schemastore.json.schemas(),
    },
  },
}

