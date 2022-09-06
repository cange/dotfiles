local found_table, table = pcall(require, 'cange.utils.table')
if not found_table then return end

return {
  table = table
}
