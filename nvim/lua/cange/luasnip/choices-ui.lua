-- https://github.com/L3MON4D3/LuaSnip/wiki/Misc#choicenode-popup
local found, luasnip = pcall(require, 'luasnip')
if not found then
  return
end

local ns_id = vim.api.nvim_create_namespace('LuasnipChoiceListSelections')
local win_close = vim.api.nvim_win_close
local del_extmark = vim.api.nvim_buf_del_extmark

local function create_window(choice_node)
  local buffer = vim.api.nvim_create_buf(false, true)
  local buf_text = {}
  local option_row = 0
  local option_col = 0
  local row_offset = 0
  local text
  for _, node in ipairs(choice_node.choices) do
    text = node:get_docstring()
    -- find one that is currently showing
    if node == choice_node.active_choice then
      -- current line is starter from buffer list which is length usually
      option_row = #buf_text
      -- finding how many lines total within a choice selection
      row_offset = #text
    end
    vim.list_extend(buf_text, text)
  end

  vim.api.nvim_buf_set_text(buffer, 0, 0, 0, 0, buf_text)
  local width, height = vim.lsp.util._make_floating_popup_size(buf_text, {})

  -- adding highlight so we can see which one is been selected.
  local extmark_opts = { hl_group = 'incsearch', end_line = option_row + row_offset }
  local extmark = vim.api.nvim_buf_set_extmark(buffer, ns_id, option_row, option_col, extmark_opts)

  -- shows window at a beginning ofchoice_node.
  local win_id = vim.api.nvim_open_win(buffer, false, {
    relative = 'win',
    width = width,
    height = height,
    bufpos = choice_node.mark:pos_begin_end(),
    style = 'minimal',
    border = 'none', -- none, single, double, rounded, solid, shadow
  })
  -- return with 3 main important so we can use them again
  return { win_id = win_id, extmark = extmark, buf = buffer }
end

function CangeSnippetChoiceOpen()
  local win = M._win
  local choice_node = luasnip.session.event_node
  -- build stack for nested choiceNodes.
  if win then
    win_close(win.win_id, true)
    del_extmark(win.buf, ns_id, win.extmark)
  end
  local create_win = create_window(choice_node)
  win = {
    win_id = create_win.win_id,
    prev_win = win,
    node = choice_node,
    extmark = create_win.extmark,
    buf = create_win.buf,
  }
end

function CangeSnippetChoiceUpdate()
  local choice_node = luasnip.session.event_node
  local win = M._win
  win_close(win.win_id, true)
  del_extmark(win.buf, ns_id, win.extmark)
  local created_win = create_window(choice_node)
  win.win_id = created_win.win_id
  win.extmark = created_win.extmark
  win.buf = created_win.buf
end

function CangeSnippetChoiceClose()
  local win = M._win
  -- vim.pretty_print('window id', win.win_id)
  win_close(win.win_id, true)
  del_extmark(win.buf, ns_id, win.extmark)
  -- now we are checking if we still have previous choice we were in after exit nested choice
  M._win = win.prev_win
  win = M._win
  if win then
    -- reopen window further down in the stack.
    local created_win = create_window(win.node)
    win.win_id = created_win.win_id
    win.extmark = created_win.extmark
    win.buf = created_win.buf
  end
end

local M = {}

M._win = nil

M.close = CangeSnippetChoiceClose

function M.setup()
  -- Autocommands
  local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
  local autocmd = vim.api.nvim_create_autocmd

  augroup('luasnip_choice_options', { clear = true })
  autocmd('User', {
    pattern = 'LuasnipChoiceNodeEnter',
    callback = CangeSnippetChoiceOpen,
  })
  autocmd('User', {
    pattern = 'LuasnipChoiceNodeLeave',
    callback = CangeSnippetChoiceClose,
  })
  autocmd('User', {
    pattern = 'LuasnipChangeChoice',
    callback = CangeSnippetChoiceUpdate,
  })
  autocmd('User', {
    pattern = {
      'LuasnipCleanup',
      'LuasnipDynamicNodeLeave',
      'LuasnipInsertNodeLeave',
    },
    callback = CangeSnippetChoiceClose,
  })
end

return M
