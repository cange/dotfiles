local M = {}
local ok, icons = pcall(require, "user.icons")
if not ok then error('"user.icons" not found!') end

local user_icons = {}
---@param origin_filetype string
---@param filename string
---@param extensions? string[]
---@param preset? user.DevIconsPreset
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
---@type user.DevIconsPreset[]
local presets = {
  storybook = {
    color = "#ff4785",
    cterm_color = "198",
    name = "Storybook",
  },
  css = {
    icon = icons.extensions.Css,
    color = "#662f9a",
    cterm_color = "55",
    name = "CSS",
  },
  vue = {
    color = "#42b883",
    cterm_color = "29",
    name = "Vue",
  },
  nuxt = {
    icon = icons.extensions.Nuxt,
    color = "#00dc82",
    cterm_color = "35",
    name = "Nuxt",
  },
  babel = {
    icon = icons.extensions.Babelrc,
    name = "Babelrc",
  },
  cypress = {
    color = "#69d3a7",
    cterm_color = "24",
    name = "Cypress",
  },
  stylelint = {
    icon = icons.extensions.Stylelint,
    color = "#d0d0d0",
    cterm_color = "252",
    name = "StylelintConfig",
  },
  yarn = {
    icon = icons.extensions.Yarn,
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
  set_rc_file_icons("stylelint", { "", ".json", ".js", ".cjs", ".mjs", ".yaml", ".yml" }, { ".js", ".cjs", ".mjs" })

  set_icon_by_filetype("css", "css", nil, presets.css)
  set_icon_by_filetype("vue", "vue", nil, presets.vue)
  set_icon_by_filetype("yarn", ".yarn", { "", "rc.yml" }, presets.yarn)
  set_icon_by_filetype("yarn", "yarn.lock", nil, presets.yarn)

  for _, ext in pairs({ "js", "ts" }) do
    set_icon_by_filetype(ext, "nuxt.config." .. ext, nil, presets.nuxt)
    set_icon_by_filetype(ext, "stories." .. ext, nil, presets.storybook)
    set_icon_by_filetype(ext, "cypress.config", { ".js", ".cjs", ".mjs", ".ts" }, presets.cypress)
    set_icon_by_filetype(ext, "cy." .. ext, nil, presets.cypress)
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
    markuplint = grep_icon("html"),
    prettier = grep_icon(".prettierrc"),
    prettierd = grep_icon(".prettierrc") .. "d",
    rubocop = grep_icon("rb"),
    ruby_lsp = grep_icon("rb"),
    stylelint = grep_icon(".stylelint"),
    stylua = grep_icon("lua"),
    superhtml = grep_icon("html"),
    tailwindcss = grep_icon("tailwind.config.js"),
    trim_whitespace = "󱁐",
    ts_ls = grep_icon("ts"),
    vue_ls = grep_icon("vue"),
  }
end

return M
--#region Types

--#endregion
