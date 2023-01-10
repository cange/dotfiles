return {
  "tzachar/cmp-tabnine", -- AI code suggestions
  build = "./install.sh",
  dependencies = "hrsh7th/nvim-cmp",
  config = function()
    -- https://github.com/tzachar/cmp-tabnine#install
    require("cmp_tabnine.config").setup({
      max_lines = 1000,
      max_num_results = 10,
      sort = true, -- results by returned priority
      run_on_every_keystroke = true,
      snippet_placeholder = "..",
      -- ignored_file_types = {
      --   default is not to ignore
      --  -- uncomment to ignore in lua:
      --   lua = true
      -- },
      show_prediction_strength = false,
    })
  end,
}
