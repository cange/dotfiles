---@class Cange.utils.Icons

---@class Cange.utils.Icons.Preset
---@field icon? Cange.core.Icons
---@field color? string Hex color value
---@field cterm_color? string
---@field name? string

---@type Cange.utils.Icons
local m = {}
local ns = "[cange.utils.icons]"

---@param name string
---@return string|nil
local function get_single_icon(icon_list, name)
  local result = icon_list and icon_list[name] or nil

  if not result then
    vim.pretty_print(ns, name, "not found")
    return nil
  end
  return result
end

---@param group_id string Dot separated identifier path of `Cange.core.icons`
---@param ... string|table List of parts the actual icon path. Use last argument as options if tables i past
---@return table|string|nil # The icon symbol or nil if not found
function m.get_icon(group_id, ...)
  local ok, icons = pcall(require, "cange.core.icons")
  if not ok then
    print(ns, '"cange.core.icons" not found!')
  end
  local parts = { ... }
  local last_item = parts[#parts]

  if type(last_item) == "table" then
    table.remove(parts, #parts)
  end

  local group_parts = vim.split(group_id, "%.")
  if #group_parts > 1 then
    parts = vim.list_extend(group_parts, parts)
    group_id = table.remove(parts, 1)
  end

  ---@diagnostic disable-next-line: cast-local-type
  icons = get_single_icon(icons, group_id)
  if #parts > 0 then
    for _, icon_name in ipairs(parts) do
      ---@diagnostic disable-next-line: cast-local-type, param-type-mismatch
      icons = get_single_icon(icons, icon_name)
    end
  end

  if type(icons) == "string" then
    ---@diagnostic disable-next-line: cast-local-type
    icons = vim.trim(icons)
  end

  return icons
end

---@param filetype string
---@param name string
---@param opts? Cange.utils.Icons.Preset
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

---@type Cange.utils.Icons.Preset[]
local presets = {
  spec = {
    icon = m.get_icon("ui.Beaker"),
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
    print(ns, '"nvim-web-devicons" not found!')
    return
  end

  devicons.set_icon({ ["cy.js"] = create_icon_by_filetype("javascript", "TestJs", presets.spec) })
  devicons.set_icon({ ["spec.js"] = create_icon_by_filetype("javascript", "TestJs", presets.spec) })
  devicons.set_icon({ ["test.js"] = create_icon_by_filetype("javascript", "TestJs", presets.spec) })

  devicons.set_icon({ ["cy.ts"] = create_icon_by_filetype("typescript", "TestTs", presets.spec) })
  devicons.set_icon({ ["spec.ts"] = create_icon_by_filetype("typescript", "TestTs", presets.spec) })
  devicons.set_icon({ ["test.ts"] = create_icon_by_filetype("typescript", "TestTs", presets.spec) })

  devicons.set_icon({ ["stories.js"] = create_icon_by_filetype("javascript", "StorybookJs", presets.storybook) })
  devicons.set_icon({ ["stories.ts"] = create_icon_by_filetype("typescript", "StorybookTs", presets.storybook) })
  devicons.set_icon({ ["stories.mdx"] = create_icon_by_filetype("mdx", "StorybookMdx", presets.storybook) })
end

function m.setup()
  redefine_icons()
end

return m
