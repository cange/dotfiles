-- https://github.com/L3MON4D3/LuaSnip/wiki/Misc#choicenode-popup
local ls_ok, ls = pcall(require, "luasnip")
if not ls_ok then return end

local current_nsid = vim.api.nvim_create_namespace("LuaSnipChoiceListSelections")
local current_win = nil

local function window_for_choice_node(choice_node)
  local buf = vim.api.nvim_create_buf(false, true)
  local buf_text = {}
  local row_selection = 0
  local row_offset = 0
  local text
  for _, node in ipairs(choice_node.choices) do
    text = node:get_docstring()
    -- find one that is currently showing
    if node == choice_node.active_choice then
      -- current line is starter from buffer list which is length usually
      row_selection = #buf_text
      -- finding how many lines total within a choice selection
      row_offset = #text
    end
    vim.list_extend(buf_text, text)
  end

  vim.api.nvim_buf_set_text(buf, 0, 0, 0, 0, buf_text)
  local w, h = vim.lsp.util._make_floating_popup_size(buf_text)

  -- adding highlight so we can see which one is been selected.
  local extmark = vim.api.nvim_buf_set_extmark(buf, current_nsid, row_selection, 0,
    { hl_group = 'incsearch', end_line = row_selection + row_offset })

  -- shows window at a beginning of choice_node.
  local win = vim.api.nvim_open_win(buf, false, {
    relative = "win", width = w, height = h, bufpos = choice_node.mark:pos_begin_end(), style = "minimal",
    border = 'rounded'
  })

  -- return with 3 main important so we can use them again
  return { win_id = win, extmark = extmark, buf = buf }
end

local win_close = vim.api.nvim_win_close
local del_extmark = vim.api.nvim_buf_del_extmark

function LUASNIP_CHOICE_POPUP(choice_node)
  -- build stack for nested choiceNodes.
  if current_win then
    win_close(current_win.win_id, true)
    del_extmark(current_win.buf, current_nsid, current_win.extmark)
  end
  local create_win = window_for_choice_node(choice_node)
  current_win = {
    win_id = create_win.win_id,
    prev = current_win,
    node = choice_node,
    extmark = create_win.extmark,
    buf = create_win.buf
  }
end

function LUASNIP_UPDATE_CHOICE_POPUP(choice_node)
  win_close(current_win.win_id, true)
  del_extmark(current_win.buf, current_nsid, current_win.extmark)
  local create_win = window_for_choice_node(choice_node)
  current_win.win_id = create_win.win_id
  current_win.extmark = create_win.extmark
  current_win.buf = create_win.buf
end

function LUASNIP_CHOICE_POPUP_CLOSE()
  win_close(current_win.win_id, true)
  del_extmark(current_win.buf, current_nsid, current_win.extmark)
  -- now we are checking if we still have previous choice we were in after exit nested choice
  current_win = current_win.prev
  if current_win then
    -- reopen window further down in the stack.
    local create_win = window_for_choice_node(current_win.node)
    current_win.win_id = create_win.win_id
    current_win.extmark = create_win.extmark
    current_win.buf = create_win.buf
  end
end

vim.cmd([[
  augroup luasnip_choice_popup
  au!
  au User LuasnipChoiceNodeEnter lua LUASNIP_CHOICE_POPUP(require("luasnip").session.event_node)
  au User LuasnipChoiceNodeLeave lua LUASNIP_CHOICE_POPUP_CLOSE()
  au User LuasnipChangeChoice lua LUASNIP_UPDATE_CHOICE_POPUP(require("luasnip").session.event_node)
  augroup end
]])
