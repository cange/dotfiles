return {
  "johmsalas/text-case.nvim", -- text case converter (camel case, etc.,
  config = function()
    require("textcase").setup()

    vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
  end,
}
