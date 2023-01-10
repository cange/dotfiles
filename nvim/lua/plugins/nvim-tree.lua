-- local ns = "[plugins.nvim-tree]"

return {
  "kyazdani42/nvim-tree.lua",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  version = "nightly",
  config = function()
    local bookmark_nav = require("nvim-tree.api").marks.navigate
    local api = require("nvim-tree.api")
    local Event = api.events.Event
    local toggle_help_key = "<leader>eh"
    local callback = require("nvim-tree.config").nvim_tree_callback

    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
    vim.keymap.set("n", "<leader>.", ":NvimTreeFindFile<CR>")
    vim.keymap.set("n", "<leader>mn", bookmark_nav.next)
    vim.keymap.set("n", "<leader>mp", bookmark_nav.prev)
    vim.keymap.set("n", "<leader>ms", bookmark_nav.select)

    -- enable help toggle when tree open
    api.events.subscribe(Event.TreeOpen, function()
      vim.keymap.set("n", toggle_help_key, function()
        api.tree.toggle_help()
      end)
    end)

    api.events.subscribe(Event.TreeClose, function()
      vim.keymap.set("n", toggle_help_key, "<Nop>")
    end)

    require("nvim-tree").setup({
      live_filter = {
        prefix = Cange.get_icon("ui.Search") .. "  ",
      },
      -- project plugin related
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      -- common
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          show = {
            folder_arrow = false,
          },
          git_placement = "after",
          glyphs = {
            default = Cange.get_icon("documents.File", { trim = true }),
            bookmark = Cange.get_icon("ui.Bookmark", { trim = true }),
            symlink = Cange.get_icon("documents.SymlinkFile", { trim = true }),
            folder = {
              arrow_closed = Cange.get_icon("ui.ChevronRight", { trim = true }),
              arrow_open = Cange.get_icon("ui.ChevronDown", { trim = true }),
              default = Cange.get_icon("documents.Folder", { trim = true }),
              empty = Cange.get_icon("documents.EmptyFolder", { trim = true }),
              empty_open = Cange.get_icon("documents.EmptyOpenFolder", { trim = true }),
              open = Cange.get_icon("documents.OpenFolder", { trim = true }),
              symlink = Cange.get_icon("documents.SymlinkFolder", { trim = true }),
              symlink_open = Cange.get_icon("documents.SymlinkFolder", { trim = true }),
            },
            git = Cange.get_icon("git_states"),
          },
        },
      },
      diagnostics = {
        enable = true,
        icons = {
          error = Cange.get_icon("diagnostics.Error"),
          warning = Cange.get_icon("diagnostics.Warning"),
          hint = Cange.get_icon("diagnostics.Hint"),
          info = Cange.get_icon("diagnostics.Information"),
        },
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      view = {
        mappings = {
          list = {
            { key = "v", cb = callback("vsplit") },
            { key = "h", cb = callback("split") },
          },
        },
      },
    })
  end,
}
