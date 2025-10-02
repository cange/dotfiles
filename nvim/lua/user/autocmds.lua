-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------

-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup
local autocmd = vim.api.nvim_create_autocmd
local group_id = vim.api.nvim_create_augroup("user-setup", { clear = true })

autocmd({ "BufEnter", "BufNewFile", "BufRead" }, {
  group = group_id,
  pattern = "*.md,*.lua,*.txt",
  callback = function()
    vim.opt_local.colorcolumn = "80"
    vim.opt_local.textwidth = 80
  end,
})

autocmd({ "BufEnter", "BufNewFile", "BufRead" }, {
  group = group_id,
  pattern = ".env.*",
  callback = function() vim.bo.filetype = "sh" end,
})

autocmd({ "BufEnter", "BufNewFile", "BufRead" }, {
  group = group_id,
  pattern = "*.mdx",
  callback = function() vim.bo.filetype = "jsx" end,
})

autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = group_id,
  callback = function() vim.highlight.on_yank({ higroup = "Cursor" }) end,
})

autocmd("TermOpen", {
  desc = "Clean inner editor terminal",
  group = group_id,
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

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
