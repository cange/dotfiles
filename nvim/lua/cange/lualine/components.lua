local config = require("cange.lualine.config")

local conditions = {
  hide_in_width = function()
    local window_width_limit = 100
    return vim.o.columns > window_width_limit
  end,
}

local M = {}

M.lsp = {
  function(msg)
    msg = msg or "LS Inactive"
    local buf_clients = vim.lsp.buf_get_clients()
    if next(buf_clients) == nil then
      -- TODO: clean up this if statement
      if type(msg) == "boolean" or #msg == 0 then
        return "LS Inactive"
      end
      return msg
    end
    local buf_ft = vim.bo.filetype
    local buf_client_names = {}

    -- add client
    for _, client in pairs(buf_clients) do
      if client.name ~= "null-ls" then
        table.insert(buf_client_names, client.name)
      end
    end

    -- add formatter
    -- local formatters = require('lvim.lsp.null-ls.formatters')
    -- - local supported_formatters = formatters.list_registered(buf_ft)
    local supported_formatters = {
      "stylua", -- lua
      "markdownlint", -- markdown
      "yamllint", -- yaml
    }
    vim.list_extend(buf_client_names, supported_formatters)

    -- add linter
    -- local linters = require('lvim.lsp.null-ls.linters')
    -- local supported_linters = linters.list_registered(buf_ft)
    local supported_linters = {
      "eslint_d", -- javascript
      "shfmt", -- shell
      "prettier", -- javascript, typepscript, etc
      "luaformatter", -- lua
      "yamlfmt", -- yaml
    }
    vim.list_extend(buf_client_names, supported_linters)

    local unique_client_names = vim.fn.uniq(buf_client_names)
    return table.concat(unique_client_names, ", ")
  end,

  separator = "",
  color = { gui = "bold" },
  cond = conditions.hide_in_width,
}

return M
