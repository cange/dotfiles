if not Cange.set_hls then
  print('[ftplugin/markdown] "Cange.set_hls" not found')
  return
end

Cange.set_hls({
  ["@punctuation.special"] = { link = "Special" },
  ["@text.uri"] = { link = "Type" },
})
