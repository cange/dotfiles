-- Reloads this file whenever a 'json' file saved in snippet directory to
-- enable change immediately
vim.cmd([[
  augroup cmp_autoreload
  autocmd!
  autocmd BufWritePost ~/dotfiles/nvim/snippets/**/*.json source ~/dotfiles/nvim/after/plugin/cmp.rc.lua
  augroup end
]])

local found_cmp, cmp = pcall(require, 'cmp')
if not found_cmp then
  return
end

local found_config, config = pcall(require, 'cange.cmp.config')
if not found_config then
  print('[cmp.init] "cange.cmp.config" not found')
  return
end
local found_methods, custom_methods = pcall(require, 'cange.cmp.methods')
if not found_methods then
  print('[cmp.init] "cange.cmp.methods" not found')
  return
end
local found_luasnip, luasnip = pcall(require, 'luasnip')
if not found_luasnip then
  print('[cmp.init] "luasnip" not found')
  return
end
local function keymap(lhs, rhs)
  vim.keymap.set({ 'i', 's' }, lhs, rhs, { noremap = true, silent = true })
end

-- config
keymap('<C-[>', '<Plug>luasnip-prev-choice')
keymap('<C-]>', '<Plug>luasnip-next-choice')
keymap('<C-up>', '<Plug>luasnip-prev-choice')
keymap('<C-down>', '<Plug>luasnip-next-choice')

local settings = vim.tbl_extend('keep', config.props, {
  mapping = cmp.mapping.preset.insert({
    ['<C-up>'] = cmp.mapping.select_prev_item(),
    ['<C-down>'] = cmp.mapping.select_next_item(),
    ['<C-s>'] = mapping(mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-a>'] = mapping(mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
    ['<C-y>'] = cmp.mapping({
      i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
      c = function(fallback)
        if cmp.visible() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
          fallback()
        end
      end,
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif custom_methods.jumpable(1) then
        luasnip.jump(1)
      elseif custom_methods.has_words_before() then
        -- cmp.complete()
        fallback()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        local confirm_opts = { -- avoid mutating the original opts below
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }
        local is_insert_mode = function()
          return vim.api.nvim_get_mode().mode:sub(1, 1) == 'i'
        end
        if is_insert_mode() then -- prevent overwriting brackets
          confirm_opts.behavior = cmp.ConfirmBehavior.Insert
        end
        if cmp.confirm(confirm_opts) then
          return -- success, exit early
        end
      end

      if custom_methods.jumpable(1) and luasnip.jump(1) then
        return -- success, exit early
      end
      fallback() -- if not exited early, always fallback
    end),
  }),
})

cmp.setup(settings)
