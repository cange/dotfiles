local ns = "cange.lsp.mason"
local found, mason = pcall(require, "mason")
if not found then
  print("[" .. ns .. '] "mason" not found')
  return
end
local found_utils, utils = pcall(require, "cange.utils")
if not found_utils then
  print("[" .. ns .. '] "cange.utils" not found')
  return
end
-- config
mason.setup({
  ui = {
    border = "rounded",
    icons = utils.get_icon("mason"),
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
})
