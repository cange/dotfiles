local ns = "[after/plugin/vim-visual-multi]"
local found_vim_visual_multi, vim_visual_multi = pcall(require, "vim-visual-multi")
if not found_vim_visual_multi then
  print(ns, '"vim-visual-multi" not found')
  return
end
