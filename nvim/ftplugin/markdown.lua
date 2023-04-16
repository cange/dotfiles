if not Cange.set_highlights then
  print('[ftplugin/markdown] "Cange.set_hls" not found')
  return
end

Cange.set_highlights({
  ["@punctuation.special"] = { link = "Special" },
  ["@text.uri"] = { link = "Type" },
})
