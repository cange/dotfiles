local ns = "[plugins.alpha]"
local Cange = require("cange.utils")

-- Startup

local function button(dashboard, key, label, cmd)
  local opts = {}
  local btn = dashboard.button(key, label, cmd, opts)
  btn.opts.hl_shortcut = "Macro"
  return btn
end

---Pick up designated keys from keymap groups
local function buttons(dashboard)
  local btns = {}
  for _, g in pairs(Cange.get_whichkey_group()) do
    for key, m in pairs(g.mappings) do
      if m.dashboard == true then
        table.insert(btns, button(dashboard, key, (Cange.get_icon(m.icon or "")) .. " " .. m.desc, m.cmd))
      end
    end
  end

  return btns
end

return {
  "goolord/alpha-nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  config = function()
    local dashboard = require("alpha.themes.dashboard")
    local section = dashboard.section

    section.buttons.val = buttons(dashboard)
    section.footer.val = Cange.get_random_greeting_for(Cange.get_config("author.display_name"))
    section.header.opts.hl = "Include"
    section.buttons.opts.hl = "Macro"
    section.footer.opts.hl = "Type"

    dashboard.opts.opts.noautocmd = true
    -- vim.cmd([[autocmd User AlphaReady echo 'ready']])
    require("alpha").setup(dashboard.opts)
  end,
}
