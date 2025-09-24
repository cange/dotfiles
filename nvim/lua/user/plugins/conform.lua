local function update_format_on_save()
  local ok, conform = pcall(require, "conform")
  if not ok then error('formatting: could not found "conform"') end
  local opts = { format_on_save = nil }
  if User.get_config("lsp.format_on_save") then
    opts = {
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 1000,
      },
    }
  end
  conform.setup(opts)
end

local function toggle_format_on_save()
  local new_state = not User.get_config("lsp.format_on_save")
  Notify.info(new_state and "enabled" or "disabled", { title = "Auto format on save" })
  User.set_config("lsp.format_on_save", new_state)
  update_format_on_save()
end

-- NOTE: formatter installation handled via mason
local prettier_preset = { "prettier", stop_after_first = true }
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {

      bash = { "shfmt" },
      css = prettier_preset,
      html = { "html" },
      json = prettier_preset,
      jsonc = prettier_preset,
      lua = { "stylua" },
      markdown = prettier_preset,
      scss = prettier_preset,
      shell = { "shfmt" },
      svg = { "html" },
      xml = { "html" },
      yaml = prettier_preset,
      zsh = { "shfmt" },
      -- ruby/rails
      eruby = { "html" },
      ruby = { "rubocop" },
      -- js
      javascript = prettier_preset,
      javascriptreact = prettier_preset,
      svelte = prettier_preset,
      typescript = prettier_preset,
      typescriptreact = prettier_preset,
      vue = prettier_preset,
      ["_"] = { "trim_whitespace" },
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)
    update_format_on_save()
  end,
  keys = {
    { "<Leader>e3", "<cmd>ConformInfo<CR>", desc = "Formatter info" },
    { "<leader>F", '<cmd>lua require("conform").format({ async = true })<CR>', desc = "Format" },
    { "<Leader><LocalLeader>f", toggle_format_on_save, desc = "Toggle Format on Save" },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
