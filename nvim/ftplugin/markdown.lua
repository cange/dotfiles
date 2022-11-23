local found_utils, utils = pcall(require, "cange.utils")
if not found_utils then
  return
end

utils.set_hls({
  ["@punctuation.special"] = { link = "Special" },
  ["@text.uri"] = { link = "Type" },
})
