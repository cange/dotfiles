vim.filetype.add({
  extension = {
    prop = "sh", -- resolves link.prop
    conf = "nginx", -- resolves any *.conf
    mdc = "markdown", -- Cursor editor like context files
  },
  filename = {
    [".visabletemplaterc"] = "yaml",
    ["gitconfig"] = "gitconfig",
    [".gitcredentials"] = "gitconfig",
  },
})
