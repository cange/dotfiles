local M = {}

-- NOTE: `file_patterns` expects a table of *string-match* patterns.
M.languages = {
  ["*"] = {
    file_patterns = {},
    features = {
      skip = {
        flag = "x",
        keywords = { "it", "describe", "test" },
        prefix = true,
        separator = "",
      },
      only = {
        flag = "only",
        keywords = { "it", "describe", "test" },
        prefix = false,
        separator = ".",
      },
    },
  },
  javascript = {
    file_patterns = { "__tests__/", "%.?test%.", "%.?spec%." },
    features = { skip = {}, only = {} },
  },
  ruby = {
    file_patterns = { "%w_spec%.$" },
    features = {
      skip = { keywords = { "context", "describe", "example", "it", "scenario", "specify", "test" } },
    },
  },
}

return M
