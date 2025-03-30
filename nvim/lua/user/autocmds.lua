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
    -- TODO: use either native support (see ↓) or 3rd party (blink.nvim)
    -- when native: How are other sources such paths, snippets etc. are support
    -- if client:supports_method("textDocument/completion") then
    --   -- vim.print("[LSP] supports completions", client.id)
    --   vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    -- end
  end,
})
