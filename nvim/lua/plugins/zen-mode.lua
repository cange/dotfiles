return {
  "folke/zen-mode.nvim", -- Distraction-free coding
  config = function()
    require("zen-mode").setup({
      window = {
        backdrop = 0.9, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width (0.9 = 90%) / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 1, -- width of the Zen window
        height = 1, -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = {
          -- signcolumn = "no", -- disable signcolumn
          -- number = false, -- disable number column
          -- relativenumber = false, -- disable relative numbers
          -- cursorline = false, -- disable cursorline
          -- cursorcolumn = false, -- disable cursor column
          -- foldcolumn = "0", -- disable fold column
          -- list = false, -- disable whitespace characters
        },
      },
      plugins = {
        gitsigns = { enabled = false }, -- true disables git signs
      },
      -- callback where you can add custom code when the Zen window opens
      -- on_open = function(win) end,
      -- callback where you can add custom code when the Zen window closes
      -- on_close = function() end,
    })

    vim.keymap.set({ "n", "i" }, "<leader>z", ":ZenMode<CR>", {})
  end,
}
