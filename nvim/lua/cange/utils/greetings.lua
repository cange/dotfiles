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
  if h > 12 or h < 18 then day_time = 'afternoon'
  elseif h < 5 or h > 18 then day_time = 'evening'
  end
  return 'Good '..day_time
end

--- @table greetings
local greeting_by_day_time_with_name = greeting_by_day_time()..' ${name}!'
local greetings = {
  'What’s going on ${name}?',
  '${name}, its been a while!',
  'Good to see you, ${name}!',
  'Hello ${name}!',
  'Hey ${name}!',
  'Howdy, ${name}!',
  'Hi ${name}',
  'How are you ${name}?',
  'How’s it going ${name}?',
  'Long time no see ${name}!',
  'Nice to see you ${name}!',
  'Sup ${name}?',
  'Wazzup ${name}?',
  'Yo ${name}!',
  greeting_by_day_time_with_name, -- prio this greeting by adding it multipe times
  greeting_by_day_time_with_name,
  greeting_by_day_time_with_name,
  greeting_by_day_time_with_name,
  greeting_by_day_time_with_name,
}

---Provides greeting functionalities.
---@class Greetings
local M = {}

---Generates random gretting with given name and day time.
--- @type function
--- @param name string
--- @return string
M.random_with_name = function(name)
  local count = vim.tbl_count(greetings)
  return interp(greetings[random_range(1, count)], { name = name })
end

return M
