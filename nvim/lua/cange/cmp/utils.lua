local i = Cange.get_icon

---Provides prediction strength as an icon
---@param percentage string Number of strength
---@return string|nil
local function get_prediction_strength_kind_icon(percentage)
  if percentage and percentage ~= "" then
    local fraction_num = math.modf(tonumber(percentage:match("%d+")) / 10) + 1
    local icons = i("sets.batteries")
    ---@diagnostic disable-next-line: param-type-mismatch
    return vim.split(icons, " ")[fraction_num]
  end

  return nil
end

---Define appropriate highlight color group
---@param source_name string
---@return string
local function get_menu_hl_group_by(source_name)
  local groups = {
    cmp_tabnine = "CmpItemMenuTabnine",
    copilot = "CmpItemMenuCopilot",
    luasnip = "CmpItemMenu",
    nvim_lua = "CmpItemMenuLua",
    nvim_lsp = "CmpItemMenu",
    nvim_lsp_signature_help = "CmpItemMenu",
  }

  return vim.tbl_contains(vim.tbl_keys(groups), source_name) and groups[source_name] or "@comment"
end

local M = {}

---@see cmp.FormattingConfig
function M.format(entry, vim_item)
  local maxwidth = 80
  local src_icons = {
    buffer = i("ui.Database"),
    cmp_tabnine = i("ui.Tabnine"),
    copilot = i("ui.Copilot"),
    luasnip = i("ui.Library"),
    nvim_lsp = i("ui.Globe"),
    nvim_lsp_signature_help = i("ui.Ellipsis"),
    nvim_lua = i("extensions.Lua"),
    path = i("ui.Path"),
  }
  local src_name = entry.source.name
  local cmp_item = entry.completion_item or {}
  local strength = ""
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

  if src_name == "cmp_tabnine" then
    ---@see https://github.com/tzachar/cmp-tabnine#show_prediction_strength
    local detail = (cmp_item.labelDetails or {}).detail

    is_multiline = (cmp_item.data or {}).multiline
    strength = detail and detail:find(".*%%.*") and detail or ""
  end

  ---@diagnostic disable-next-line: param-type-mismatch
  local kinds = i("cmp_kinds") or {}
  local strength_icon = get_prediction_strength_kind_icon(strength)
  local kind_icon = strength_icon
    or kinds[vim_item.kind]
    or i("cmp_kinds." .. (is_multiline and "MultiLine" or "SingleLine"))

  vim_item.kind = kind_icon .. " "
  vim_item.abbr = vim_item.abbr:sub(1, maxwidth)
  vim_item.menu = vim.tbl_contains(vim.tbl_keys(src_icons), src_name) and src_icons[src_name] .. " " or vim_item.menu
  vim_item.menu_hl_group = get_menu_hl_group_by(src_name)

  return vim_item
end

return M
