-- enable change immediately
local found_cmp, cmp = pcall(require, 'cmp')
if not found_cmp then return end

local found_ls, ls = pcall(require, 'luasnip')
if not found_ls then return end

local icons_found, icons = pcall(require, 'cange.icons')
if not icons_found then return end

local found_utils, table = pcall(require, 'cange.utils.table')
if not found_utils then
  vim.notify('cmp.config: "cange.utils" could not be found')
  return
end

local function check_backspace()
  local col = vim.fn.col '.' - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s'
end

local function handle_next_item(fallback)
  if cmp.visible() then
    cmp.select_next_item()
    -- elseif ls.choice_active() then -- travel forwards within choices
    --   ls.change_choice(1)
  elseif ls.expandable() then
    ls.expand()
  elseif ls.expand_or_jumpable() then
    ls.expand_or_jump()
  elseif check_backspace() then
    fallback()
  else
    fallback()
  end
end

local function handle_prev_item(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
    -- elseif ls.choice_active() then -- travel backwards within choices
    --   ls.change_choice(-1)
  elseif ls.jumpable(-1) then
    ls.jump(-1)
  else
    fallback()
  end
end

local buffer_ignore = {
  'json',
  'markdown',
  'toml',
  'txt',
  'yaml',
}

local found_tabnine, _ = pcall(require, 'cmp_tabnine.config')
if not found_tabnine then
  vim.notify('cmp: "cmp_tabnine.config" could not be found')
  return
end

local source_types = {
  buffer =      { icon = icons.cmp_source.buffer,   color = '#F4A261', group = 'CmpItemKindBuffer' },
  nvim_lsp =    { icon = icons.cmp_source.nvim_lsp, color = '#DBC074', group = 'CmpItemKindLSP' },
  cmp_tabnine = { icon = icons.misc.Robot,          color = '#81B29A', group = 'CmpItemKindAI' },
  luasnip =     { icon = icons.kind.Snippet,        color = '#AEAFB0', group = 'CmpItemKindSnippet' },
  path =        { icon = icons.cmp_source.path,     color = '#71839B', group = 'CmpItemKindPath' },
}
for _, type in pairs(source_types) do
  vim.api.nvim_set_hl(0, type.group, { fg = type.color })
end

local function menu_item_format(entry, vim_item)
  local name = entry.source.name
  if table.contains_key(source_types, name) then
    vim_item.menu = source_types[name].icon
    vim_item.menu_hl_group = source_types[name].group
  end
  if vim_item.kind == 'Snippet' then -- keep empty on certain type
    vim_item.kind = '  '
  else
    vim_item.kind = string.format('%s ', icons.kind[vim_item.kind])
  end
  return vim_item
end

local sources = {
  {
    name = 'nvim_lsp',
    filter = function(entry, ctx)
      local kind = require('cmp.types.lsp').CompletionItemKind[entry:get_kind()]
      if kind == 'Snippet' and ctx.prev_context.filetype == 'java' then
        return true
      end

      if kind == 'Text' then
        return true
      end
    end,
    group_index = 2,
  },
  { name = 'luasnip', group_index = 2 },
  {
    name = 'buffer',
    group_index = 2,
    filter = function(_, ctx)
      return not table.contains(buffer_ignore, ctx.prev_context.filetype)
    end,
  },
  { name = 'cmp_tabnine', group_index = 2 },
  { name = 'path', group_index = 2 },
}

return {
  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  handlers = {
    next_item = handle_next_item,
    prev_item = handle_prev_item,
  },
  formatting = {
    fields = { 'abbr', 'kind', 'menu' }, -- order within a menu item
    format = menu_item_format,
  },
  sources = sources,
}
