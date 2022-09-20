local found_fidget, fidget = pcall(require, 'fidget')
if not found_fidget then
  return
end

local utils = _G.bulk_loader('utils', { { 'cange.icons', 'icons' } })
local function spinner_by_day_time()
  local h = tonumber(vim.fn.strftime('%k', vim.fn.localtime()))
  return h > 8 and h < 20 and 'earth' or 'moon'
end

fidget.setup({
  text = {
    spinner = spinner_by_day_time(),
    done = utils.icons.ui.Check,
  },
  align = {
    bottom = true,
  },
  window = {
    relative = 'editor',
  },
})
