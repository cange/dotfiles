local found_prettier, prettier = pcall(require, "prettier")
if not found_prettier then
  return
end

local found_prettier, prettier_config = pcall(require, "cange.prettier")
if not found_prettier then
  print('[prettier] "cange.prettier" not found')
  return
end

prettier.setup({
  bin = "prettierd", -- pretty fast prettier version
  filetypes = prettier_config.filetypes,
})
