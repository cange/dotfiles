-- finds 'foo' in {'foo', 'bar'}
local function contains(t, value)
  for _, v in pairs(t) do
    if v == value then
      return true
    end
  end
  return false
end

-- finds 'foo' in {foo: 1, bar: 2}
local function contains_key(t, key)
  for k, _ in pairs(t) do
    if k == key then
      return true
    end
  end
  return false
end

return {
  contains = contains,
  contains_key = contains_key,
}
