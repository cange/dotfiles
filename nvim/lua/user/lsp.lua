local M = {}

M._diagnostics = { virtual_types = { TEXT = "virtual_text", LINE = "virtual_lines" } }

local function toggle_diagnostics_virtual_type()
  local types = M._diagnostics.virtual_types
  local current_type = vim.g.user_diagnostics_virtual_type or User.get_config("lsp.diagnostics.virtual_type")
  local new_state = current_type ~= types.TEXT and types.TEXT or types.LINE
  Notify.info(new_state, { title = "Change diagnostic inline text" })
  vim.g.user_diagnostics_virtual_type = new_state
  require("user.lsp").update_diagnostics()
end

local function restart_all_clients()
  local bufnr = vim.api.nvim_get_current_buf()
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    local blacklist = { "copilot" }
    if client.attached_buffers[bufnr] and not vim.tbl_contains(blacklist, client.name) then
      vim.cmd("LspRestart " .. client.name)
    end
  end
end

function M.set_keymaps()
  -- stylua: ignore start
  local keymaps = {
    { "<Leader>e4", "<cmd>LspInfo<CR>",                desc = "LSP info"  },
    { "<Leader>dD", toggle_diagnostics_virtual_type,   desc = "[diag] Toggle type"  },
    {
      "<Leader>di",
      function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 })) end,
      desc = "Toggle inlay hints",
    },

    { "gd", "<cmd>Telescope lsp_definitions<CR>",       desc = "Go to Definition" },
    { "gD", vim.lsp.buf.declaration,                    desc = "Go to Declaration" },
    { "gR", restart_all_clients,                        desc = "Restart all LSP Clients"  },

    -- default overrides
    { "grn", vim.lsp.buf.rename,                        desc = "Rename Symbol" },
    { "gra", vim.lsp.buf.code_action,                   desc = "Code Actions" },
    { "grr", "<cmd>Telescope lsp_references<CR>",       desc = "Find All References" },
    { "gri", "<cmd>Telescope lsp_implementations<CR>",  desc = "Find Implementation" },
    { "gO",  "<cmd>Telescope lsp_document_symbols<CR>", desc = "Lists all symbols" },
    { "<C-s>", vim.lsp.buf.signature_help,              desc = "Show signature" },
  }
  -- stylua: ignore end

  for _, keys in pairs(keymaps) do
    vim.keymap.set("n", keys[1], keys[2], { desc = keys.desc, noremap = true, silent = true, buffer = bufnr })
  end
end

function M.update_diagnostics()
  local type = M._diagnostics.virtual_types
  vim.g.user_diagnostics_virtual_type = vim.g.user_diagnostics_virtual_type
    or User.get_config("lsp.diagnostics.virtual_type")
  local virtual_type = vim.g.user_diagnostics_virtual_type

  vim.diagnostic.config({
    float = {
      source = "if_many", -- Or "always"
    },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = Icon.diagnostics.Error,
        [vim.diagnostic.severity.HINT] = Icon.diagnostics.Hint,
        [vim.diagnostic.severity.WARN] = Icon.diagnostics.Warn,
        [vim.diagnostic.severity.INFO] = Icon.diagnostics.Info,
      },
    },
    virtual_text = virtual_type == type.TEXT and { current_line = true } or false,
    virtual_lines = virtual_type ~= type.TEXT,
  })
end

-- Events
local autocmd = vim.api.nvim_create_autocmd
local group_id = vim.api.nvim_create_augroup("user-setup", { clear = true })

autocmd("LspAttach", {
  desc = "Detect LSP feature",
  group = group_id,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end
    -- vim.print("[LSP] attached", { id = args.data.client_id, vim.tbl_keys(client.capabilities.textDocument) })

    if client:supports_method("textDocument/implementation") then
      -- vim.print("[LSP] supports implementations")
      vim.keymap.set(
        "n",
        "gI",
        "<cmd>Telescope lsp_implementations<CR>",
        { desc = "Find Implementation", noremap = true, silent = true, buffer = args.buf }
      )
    end

    -- copilot LSP see https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#copilot
    local bufnr = args.buf
    if
      client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, bufnr)
      and vim.lsp.inline_completion
    then
      vim.lsp.inline_completion.enable(true, { bufnr = bufnr })

      vim.keymap.set(
        "i",
        "<C-y>",
        vim.lsp.inline_completion.get,
        { desc = "LSP: accept inline completion", buffer = bufnr }
      )
      vim.keymap.set(
        "i",
        "<C-g>",
        vim.lsp.inline_completion.select,
        { desc = "LSP: switch inline completion", buffer = bufnr }
      )
    end
  end,
})

-- Custom LSP progress https://github.com/folke/snacks.nvim/blob/main/docs/notifier.md#-examples
local progress_table = vim.defaulttable()
autocmd("LspProgress", {
  desc = "LSP progress notifications",
  group = group_id,
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params.value
    if not client or type(value) ~= "table" then return end
    local progress = progress_table[client.id]

    for i = 1, #progress + 1 do
      if i == #progress + 1 or progress[i].token == ev.data.params.token then
        progress[i] = {
          token = ev.data.params.token,
          msg = ("[%3d%%] %s%s"):format(
            value.kind == "end" and 100 or value.percentage or 100,
            value.title or "",
            value.message and (" **%s**"):format(value.message) or ""
          ),
          done = value.kind == "end",
        }
        break
      end
    end

    local msg = {}
    progress_table[client.id] = vim.tbl_filter(function(v) return table.insert(msg, v.msg) or not v.done end, progress)

    vim.notify(table.concat(msg, "\n"), vim.log.levels.INFO, {
      id = "lsp_progress",
      title = client.name,
      opts = function(notif)
        notif.icon = #progress_table[client.id] == 0 and Icon.ui.Check or require("user.utils.spinner").icon()
      end,
    })
  end,
})

return M
