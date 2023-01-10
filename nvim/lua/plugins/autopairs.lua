return {
  "windwp/nvim-autopairs", -- close brackets, quotes etc
  config = function()
    require("nvim-autopairs").setup({
      check_ts = true, -- enable Tree-Sitter
      ts_config = {
        lua = { "string" }, -- it will not add a pair on that treesitter node
        javascript = { "template_string" },
      },
    })

    -- make autopairs and completion work together
    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local found_cmp, cmp = pcall(require, "cmp")
    if not found_cmp then
      return
    end

    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
