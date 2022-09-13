-- enable change immediately
local found_cmp, cmp = pcall(require, 'cmp')
if not found_cmp then
  return
end

---Settings for cpm setup
---@class CmpConfig
local M = {}

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

local found_tabnine, _ = pcall(require, 'cmp_tabnine.config')
if not found_tabnine then
  vim.notify('cmp: "cmp_tabnine.config" could not be found')
  return
end

local function check_backspace()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

M.next_item = function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
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

M.prev_item = function(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  elseif ls.jumpable(-1) then
    ls.jump(-1)
  else
    fallback()
  end
end

local function menu_item_format(entry, vim_item)
  local source_types = {
    buffer =      { icon = icons.cmp_source.buffer },
    nvim_lsp =    { icon = icons.cmp_source.nvim_lsp },
    nvim_lua =    { icon = icons.cmp_source.nvim_lua },
    cmp_tabnine = { icon = icons.misc.Robot },
    luasnip =     { icon = ' ' },
    path =        { icon = icons.cmp_source.path },
  }

  local name = entry.source.name
  if vim.tbl_contains(vim.tbl_keys(source_types), name) then
    vim_item.menu = source_types[name].icon
    vim_item.menu_hl_group = 'Comment' -- asign appropriate theme color
  end
  vim_item.kind = icons.kind[vim_item.kind]
  return vim_item
end

M.props = {
  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
  window = {
    completion = {
      col_offset = -2, -- align abbr text with kind icons in prefix
    },
  },
  formatting = {
    fields = { -- order within a menu item
      'kind',
      'abbr',
      'menu',
    },
    format = menu_item_format,
  },
  sources = {
    { name = 'cmp_tabnine', group_index = 3, max_item_count = 5 },
    { name = 'luasnip',     group_index = 1, max_item_count = 5 },
    { name = 'nvim_lsp',    group_index = 1, max_item_count = 5 },
    { name = 'nvim_lua',    group_index = 2, max_item_count = 5 },
    { name = 'path',        group_index = 4, max_item_count = 5 },
    {
      name = 'buffer',
      group_index = 3,
      max_item_count = 5,
      filter = function(_, ctx)
        local ignore_filetypes = {
          'json',
          'markdown',
          'toml',
          'txt',
          'yaml',
        }
        return not vim.tbl_contains(ignore_filetypes, ctx.prev_context.filetype)
      end,
    },
  },
}

return M
