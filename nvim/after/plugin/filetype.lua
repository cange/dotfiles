vim.filetype.add({
  extension = {
    prop = "sh", -- resolves link.prop
    conf = "nginx", -- resolves any *.conf
  },
  filename = {
    [".visabletemplaterc"] = "yaml",
    ["gitconfig"] = "gitconfig",
  },
})

if vim.bo.filetype then
  -- disabled overwelming diagnostic noise in markdown
  vim.diagnostic.config({ virtual_text = false })
end
