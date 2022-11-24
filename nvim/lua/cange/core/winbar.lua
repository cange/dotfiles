local ns = "[cange.core.winbar]"
local found_navic, navic = pcall(require, "nvim-navic")
if not found_navic then
  print(ns, '"nvim-navic" not found')
  return
end
local found_web_devicons, web_devicons = pcall(require, "nvim-web-devicons")
if not found_web_devicons then
  print(ns, '"nvim-web-devicons" not found')
  return
end
local found_utils, utils = pcall(require, "cange.utils")
if not found_utils then
  print(ns, '"cange.utils" not found')
  return
end
local separator = utils.get_icon("ui", "ChevronRight")
-- Setup

navic.setup({
  icons = utils.get_icon("kind"),
  highlight = true,
  separator = " ",
  depth_limit = 0,
  depth_limit_indicator = "..",
})

-- Config
local function str_is_empty(s)
  return s == nil or s == ""
end

---Identified name and path of the given file.
---@param opts? table
---@return string
local function get_filename(opts)
  opts = opts or { path = 0 }
  local filename = vim.fn.expand("%:t")
  local extension = vim.fn.expand("%:e")
  local filepath = filename

  if opts.path == 1 then
    local dir_parts = vim.split(vim.fn.expand("%:h"), "/", { plain = true })
    local parent_dir = dir_parts[#dir_parts] or ""
    filepath = parent_dir .. "/" .. filepath
  end

  if not str_is_empty(filename) then
    local file_icon, file_icon_color = web_devicons.get_icon_color(filename, extension, { default = true })
    local hl_group = "FileIconColor" .. extension

    vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })
    if str_is_empty(file_icon) then
      file_icon = utils.get_icon("kind", "File")
    end

    local navic_text = vim.api.nvim_get_hl_by_name("Normal", true)
    vim.api.nvim_set_hl(0, "Winbar", { fg = navic_text.foreground })

    return " " .. "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " " .. "%#Winbar#" .. filepath .. "%*"
  end

  return ""
end

local function get_location()
  if not navic.is_available() then
    return ""
  end

  local location = navic.get_location()
  if location == "" or location == "error" then
    return ""
  end

  return separator .. location
end

local function is_excluded()
  local excludes = {
    "Markdown",
    "NvimTree",
    "Outline",
    "alpha",
    "help",
    "packer",
    "toggleterm",
    "",
  }
  return vim.tbl_contains(excludes, vim.bo.filetype)
end

local function get_buf_option(opt)
  local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
  if not status_ok then
    return nil
  else
    return buf_option
  end
end

---Generates breadcrumb based on the current line of cursor
function WinbarBreadcrumbRedraw()
  if is_excluded() then
    return
  end
  local value = get_filename()

  local location_added = false
  if not str_is_empty(value) then
    local location = get_location()

    value = value .. " " .. location
    location_added = not str_is_empty(location)
  end

  if not str_is_empty(value) and get_buf_option("mod") then
    local mod = "%#LspCodeLens#" .. utils.get_icon("ui", "Circle") .. "%*"
    if location_added then
      value = value .. " " .. mod
    else
      value = value .. mod
    end
  end

  local num_tabs = #vim.api.nvim_list_tabpages()

  if num_tabs > 1 and not str_is_empty(value) then
    local tabpage_number = tostring(vim.api.nvim_tabpage_get_number(0))
    value = value .. "%=" .. tabpage_number .. "/" .. tostring(num_tabs)
  end

  -- vim.pretty_print(ns, 'WinbarBreadcrumbRedraw', value)
  local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
  if not status_ok then
    return
  end
end

local highlight_links = {
  NavicText = { link = "Normal" },
  NavicSeparator = { link = "Comment" },
}

for name, highlight_link in pairs(utils.get_symbol_kind_hl()) do
  highlight_links["NavicIcons" .. name] = highlight_link
end

utils.set_hls(highlight_links)

-- Autocommands
local events = {
  "BufFilePost",
  "BufWinEnter",
  "BufWritePost",
  "CursorHold",
  "CursorMoved",
  "InsertEnter",
  "TabClosed",
}

vim.api.nvim_create_autocmd(events, {
  group = vim.api.nvim_create_augroup("cange_winbar", { clear = true }),
  callback = function()
    local status_ok, _ = pcall(vim.api.nvim_buf_get_var, 0, "lsp_floating_window")
    if not status_ok then
      WinbarBreadcrumbRedraw()
    end
  end,
})
-- public

---@module 'winbar'
local M = {}

---Allow to attach to LSP config
---@param client table
---@param bufnr integer
function M.attach(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    vim.g.navic_silence = true
    navic.attach(client, bufnr)
  end
end

return M
