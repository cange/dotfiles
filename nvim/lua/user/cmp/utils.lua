local icons = require("user.icons")

local M = {}

---@see cmp.FormattingConfig
function M.format(entry, vim_item)
  local maxwidth = 80
  local src_icons = {
    buffer = icons.ui.Database,
    copilot = icons.plugin.Copilot,
    luasnip = icons.ui.Library,
    nvim_lsp = icons.ui.Globe,
    nvim_lua = icons.extensions.Lua,
    path = icons.ui.Path,
  }
  local src_name = entry.source.name
  local cmp_item = entry.completion_item or {}
  local is_multiline = false

  -- Show filetype icons for path source
  if vim.tbl_contains({ "path" }, entry.source.name) then
    local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
    if icon then
      vim_item.kind = icon
      vim_item.kind_hl_group = hl_group
      return vim_item
    end
  end

  if src_name == "copilot" then
    is_multiline = ((cmp_item.documentation or {}).value or ""):find(".*\n.+\n.+\n") ~= nil
  end

  ---@diagnostic disable-next-line: param-type-mismatch
  local kinds = icons.cmp_kinds or {}
  local kind_icon = kinds[vim_item.kind] or icons.cmp_kinds[is_multiline and "MultiLine" or "SingleLine"]

  vim_item.kind = kind_icon .. " "
  vim_item.abbr = vim_item.abbr:sub(1, maxwidth)
  vim_item.menu = vim.tbl_contains(vim.tbl_keys(src_icons), src_name) and src_icons[src_name] .. " " or vim_item.menu

  return vim_item
end

return M
