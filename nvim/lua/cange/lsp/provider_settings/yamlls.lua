local found, schemastore = pcall(require, 'schemastore')
if not found then
  return
end

return {
  settings = {
    yaml = {
      schemas = schemastore.json.schemas(),
      schemaStore = {
        enable = true,
      },
    },
  },
}
