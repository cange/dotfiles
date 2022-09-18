-- https://github.com/bmatcuk/stylelint-lsp#settings
return {
  settings = {
    stylelintplus = {
      autoFixOnFormat = false, -- automatically apply fixes in response to format requests.
      autoFixOnSave = false, -- automatically apply fixes on save.
      config = nil, -- stylelint config to use.
      configFile = nil, -- path to stylelint config file.
      configOverrides = nil, -- stylelint config overrides.
      enable = true, -- if false, disable linting and auto-formatting.
      validateOnSave = false, -- lint on save.
      validateOnType = true, -- lint after changes.
    },
  },
}
