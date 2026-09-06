vim.filetype.add({
  extension = {
    prop = "sh", -- resolves link.prop
    conf = "nginx", -- resolves any *.conf
    mdc = "markdown", -- Cursor editor like context files
    mdx = "jsx", -- MDX files
  },
  filename = {
    ["gitconfig"] = "gitconfig",
    [".gitcredentials"] = "gitconfig",
  },
  pattern = {
    ["%.env%..*"] = "sh", -- .env.* files
  },
})
