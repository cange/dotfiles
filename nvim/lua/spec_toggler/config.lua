return {
  ["*"] = {
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
  javascript = { features = { skip = {}, only = {} } },
  ruby = {
    features = {
      skip = { keywords = { "context", "describe", "example", "it", "scenario", "specify", "test" } },
    },
  },
}
