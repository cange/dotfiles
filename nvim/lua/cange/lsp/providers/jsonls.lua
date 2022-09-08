local found, schemastore = pcall(require, 'schemastore')
if not found then return end

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

