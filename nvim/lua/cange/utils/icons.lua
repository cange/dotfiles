--#region Types

---@class cange.devIconsPreset
---@field icon? string Path of an icon shape
---@field color? string Hex color value
---@field cterm_color? string
---@field name? string

--#endregion

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

---@param filetype string
---@param name string
---@param opts? cange.devIconsPreset
---@return table
local function create_icon_by_filetype(filetype, name, opts)
  local devicons = require("nvim-web-devicons")
  local icon, color = devicons.get_icon_color_by_filetype(filetype)
  local _, cterm = devicons.get_icon_cterm_color_by_filetype(filetype)
  local config = {
    color = color,
    cterm_color = cterm,
    icon = icon,
    name = name,
  }

  opts = opts or {}

  return vim.tbl_extend("force", config, opts)
end

---@type cange.devIconsPreset[]
local presets = {
  spec = {
    icon = M.get_icon("ui.Beaker"),
  },
  storybook = {
    color = "#ff4785",
    cterm_color = "198",
    name = "Storybook",
  },
}

local function redefine_icons()
  local ok, devicons = pcall(require, "nvim-web-devicons")
  if not ok then
    Log:warn('"nvim-web-devicons" not found!', { title = ns })
    return
  end

  devicons.set_icon({ ["cy.js"] = create_icon_by_filetype("javascript", "TestJs", presets.spec) })
  devicons.set_icon({ ["cy.ts"] = create_icon_by_filetype("typescript", "TestTs", presets.spec) })

  devicons.set_icon({ ["stories.js"] = create_icon_by_filetype("javascript", "StorybookJs", presets.storybook) })
  devicons.set_icon({ ["stories.ts"] = create_icon_by_filetype("typescript", "StorybookTs", presets.storybook) })
  devicons.set_icon({ ["stories.mdx"] = create_icon_by_filetype("mdx", "StorybookMdx", presets.storybook) })
end

function M.setup() redefine_icons() end

return M
