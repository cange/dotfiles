-- Reloads this file whenever a 'json' file saved in snippet directory to
-- enable change immediately
vim.cmd [[
  augroup cmp_autoreload
  autocmd!
  autocmd BufWritePost ~/dotfiles/nvim/snippets/**/*.json source ~/dotfiles/nvim/after/plugin/cmp.rc.lua
  augroup end
]]

local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then return end

local ls_ok, ls = pcall(require, "luasnip")

if not ls_ok then return end

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

--    ﯟ   some other good icons
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "ﰠ",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

local source_menu_icons = {
  nvim_lsp = "",
  luasnip = "",
  buffer = "﬘",
  path = "",
}

-- find more here: https://www.nerdfonts.com/cheat-sheet

local handle_next_tab = function(fallback)
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
local handle_prev_tab = function(fallback)
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

return cmp.setup {
  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ["<C-up>"] = cmp.mapping.select_prev_item(),
    ["<C-down>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<down>"] = cmp.mapping(handle_next_tab, { "i", "s" }),
    ["<Tab>"] = cmp.mapping(handle_next_tab, { "i", "s" }),
    ["<up>"] = cmp.mapping(handle_prev_tab, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(handle_prev_tab, { "i", "s" }),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      -- Source icons
      vim_item.menu = (source_menu_icons)[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = "nvim_lsp" }, -- we want to LSP suggestion first
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    documentation = cmp.config.window.bordered(),
  },
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
}
