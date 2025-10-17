return {
  "folke/sidekick.nvim",
  opts = {
    cli = { win = { split = { width = 0 } } },
  },
  keys = function()
    local cli = require("sidekick.cli")
    return {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
          return ""
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion [sidekick]",
      },
      -- stylua: ignore start
      { "<c-.>", function() cli.focus() end, mode = { "n", "x", "i", "t" },                 desc = "[sidekick] Switch Focus" },
      { "<leader>aS", function() cli.select({ filter = { installed = true } }) end,         desc = "[sidekick] Select CLI" },
      { "<leader>aa", function() cli.toggle({ name = "opencode", focus = true }) end,       desc = "[sidekick] Toggle" },
      { "<leader>ad", function() cli.close() end,                                           desc = "[sidekick] Detach Session" },
      { "<leader>ap", function() cli.prompt({ msg = "{this}" }) end, mode = { "n", "x" },   desc = "[sidekick] Select Prompt" },
      { "<leader>af", function() cli.send({ msg = "{file}" }) end,                          desc = "[sidekick] Send File" },
      { "<leader>av", function() cli.send({ msg = "{selection}" }) end, mode = { "x" },     desc = "[sidekick] Send Visual Selection", },
      { "<leader>at", function() cli.send({ msg = "{this}" }) end, mode = { "x", "n" },     desc = "[sidekick] Send this" },
      { "<leader>an", function() require("sidekick.nes").toggle() end,                      desc = "[sidekick] Toggle NES" },
      -- stylua: ignore end
    }
  end,
}
