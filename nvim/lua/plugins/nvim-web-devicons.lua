---@param filetype string
---@param name string
---@param opts? table<string, string|boolean>
---@return table
local function create_icon_by_filetype(filetype, name, opts)
  local devicons = require("nvim-web-devicons")
  local ft_icon, color = devicons.get_icon_color_by_filetype(filetype)
  local _, cterm = devicons.get_icon_cterm_color_by_filetype(filetype)
  local icon = Cange.get_icon("extension.test", { trim = true })

  if opts ~= nil then
    color = opts.color == nil and color or opts.color
    cterm = opts.cterm_color == nil and cterm or opts.cterm_color
    icon = opts.icon == nil and icon or ft_icon
  end

  return { icon = icon, color = color, cterm_color = cterm, name = name }
end

---@param filetype string
---@param subset table
---@return table
local function merge_iconset_by_filetype(filetype, subset)
  local devicons = require("nvim-web-devicons")
  local icon, color, cterm_color = devicons.get_icon_colors_by_filetype(filetype)

  return vim.tbl_extend("keep", subset, {
    icon = icon,
    color = color,
    cterm_color = cterm_color,
    name = devicons.get_icon_name_by_filetype(filetype),
  })
end

local ns = "[plugins/nvim-web-devicons]"
return {
  "kyazdani42/nvim-web-devicons", -- File icons
  config = function()
    Cange = Cange or require("cange.utils")
    local devicons = require("nvim-web-devicons")
    local preset = {
      storybook = {
        icon = true,
        color = "#ff4785",
        cterm_color = "198",
        name = "Storybook",
      },
    }

    devicons.setup()
    devicons.set_icon({
      ["js"] = merge_iconset_by_filetype("javascript", { icon = Cange.get_icon("extension.js", { trim = true }) }),
    })
    devicons.set_icon({
      ["ts"] = merge_iconset_by_filetype("typescript", { icon = Cange.get_icon("extension.ts", { trim = true }) }),
    })
    devicons.set_icon({
      ["storybook"] = vim.tbl_extend(
        "force",
        preset.storybook,
        { icon = Cange.get_icon("storybook", { trim = true }) }
      ),
    })
    devicons.set_icon({ ["stories.js"] = preset.storybook })
    -- order is important
    devicons.set_icon({ ["cy.js"] = create_icon_by_filetype("javascript", "TestJs") })
    devicons.set_icon({ ["spec.js"] = create_icon_by_filetype("javascript", "TestJs") })
    devicons.set_icon({ ["test.js"] = create_icon_by_filetype("javascript", "TestJs") })

    devicons.set_icon({ ["cy.ts"] = create_icon_by_filetype("typescript", "TestTs") })
    devicons.set_icon({ ["spec.ts"] = create_icon_by_filetype("typescript", "TestTs") })
    devicons.set_icon({ ["test.ts"] = create_icon_by_filetype("typescript", "TestTs") })

    devicons.set_icon({ ["stories.js"] = create_icon_by_filetype("javascript", "StorybookJs", preset.storybook) })
    devicons.set_icon({ ["stories.ts"] = create_icon_by_filetype("typescript", "StorybookTs", preset.storybook) })
    devicons.set_icon({ ["stories.mdx"] = create_icon_by_filetype("mdx", "StorybookMdx", preset.storybook) })
  end,
}
