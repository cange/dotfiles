local ns = "[cange.cmp.utils]"
local found_luasnip, luasnip = pcall(require, "luasnip")
if not found_luasnip then return end

local win_get_cursor = vim.api.nvim_win_get_cursor
local get_current_buf = vim.api.nvim_get_current_buf

---sets the current buffer's luasnip to the one nearest the cursor
---@return boolean true if a node is found, false otherwise
local function seek_luasnip_cursor_node()
  -- TODO(kylo252): upstream this
  -- for outdated versions of luasnip
  if not luasnip.session.current_nodes then return false end

  local node = luasnip.session.current_nodes[get_current_buf()]
  if not node then return false end

  local snippet = node.parent.snippet
  local exit_node = snippet.insert_nodes[0]

  local pos = win_get_cursor(0)
  pos[1] = pos[1] - 1

  -- exit early if we're past the exit node
  if exit_node then
    local exit_pos_end = exit_node.mark:pos_end()
    if (pos[1] > exit_pos_end[1]) or (pos[1] == exit_pos_end[1] and pos[2] > exit_pos_end[2]) then
      snippet:remove_from_jumplist()
      luasnip.session.current_nodes[get_current_buf()] = nil

      return false
    end
  end

  node = snippet.inner_first:jump_into(1, true)
  while node ~= nil and node.next ~= nil and node ~= snippet do
    local n_next = node.next
    local next_pos = n_next and n_next.mark:pos_begin()
    local candidate = n_next ~= snippet and next_pos and (pos[1] < next_pos[1])
      or (pos[1] == next_pos[1] and pos[2] < next_pos[2])

    -- Past unmarked exit node, exit early
    if n_next == nil or n_next == snippet.next then
      snippet:remove_from_jumplist()
      luasnip.session.current_nodes[get_current_buf()] = nil

      return false
    end

    if candidate then
      luasnip.session.current_nodes[get_current_buf()] = node
      return true
    end

    local ok, _ = pcall(node.jump_from, node, 1, true) -- no_move until last stop
    if not ok then
      snippet:remove_from_jumplist()
      luasnip.session.current_nodes[get_current_buf()] = nil

      return false
    end
  end

  -- No candidate, but have an exit node
  if exit_node then
    -- to jump to the exit node, seek to snippet
    luasnip.session.current_nodes[get_current_buf()] = snippet
    return true
  end

  -- No exit node, exit from snippet
  snippet:remove_from_jumplist()
  luasnip.session.current_nodes[get_current_buf()] = nil

  return false
end

---Provides prediction strength as an icon
---@param percentage string Number of strength
---@return string|nil
local function get_prediction_strength_kind_icon(percentage)
  if percentage and percentage ~= "" then
    local fraction_num = math.modf(tonumber(percentage:match("%d+")) / 10) + 1
    local icon = vim.split("         ", " ")[fraction_num] .. " "
    -- print(ns .. " strength:", percentage, icon)
    return icon
  end

  return nil
end

---Define appropriate highlight color group
---@param source_name string
---@return string
local function get_menu_hl_group_by(source_name)
  local groups = {
    cmp_tabnine = "CmpItemKindTabnine",
    copilot = "CmpItemKindCopilot",
  }

  return vim.tbl_contains(vim.tbl_keys(groups), source_name) and groups[source_name] or "Comment"
end

local M = {}

---when inside a snippet, seeks to the nearest luasnip field if possible, and checks if it is jumpable
---@param direction number 1 for forward, -1 for backward; defaults to 1
---@source https://github.com/LunarVim/LunarVim/blob/master/lua/lvim/core/cmp.lua
---@return boolean true if a jumpable luasnip field is found while inside a snippet
function M.jumpable(direction)
  if direction == -1 then
    return luasnip.in_snippet() and luasnip.jumpable(-1)
  else
    return luasnip.in_snippet() and seek_luasnip_cursor_node() and luasnip.jumpable(1)
  end
end

function M.has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

---@see cmp.FormattingConfig
function M.format(entry, vim_item)
  local maxwidth = 80
  local source_icons = Cange.get_icon("cmp_source") or {}
  local source_name = entry.source.name
  local strength = ""

  ---@see https://github.com/tzachar/cmp-tabnine#show_prediction_strength
  local tabnine_detail = (entry.completion_item.data or {}).detail
  if tabnine_detail and tabnine_detail:find(".*%%.*") then strength = tabnine_detail end

  ---@diagnostic disable-next-line: param-type-mismatch
  if vim.tbl_contains(vim.tbl_keys(source_icons), source_name) then
    vim_item.menu = vim.trim(source_icons[source_name])
  end
  local kinds = Cange.get_icon("cmp_kinds") or {}

  vim_item.kind = get_prediction_strength_kind_icon(strength) or kinds[vim_item.kind]
  vim_item.abbr = vim_item.abbr:sub(1, maxwidth)
  vim_item.menu_hl_group = get_menu_hl_group_by(source_name)

  return vim_item
end

return M
