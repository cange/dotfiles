local ns = "[cange.telescope]"
local found_telescope, telescope = pcall(require, "telescope")
if not found_telescope then
  print(ns, '"telescope" not found')
  return
end
local found_setup, _ = pcall(require, "cange.telescope.setup")
if not found_setup then
  print(ns, '"cange.telescope.setup" not found')
  return
end
local found_custom, _ = pcall(require, "cange.telescope.custom")
if not found_custom then
  print(ns, '"cange.telescope.custom" not found')
  return
end
-- config
telescope.load_extension("fzf")
telescope.load_extension("textcase")
telescope.load_extension("session-lens")
telescope.load_extension("notify")
telescope.load_extension("project")
telescope.load_extension("ui-select")

Cange.register_whichkey_group("telescope", {
  title = "Search",
  subleader = "s",
  mappings = {
    B = { cmd = "<cmd>Telescope buffers<CR>", desc = "[S]earch Existing [B]uffers", primary = true },
    C = { cmd = "<cmd>Telescope commands<CR>", desc = "[S]earch [C]ommands" },
    F = {
      cmd = "<cmd>Telescope live_grep<CR>",
      desc = "[S]earch by [G]rep",
      primary = true,
      dashboard = true,
      icon = "ui.List",
    },
    N = { cmd = "<cmd>Telescope notify<CR>", desc = "[S]earch [N]otifications" },
    P = {
      cmd = "<cmd>lua require('telescope').extensions.project.project()<CR>",
      desc = "[S]earch [P]rojects",
      dashboard = true,
      icon = "ui.Project",
    },
    W = { cmd = '<cmd>lua require("telescope.builtin").grep_string<CR>', desc = "[S]earch current [W]ord" },
    b = { cmd = '<cmd>lua require("cange.telescope.custom").file_browser()<CR>', desc = "[S]earch [B]rowse files" },
    c = { cmd = "<cmd>Telescope colorscheme<CR>", desc = "[S]witch [C]olorscheme" },
    f = {
      cmd = "<cmd>Telescope find_files<CR>",
      desc = "[S]earch [F]iles",
      primary = true,
      dashboard = true,
      icon = "ui.Search",
    },
    h = { cmd = "<cmd>Telescope help_tags<CR>", desc = "[S]earch [H]elp" },
    k = { cmd = "<cmd>Telescope keymaps<CR>", desc = "[S]earch [K]eybindings" },
    n = { cmd = '<cmd>lua require("cange.telescope.custom").browse_nvim()<CR>', desc = "Browse [N]vim" },
    r = {
      cmd = "<cmd>Telescope oldfiles<CR>",
      desc = "[R]ecently Opened Files",
      dashboard = true,
      icon = "ui.Calendar",
    },
    w = { cmd = '<cmd>lua require("cange.telescope.custom").browse_workspace()<CR>', desc = "Browse [W]orkspace" },
    ["/"] = {
      cmd = '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>',
      desc = "Search current buffer",
    },
  },
})
