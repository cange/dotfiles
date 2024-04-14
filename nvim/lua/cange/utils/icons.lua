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
---@param extensions? string[]
---@param preset? DevIconsPreset
local function set_icon_by_filetype(origin_filetype, filename, extensions, preset)
  local devicons = require("nvim-web-devicons")
  local icon, color = devicons.get_icon_color(origin_filetype)
  local _, cterm = devicons.get_icon_cterm_color_by_filetype(origin_filetype)
  local fallback = {
    color = color,
    cterm_color = cterm,
    icon = icon,
    name = "",
  }

  for _, ext in pairs(extensions or { "" }) do
    local fname = filename .. ext
    user_icons[fname] = vim.tbl_extend("force", fallback, preset or {})
    -- print(string.format("[%s] %s", fname, vim.inspect(user_icons[fname])):gsub("\n", " "))
  end
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
  babel = {
    icon = i("extensions.Babelrc"),
    name = "Babelrc",
  },
  cypress = {
    color = "#69d3a7",
    cterm_color = "24",
    name = "Cypress",
  },
  eslint = { name = "Eslintrc" },
  prettier = { name = "PrettierConfig" },
  stylelint = {
    icon = i("extensions.Stylelint"),
    color = "#d0d0d0",
    cterm_color = "252",
    name = "StylelintConfig",
  },
  yarn = {
    icon = i("extensions.Yarn"),
    color = "#2c8ebb",
    cterm_color = "33",
    name = "YarnPkg",
  },
}
---Defines the set for all "rc" related files eg. .eslintrc, .eslintignore, .eslintrc.config.js, etc.
---@param type string
---@param rc_set string[] Extension set for ".…rc" files eg. .babelrc,
---@param config_set string[] Extension set for ".….config" related types eg. .babel.config
local function set_rc_file_icons(type, rc_set, config_set)
  local filetype = "." .. type .. "rc"
  set_icon_by_filetype(filetype, filetype, rc_set, presets[type])
  set_icon_by_filetype(filetype, "." .. type .. "ignore", nil, presets[type])
  set_icon_by_filetype(filetype, "" .. type .. ".config", config_set, presets[type])
end

local function redefine_icons()
  set_rc_file_icons("babel", { "", ".json", ".js", ".cjs", ".mjs", ".cts" }, { ".json", ".js", ".cjs", ".mjs", ".cts" })
  set_rc_file_icons("eslint", { "", ".json", ".js", ".cjs", ".yaml", ".yml" }, { ".js", ".cjs", ".mjs" })
  set_rc_file_icons(
    "prettier",
    { "", ".json", ".js", ".cjs", ".mjs", ".yaml", ".yml", ".json5", ".toml" },
    { ".js", ".cjs", ".mjs" }
  )

  set_rc_file_icons("stylelint", { "", ".json", ".js", ".cjs", ".mjs", ".yaml", ".yml" }, { ".js", ".cjs", ".mjs" })

  set_icon_by_filetype("node_modules", ".nvmrc")
  set_icon_by_filetype("vue", "vue", nil, presets.vue)
  set_icon_by_filetype("yarn", ".yarn", { "", "rc.yml" }, presets.yarn)
  set_icon_by_filetype("yarn", "yarn.lock", nil, presets.yarn)

  for _, ext in pairs({ "js", "ts" }) do
    set_icon_by_filetype(ext, "nuxt.config." .. ext, nil, presets.nuxt)
    set_icon_by_filetype(ext, "stories." .. ext, nil, presets.storybook)
    set_icon_by_filetype(ext, "cypress.config", { ".js", ".cjs", ".mjs", ".ts" }, presets.cypress)
  end

  -- rare file types
  for _, filename in pairs({ ".tool-versions", ".visabletemplaterc", "links.prop" }) do
    set_icon_by_filetype("yaml", filename, nil, { name = "Config" })
  end

  require("nvim-web-devicons").set_icon(user_icons)
end

function M.setup()
  -- delays call to ensure that all icons are loaded
  vim.defer_fn(redefine_icons, 1000)
end

function M.get_service_icons()
  redefine_icons() -- ensure all icons are set
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
    ruby_ls = grep_icon("rb"), -- deprecated lsp
    ruby_lsp = grep_icon("rb"),
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
