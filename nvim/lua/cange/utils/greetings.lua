---String interpolation helper
--- @param str string
--- @param tbl table
--- @return string
local function interp(str, tbl)
  return (str:gsub('($%b{})', function(word) return tbl[word:sub(3, -2)] or word end))
end

---Generates random number between given min max
--- @param min integer
--- @param max integer
--- @return integer
local function random_range (min, max)
  return  math.floor(math.random() * (max - min)) + min
end

---Generate day time related greeting
--- @return string
local function greeting_by_day_time()
  local h = tonumber(vim.fn.strftime('%k', vim.fn.localtime()))
  local day_time = 'morning'
  if h > 12 and h <= 18 then day_time = 'afternoon'
  elseif h >= 18 or h < 5 then day_time = 'evening'
  end
  return 'Good '..day_time
end

---Repeat string as many as given count
---@param str string
---@param count integer
---@return table<string>
local function repeat_string(str, count)
  local i = 1
  local result = {}
  repeat
    result[i] = str;
    i = i + 1
  until(i > count)
  return result
end

---Generate senctence dependent ont given weight
---@param senctence_and_weight table<string, integer>
---@return table<string> List of sentences
local function generate_by_weight(senctence_and_weight)
  local s = {}
  for _, pair in pairs(senctence_and_weight) do
    s = vim.list_extend(s, repeat_string(pair[1], pair[2]))
  end
  return s
end

---List of greetings with the amount corresponding to the weight
---@return table<string>
local function greetings_and_weights()
  return generate_by_weight({
    { 'What’s going on ${name}?', 1 },
    { '${name}, its been a while!', 1 },
    { 'Good to see you, ${name}!', 1 },
    { 'Hello ${name}!', 1 },
    { 'Hey ${name}!', 1 },
    { 'Howdy, ${name}!', 1 },
    { 'Hi ${name}', 1 },
    { 'How are you ${name}?', 1 },
    { 'How’s it going ${name}?', 1 },
    { 'Long time no see ${name}!', 1 },
    { 'Nice to see you ${name}!', 1 },
    { 'Sup ${name}?', 1 },
    { 'Wazzup ${name}?', 1 },
    { 'Yo ${name}!', 1 },
    { greeting_by_day_time()..' ${name}!', 6 }, -- prio this greeting by adding it multipe times
  })
end

---Generates random gretting with given name and day time.
--- @param name string
--- @return string
local function random_with_name(name)
  local greetings = greetings_and_weights()
  local greeting = greetings[random_range(1, vim.tbl_count(greetings))]
  return interp(greeting, { name = name })
end

---Provides greeting functionalities.
---@class Greetings
local M = {}
M.random_with_name = random_with_name
return M
