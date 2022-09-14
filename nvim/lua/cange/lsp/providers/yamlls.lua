local found, schemastore = pcall(require, 'schemastore')
if not found then
  return
end

return {
  yaml = {
    schemas = schemastore.json.schemas(),
    schemaStore = {
      enable = true,
    },
  },
}
