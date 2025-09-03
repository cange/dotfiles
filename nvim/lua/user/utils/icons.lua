local M = {}
local ok, icons = pcall(require, "user.icons")
if not ok then error('"user.icons" not found!') end

---@type user.DevIconsPreset[]
local presets = {
  stylelint = { color = "#d0d0d0", cterm_color = "252", icon = icons.extensions.Stylelint, name = "StylelintConfig" },
  vue = { color = "#42b883" },
  yarn = { color = "#2c8ebb", cterm_color = "33", icon = icons.extensions.Yarn, name = "YarnPkg" },
}

local user_icons = {}
---@param origin_filetype string
---@param filename string
---@param extensions? string[]
---@param preset? user.DevIconsPreset
local function set_icon_by_filetype(origin_filetype, filename, extensions, preset)
  local devicons = require("nvim-web-devicons")
  local icon, name = devicons.get_icon(origin_filetype)
  local _, color = devicons.get_icon_color(origin_filetype)
  local _, cterm = devicons.get_icon_cterm_color(origin_filetype)

  local fallback = {
    color = color,
    cterm_color = cterm,
    icon = icon,
    name = name,
  }

  for _, ext in pairs(extensions or { "" }) do
    local fname = filename .. ext
    user_icons[fname] = vim.tbl_extend("force", fallback, preset or {})
    -- print(("[%s] %s"):format(fname, vim.inspect(user_icons[fname])):gsub("\n", " "))
  end
end

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

---@param extension string
---@return string
local function grep_icon(extension)
  local icon, _ = require("nvim-web-devicons").get_icon("", extension)
  return icon
end

local function redefine_icons()
  set_rc_file_icons("stylelint", { "", ".json", ".js", ".cjs", ".mjs", ".yaml", ".yml" }, { ".js", ".cjs", ".mjs" })

  set_icon_by_filetype("vue", "vue", nil, presets.vue)
  set_icon_by_filetype("yarn", ".yarn", { "", "rc.yml" }, presets.yarn)
  set_icon_by_filetype("yarn", "yarn.lock", nil, presets.yarn)

  for _, ext in pairs({ "eslintignore", "prettierignore", "gitignore" }) do
    set_icon_by_filetype("." .. ext, "." .. ext, nil, { color = "#6f7b81" })
  end

  require("nvim-web-devicons").set_icon(user_icons)
end

function M.setup()
  -- delays call to ensure that all icons are loaded
  vim.defer_fn(redefine_icons, 1000)
end

function M.get_service_icons()
  redefine_icons() -- ensure all icons are set

  return {
    cssls = grep_icon("css"),
    css_variables = grep_icon("css"),
    eslint = grep_icon(".eslintrc"),
    jsonlint = grep_icon("json"),
    jsonls = grep_icon("json"),
    lua_ls = grep_icon("lua"),
    markdownlint = grep_icon("md"),
    markdown_oxide = "ox" .. grep_icon("md"),
    markuplint = grep_icon("html"),
    prettier = grep_icon(".prettierrc"),
    prettierd = grep_icon(".prettierrc") .. " d",
    rubocop = grep_icon("rb"),
    ruby_lsp = grep_icon("rb"),
    stylelint = grep_icon(".stylelint"),
    stylua = grep_icon("lua"),
    superhtml = "s" .. grep_icon("html"),
    html = grep_icon("html"),
    tailwindcss = grep_icon("tailwind.config.js"),
    trim_whitespace = "󱁐",
    ts_ls = grep_icon("ts"),
    vue_ls = grep_icon("vue"),
    vtsls = "󰛦", -- nf-md-language_typescripts
    angularls = "󰚲", -- nf-md-angular
  }
end

return M
