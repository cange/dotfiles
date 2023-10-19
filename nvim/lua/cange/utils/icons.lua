local M = {}
local ns = "[cange.utils.icons]"

---Retrieves an icon from the specified path.
---@param path string Dot separated path to the desired icon.
---@return {table|string|nil} # The icon value if found, nil if the path is invalid.
function M.get_icon(path)
  local ok, icons = pcall(require, "cange.icons")
  if not ok then
    print('[error] "cange.icons" not found!', ns)
    return ""
  end
  local parts = {}
  for part in string.gmatch(path, "([^%.]+)") do
    table.insert(parts, part)
  end

  ---@type table|string
  local current = icons
  for _, part in ipairs(parts) do
    if type(current) == "table" then current = current[part] end
  end

  if not current then
    Log:warn('Icon "' .. path .. '" not found!', { title = ns })
    return nil -- Invalid path
  end

  if type(current) == "string" then
    ---@diagnostic disable-next-line: cast-local-type
    current = vim.trim(current)
  end

  return current
end

local user_icons = {}

---@param origin_filetype string
---@param filename string
---@param preset? DevIconsPreset
local function set_icon_by_filetype(origin_filetype, filename, preset)
  local devicons = require("nvim-web-devicons")
  local icon, color = devicons.get_icon_color(origin_filetype)
  local _, cterm = devicons.get_icon_cterm_color_by_filetype(origin_filetype)
  local fallback = {
    color = color,
    cterm_color = cterm,
    icon = icon,
    name = "",
  }

  user_icons[filename] = vim.tbl_extend("force", fallback, preset or {})
end

---@type DevIconsPreset[]
local presets = {
  spec = {
    icon = M.get_icon("ui.Beaker"),
    name = "Test",
  },
  storybook = {
    color = "#ff4785",
    cterm_color = "198",
    name = "Storybook",
  },
  vue = {
    color = "#42b883",
    cterm_color = "29",
    name = "Vue",
  },
  nuxt = {
    icon = M.get_icon("extensions.Nuxt"),
    color = "#00dc82",
    cterm_color = "35",
    name = "Nuxt",
  },
  babelrc = {
    icon = M.get_icon("extensions.Babelrc"),
    name = "Babelrc",
  },
  stylelint = {
    icon = M.get_icon("extensions.Stylelint"),
    color = "#d0d0d0",
    cterm_color = "252",
    name = "Stylelint",
  },
  eslint = {
    name = "Eslintrc",
  },
}

local function redefine_icons()
  set_icon_by_filetype("", ".stylelint", presets.stylelint) -- create type
  set_icon_by_filetype(".stylelintrc", ".stylelintignore", presets.stylelint)
  set_icon_by_filetype("vue", "vue", presets.vue)
  set_icon_by_filetype("node_modules", ".nvmrc")

  for _, ext in pairs({ ".json", ".cjs", ".js", ".mjs" }) do
    set_icon_by_filetype(".babelrc", ".babelrc" .. ext, presets.babelrc)
    set_icon_by_filetype(".babelrc", "babel.config" .. ext, presets.babelrc)
    set_icon_by_filetype(".stylelint", ".stylelintrc" .. ext, presets.stylelint)
    set_icon_by_filetype(".eslintrc", ".eslintrc" .. ext, presets.eslint)
  end

  for _, ft in pairs({ "js", "ts" }) do
    set_icon_by_filetype(ft, "cy." .. ft, presets.spec)
    set_icon_by_filetype(ft, "nuxt.config." .. ft, presets.nuxt)
    set_icon_by_filetype(ft, "stories." .. ft, presets.storybook)
  end

  require("nvim-web-devicons").set_icon(user_icons)
end

function M.setup()
  -- delays call to ensure that all icons are loaded
  vim.defer_fn(redefine_icons, 1000)
end

return M

--#region Types

---@class DevIconsPreset
---@field icon? string Path of an icon shape
---@field color? string Hex color value
---@field cterm_color? string
---@field name string

--#endregion
