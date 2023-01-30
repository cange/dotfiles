return {
  "kyazdani42/nvim-web-devicons", -- File icons
  config = function()
    local devicons = require("nvim-web-devicons")
    Cange = Cange or require("cange.utils")
    devicons.setup()

    local function get_test_icon_by_filetype(filetype)
      local _, hex = devicons.get_icon_color_by_filetype(filetype)
      local _, cterm = devicons.get_icon_cterm_color_by_filetype(filetype)
      local icon = Cange.get_icon("ui.Test", { trim = true })

      return { icon = icon, color = hex, cterm_color = cterm, name = "Test_" .. filetype }
    end

    devicons.set_icon({ ["spec.js"] = get_test_icon_by_filetype("javascript") })
    devicons.set_icon({ ["test.js"] = get_test_icon_by_filetype("javascript") })
    devicons.set_icon({ ["cy.js"] = get_test_icon_by_filetype("javascript") })
    devicons.set_icon({ ["spec.ts"] = get_test_icon_by_filetype("typescript") })
    devicons.set_icon({ ["test.ts"] = get_test_icon_by_filetype("typescript") })
    devicons.set_icon({ ["cy.ts"] = get_test_icon_by_filetype("typescript") })
  end,
}
