local icons = require("user.icons")

return {
  -- Fuzzy Finder
  "nvim-telescope/telescope.nvim", -- fuzzy finder over lists
  event = "VeryLazy",
  dependencies = {
    "BurntSushi/ripgrep", -- telescope live grep suggestions
    "ThePrimeagen/harpoon", -- bookmark buffers
    "nvim-lua/plenary.nvim", -- common lua functions - https://github.com/nvim-lua/plenary.nvim
    "nvim-telescope/telescope-file-browser.nvim", -- browser extension
    "nvim-telescope/telescope-project.nvim", -- switch between projects
    "nvim-telescope/telescope-ui-select.nvim", -- improved select UI
    "debugloop/telescope-undo.nvim",
    "tsakirist/telescope-lazy.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- improves search performance
  },
  config = function()
    local actions = require("telescope.actions")
    local action_layout = require("telescope.actions.layout")
    local telescope = require("telescope")
    -- config
    local default_opts = {
      previewer = false,
      theme = "dropdown",
    }
    local ivy_opts = { theme = "ivy" }
    local lsp_opts = {
      previewer = true,
      theme = "ivy",
    }
    local function responsive_width(_, cols) return math.floor(cols * (cols > 120 and 0.4 or 0.6)) end
    local function responsive_height(_, _, lines) return math.floor(lines * (lines > 100 and 0.4 or 0.6)) end

    -- setup
    telescope.setup({
      defaults = {
        path_display = {
          "smart",
          "absolute",
        },
        entry_prefix = "    ",
        layout_config = {
          bottom_pane = { prompt_position = "bottom" },
          horizontal = {
            height = responsive_height,
            preview_width = responsive_width,
          },
          vertical = {
            height = responsive_height,
            preview_width = responsive_width,
          },
          prompt_position = "top",
        },
        mappings = {
          i = {
            ["<C-a>"] = actions.cycle_history_prev,
            ["<C-k>"] = actions.cycle_history_prev,
            ["<C-j>"] = actions.cycle_history_next,
            ["<C-x>"] = actions.cycle_history_next,
            ["<C-c>"] = actions.close,
            ["<M-p>"] = action_layout.toggle_preview,
          },
          n = {
            ["<M-p>"] = action_layout.toggle_preview,
          },
        },
        prompt_prefix = " " .. icons.ui.Search .. "  ",
        scroll_strategy = "cycle",
        selection_caret = " " .. icons.ui.ChevronRight .. "  ",
        sorting_strategy = "ascending",
        winblend = vim.opt.winblend:get(),
      },
      extensions = {
        ["ui-select"] = { --https://github.com/nvim-telescope/telescope-ui-select.nvim#telescope-setup-and-configuration
          require("telescope.themes").get_cursor(),
        },
        project = default_opts,
        undo = {
          layout_config = { preview_width = 0.7 },
          entry_format = "$ID   " .. icons.ui.Time .. " $TIME",
          mappings = {
            i = {
              ["<CR>"] = require("telescope-undo.actions").restore,
            },
            n = {
              ["<CR>"] = require("telescope-undo.actions").restore,
            },
          },
        },
      },
      pickers = {
        buffers = default_opts,
        colorscheme = { enable_preview = true, theme = "dropdown" },
        current_buffer_fuzzy_find = ivy_opts,
        highlights = ivy_opts,
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
          previewer = false,
          theme = "dropdown",
        },
        git_branches = default_opts,
        grep_string = ivy_opts,
        help_tags = ivy_opts,
        keymaps = ivy_opts,
        lsp_declarations = lsp_opts,
        lsp_definitions = lsp_opts,
        lsp_references = lsp_opts,
        live_grep = {
          theme = "ivy",
          mappings = {
            i = {
              ["<C-f>"] = require("user.telescope").file_extension_filter_input,
            },
          },
        },
        oldfiles = ivy_opts,
        quickfix = default_opts,
      },
    })

    -- extensions
    telescope.load_extension("fzf")
    telescope.load_extension("project")
    telescope.load_extension("lazy")
    telescope.load_extension("ui-select")
    telescope.load_extension("undo")
  end,
  -- stylua: ignore start
  keys = {
    { "<localleader>/", "<cmd>lua R('user.telescope').live_grep()<CR>",     desc = "within Files" },
    { "<leader>/",  "<cmd>Telescope current_buffer_fuzzy_find<CR>",         desc = "within File" },
    { "<leader>f",  "<cmd>Telescope find_files<CR>",                        desc = "for Files" },
    { "<leader>p",  "<cmd>Telescope project<CR>",                           desc = "Switch workspace" },
    { "<leader>en", "<cmd>Telescope notify<CR>",                            desc = "Show notifications", },
    { "<leader>ec", "<cmd>Telescope colorscheme<CR>",                       desc = "Change colorscheme" },
    { "<leader>gB", "<cmd>Telescope git_branches<CR>",                      desc = "Checkout branch" },
    { "<leader>gC", "<cmd>Telescope git_commits<CR>",                       desc = "Checkout commit" },
    { "<leader>go", "<cmd>Telescope git_status<CR>",                        desc = "Open changed file" },
    { "<leader>bb", "<cmd>Telescope buffers<CR>",                           desc = "Buffers" },

    { "<leader>sb", '<cmd>lua R("user.telescope").file_browser()<CR>',      desc = "In current directory" },
    { "<leader>sC", "<cmd>Telescope commands<CR>",                          desc = "Commands" },
    { "<leader>sH", '<cmd>Telescope highlights<CR>',                        desc = "Highlights" },
    { "<leader>sh", "<cmd>Telescope help_tags<CR>",                         desc = "Nvim help" },
    { "<leader>sk", "<cmd>Telescope keymaps<CR>",                           desc = "Keybindings" },
    { "<leader>sn", '<cmd>lua R("user.telescope").browse_nvim()<CR>',       desc = "Nvim config" },
    { "<leader>sR", "<cmd>Telescope registers<CR>",                         desc = "Register values" },
    { "<leader>sr", "<cmd>Telescope oldfiles<CR>",                          desc = "Recently opened files" },
    { "<leader>sS", '<cmd>lua R("user.telescope").browse_snippets()<CR>',   desc = "Edit snippets" },
    { "<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>",              desc = "Show symbols" },
    { "<leader>sT", '<cmd>lua R("user.telescope").file_browser("/**/*.spec.*")<CR>', desc = "Specs/Tests" },
    { "<leader>st", "<cmd>TodoTelescope<CR>",                               desc = "Todo comments" },
    { "<leader>su", "<cmd>Telescope undo<CR>",                              desc = "Undo tree" },
    { "<leader>sW", '<cmd>lua R("user.telescope").browse_workspace()<CR>',  desc = "Current workspace" },
    { "<leader>sw", "<cmd>Telescope grep_string<CR>",                       desc = "Current word" },
    { "cD", "<cmd>Telescope diagnostics<CR>",                               desc = "Workspace diagnostics" },
    { "cl", '<cmd>lua R("user.telescope").diagnostics_log()<CR>',           desc = "File diagnostics" },
  },
  -- stylua: ignore end
}
