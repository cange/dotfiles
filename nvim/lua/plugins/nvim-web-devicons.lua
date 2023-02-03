---@param filetype string
---@param name string
---@param opts? table<string, string|boolean>
---@return table
local function create_icon_by_filetype(filetype, name, opts)
  local devicons = require("nvim-web-devicons")
  local ft_icon, color = devicons.get_icon_color_by_filetype(filetype)
  local _, cterm = devicons.get_icon_cterm_color_by_filetype(filetype)
  local icon = Cange.get_icon("ui.Beaker")

  if opts ~= nil then
    color = opts.color == nil and color or opts.color
    cterm = opts.cterm_color == nil and cterm or opts.cterm_color
    icon = opts.icon == nil and icon or ft_icon
  end

  return { icon = icon, color = color, cterm_color = cterm, name = name }
end

return {
  "nvim-tree/nvim-web-devicons", -- File icons
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
