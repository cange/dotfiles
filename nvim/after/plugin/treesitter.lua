local ns = "after.plugins.treesitter"
local found, treesitter_config = pcall(require, "nvim-treesitter.configs")
if not found then
  return
end
local found_utils, utils = pcall(require, "cange.utils")
if not found_utils then
  print("[" .. ns .. '] "cange.utils" not found)')
  return
end
treesitter_config.setup({
  ensure_installed = utils.get_config("treesitter.sources") or {}, -- A list of parser names, or "all"
  highlight = {
    enable = true, -- `false` will disable the whole extension
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true, -- Indentation based on treesitter for the = operator
  },
  rainbow = { -- https://github.com/p00f/nvim-ts-rainbow
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- highlight non-bracket tags like html
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings}
  },
  playground = { enable = true },
})
