-- enable change immediately
local found_cmp, cmp = pcall(require, 'cmp')
if not found_cmp then return end

local found_ls, ls = pcall(require, 'luasnip')
if not found_ls then
  vim.notify('cmp.config: "luasnip" could not be found')
  return
end

local found_icons, icons = pcall(require, 'cange.icons')
if not found_icons then
  vim.notify('cmp.config: "cange.icons" could not be found')
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


local found_tabnine, _ = pcall(require, 'cmp_tabnine.config')
if not found_tabnine then
  vim.notify('cmp: "cmp_tabnine.config" could not be found')
  return
end

-- local found_theme, theme_palette = pcall(require, 'nightfox.palette')
-- if not found_theme then return end
-- local color = theme_palette.load('terafox')
-- vim.pretty_print(color)

local source_types = {
  buffer =      { icon = icons.cmp_source.buffer,   fg = '#587b7b', group_name = 'CmpItemKindBuffer' },
  nvim_lsp =    { icon = icons.cmp_source.nvim_lsp, fg = '#587b7b', group_name = 'CmpItemKindLSP' },
  nvim_lua =    { icon = icons.cmp_source.nvim_lua, fg = '#587b7b', group_name = 'CmpItemKindLua' },
  cmp_tabnine = { icon = icons.misc.Robot,          fg = '#587b7b', group_name = 'CmpItemKindAI' },
  luasnip =     { icon = ' ',                       fg = '#587b7b', group_name = 'CmpItemKindSnippet' },
  path =        { icon = icons.cmp_source.path,     fg = '#587b7b', group_name = 'CmpItemKindPath' },
}

for _, type in pairs(source_types) do
  vim.api.nvim_set_hl(0, type.group_name, { fg = type.fg })
end

local function menu_item_format(entry, vim_item)
  local name = entry.source.name
  if vim.tbl_contains(vim.tbl_keys(source_types), name) then
    vim_item.menu = source_types[name].icon
    vim_item.menu_hl_group = source_types[name].group_name
  end
  vim_item.kind = icons.kind[vim_item.kind]
  return vim_item
end

local ignore_filetypes = {
  'json',
  'markdown',
  'toml',
  'txt',
  'yaml',
}
local max_item_count = 3
local sources = {
  { name = 'nvim_lsp', group_index = 1, max_item_count = max_item_count },
  { name = 'nvim_lua', group_index = 2, max_item_count = max_item_count },
  { name = 'luasnip', group_index = 1, max_item_count = max_item_count },
  { name = 'cmp_tabnine', group_index = 3, max_item_count = max_item_count },
  { name = 'path', group_index = 4, max_item_count = max_item_count },
  {
    name = 'buffer',
    max_item_count = max_item_count,
    group_index = 3,
    filter = function(_, ctx)
      return not vim.tbl_contains(ignore_filetypes, ctx.prev_context.filetype)
    end,
  },
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
    fields = { -- order within a menu item
      'abbr',
      'kind',
      'menu',
    },
    format = menu_item_format,
  },
  sources = sources,
}
