local M = {}
local strUtil = require("cange.utils.string")
local ns = "[cange.utils.icons]"

---Retrieves an icon from the specified path.
---@param path string Dot separated path to the desired icon.
---@param opts? {left?:number, right?:number}
---@return table|string|nil # The icon value if found, nil if the path is invalid.
function M.get_icon(path, opts)
  local ok, icons = pcall(require, "cange.icons")
  if not ok then
    error(ns .. ' "cange.icons" not found!')
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
    opts = opts or { right = 0, left = 0 }
    return strUtil.pad(vim.trim(current), opts)
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

local i = M.get_icon

---@type DevIconsPreset[]
local presets = {
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
    icon = i("extensions.Nuxt"),
    color = "#00dc82",
    cterm_color = "35",
    name = "Nuxt",
  },
  babelrc = {
    icon = i("extensions.Babelrc"),
    name = "Babelrc",
  },
  stylelint = {
    icon = i("extensions.Stylelint"),
    color = "#d0d0d0",
    cterm_color = "252",
    name = "Stylelint",
  },
  eslint = {
    name = "Eslintrc",
  },
  prettier = {
    -- temp fix until this is working https://github.com/nvim-tree/nvim-web-devicons/pull/417
    icon = "󰈧",
  },
  yarn = {
    icon = i("extensions.Yarn"),
    color = "#2c8ebb",
    cterm_color = "33",
    name = "YarnPkg",
  },
}

local function redefine_icons()
  set_icon_by_filetype(".prettierrc", ".prettierignore", presets.prettier)
  set_icon_by_filetype(".stylelintrc", ".stylelintignore", presets.stylelint)
  set_icon_by_filetype("node_modules", ".nvmrc")
  set_icon_by_filetype("vue", "vue", presets.vue)
  set_icon_by_filetype("yarn", ".yarn", presets.yarn)
  set_icon_by_filetype("yarn", ".yarnrc.yml", presets.yarn)
  set_icon_by_filetype("yarn", "yarn.lock", presets.yarn)

  for _, ext in pairs({ "", ".json", ".cjs", ".js", ".mjs" }) do
    set_icon_by_filetype(".babelrc", ".babelrc" .. ext, presets.babelrc)
    set_icon_by_filetype(".babelrc", "babel.config" .. ext, presets.babelrc)
    set_icon_by_filetype(".eslintrc", ".eslintrc" .. ext, presets.eslint)
    set_icon_by_filetype(".prettierrc", ".prettierrc" .. ext, presets.prettier)
    set_icon_by_filetype(".stylelint", ".stylelintrc" .. ext, presets.stylelint)
  end

  for _, ft in pairs({ "js", "ts" }) do
    set_icon_by_filetype(ft, "nuxt.config." .. ft, presets.nuxt)
    set_icon_by_filetype(ft, "stories." .. ft, presets.storybook)
  end

  require("nvim-web-devicons").set_icon(user_icons)
end

function M.setup()
  -- delays call to ensure that all icons are loaded
  vim.defer_fn(redefine_icons, 1000)
end

function M.get_service_icons()
  redefine_icons()
  ---@param extension string
  ---@return string
  local function grep_icon(extension)
    local icon, _ = require("nvim-web-devicons").get_icon("", extension)
    return icon
  end

  return {
    cssls = grep_icon("css"),
    eslint = grep_icon(".eslintrc"),
    jsonlint = grep_icon("json"),
    jsonls = grep_icon("json"),
    lua_ls = grep_icon("lua"),
    markdownlint = grep_icon("md"),
    rubocop = grep_icon("rb"),
    ruby_ls = grep_icon("rb"),
    stylelint = grep_icon(".stylelint"),
    tailwindcss = grep_icon("tailwind.config.js"),
    tsserver = grep_icon("ts"),
    volar = grep_icon("vue"),
  }
end

return M
--#region Types

---@class DevIconsPreset
---@field icon? string Path of an icon shape
---@field color? string Hex color value
---@field cterm_color? string
---@field name string

--#endregion
