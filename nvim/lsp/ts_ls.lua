local settings = {
  inlayHints = {
    includeInlayEnumMemberValueHints = true,
    includeInlayFunctionLikeReturnTypeHints = true,
    includeInlayFunctionParameterTypeHints = true,
    includeInlayParameterNameHints = "all",
    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
    includeInlayPropertyDeclarationTypeHints = true,
    includeInlayVariableTypeHints = true,
    includeInlayVariableTypeHintsWhenTypeMatchesName = true,
  },
  implementationsCodeLens = { enabled = true },
  referencesCodeLens = { enabled = true },
  suggestionActions = { enabled = true },
}

return {
  init_options = {
    preferences = { disableSuggestions = true },
    completions = { completeFunctionCalls = true },
  },
  settings = {
    typescript = settings,
    javascript = settings,
  },
}
