return { -- File explorer
  enabled = true,
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  keys = {
    { "<Leader>\\", "<cmd>NvimTreeToggle<CR>", desc = "File Tree Explorer" },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/snacks.nvim",
  },
  opts = {
    live_filter = {
      prefix = Icon.ui.Search .. "  ",
    },
    -- project plugin related
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = true,
    },
    renderer = {
      indent_markers = { enable = true },
      icons = {
        git_placement = "after",
        show = { folder = false },
        symlink_arrow = " " .. Icon.documents.SymlinkFile .. " ",
        glyphs = {
          default = Icon.documents.File,
          bookmark = Icon.ui.Bookmark,
          symlink = Icon.documents.SymlinkFile,
          folder = {
            arrow_closed = Icon.ui.ChevronRight,
            arrow_open = Icon.ui.ChevronDown,
            default = Icon.documents.Folder,
            empty = Icon.documents.EmptyFolder,
            empty_open = Icon.documents.EmptyOpenFolder,
            open = Icon.documents.OpenFolder,
            symlink = Icon.documents.SymlinkFolder,
            symlink_open = Icon.documents.SymlinkFolder,
          },
          git = Icon.git_states,
        },
      },
    },
    diagnostics = {
      enable = true,
      icons = {
        error = Icon.diagnostics.Error,
        warning = Icon.diagnostics.Warn,
        hint = Icon.diagnostics.Hint,
        info = Icon.diagnostics.Info,
      },
    },
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)

    vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
      group = vim.api.nvim_create_augroup("before_file_tree_explorer_close", { clear = true }),
      desc = "Close file tree explorer",
      command = "NvimTreeClose",
    })

    User.set_highlights({
      NvimTreeGitDirtyIcon = { link = "GitSignsChange" },
      NvimTreeGitNewIcon = { link = "GitSignsAdd" },
    })

    -- https://github.com/folke/snacks.nvim/blob/main/docs/rename.md#nvim-tree
    local prev = { new_name = "", old_name = "" } -- Prevents duplicate events
    vim.api.nvim_create_autocmd("User", {
      pattern = "NvimTreeSetup",
      callback = function()
        local events = require("nvim-tree.api").events
        events.subscribe(events.Event.NodeRenamed, function(data)
          if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
            data = data
            require("snacks").rename.on_rename_file(data.old_name, data.new_name)
          end
        end)
      end,
    })
  end,
}
