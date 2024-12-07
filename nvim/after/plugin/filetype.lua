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
