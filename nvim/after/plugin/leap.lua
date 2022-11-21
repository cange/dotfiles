local ns = "[plugin/leap]"
local found_leap, leap = pcall(require, "leap")
if not found_leap then
  print(ns, '"leap" not found')
  return
end

leap.add_default_mappings()

-- Getting used to `d` shouldn't take long - after all, it is more comfortable
-- than `x`, and even has a better mnemonic.
-- If you still desperately want your old `x` back, then just delete these
-- mappings set by Leap:
vim.keymap.del({ "x", "o" }, "x")
vim.keymap.del({ "x", "o" }, "X")
