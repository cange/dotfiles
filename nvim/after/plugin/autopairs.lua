local found, autopairs = pcall(require, "nvim-autopairs")
if not found then
  return
end

autopairs.setup({
  disable_filetype = { "TelescopePrompt", "vim" },
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local found_cmp, cmp = pcall(require, "cmp")
if not found_cmp then
  return
end

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
