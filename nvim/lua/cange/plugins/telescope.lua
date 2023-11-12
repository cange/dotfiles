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
    "tsakirist/telescope-lazy.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- improves search performance
  },
  config = function()
    local actions = require("telescope.actions")
    local telescope = require("telescope")
    -- config
    local default_opts = {
      previewer = false,
      theme = "dropdown",
    }
    local ivy_opts = { theme = "ivy" }
    local lsp_opts = {
      initial_mode = "normal",
      previewer = false,
      theme = "dropdown",
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
            ["<C-s>"] = actions.cycle_history_next,
            ["<C-a>"] = actions.cycle_history_prev,
            ["<C-c>"] = actions.close,
          },
        },
        prompt_prefix = " " .. Cange.get_icon("ui.Search") .. "  ",
        scroll_strategy = "cycle",
        selection_caret = " " .. Cange.get_icon("ui.ChevronRight") .. "  ",
        sorting_strategy = "ascending",
        winblend = vim.opt.winblend:get(),
      },
      extensions = {
        ["ui-select"] = { --https://github.com/nvim-telescope/telescope-ui-select.nvim#telescope-setup-and-configuration
          require("telescope.themes").get_cursor(),
        },
        project = default_opts,
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
              ["<C-f>"] = require("cange.telescope").file_extension_filter_input,
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
    telescope.load_extension("ui-select")
    telescope.load_extension("lazy")
  end,
  -- stylua: ignore start
  keys = {
    { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<CR>",          desc = "Search within buffer" },
    { "<leader>eN", "<cmd>Telescope notify<CR>",                            desc = "Show notifications", },
    { "<leader>ec", "<cmd>Telescope colorscheme<CR>",                       desc = "Change colorscheme" },
    { "<leader>ep", "<cmd>Telescope project<CR>",                           desc = "Switch workspace" },
    { "<leader>f", "<cmd>Telescope find_files<CR>",                         desc = "Search Files" },
    { "<leader>gB", "<cmd>Telescope git_branches<CR>",                      desc = "Checkout branch" },
    { "<leader>gC", "<cmd>Telescope git_commits<CR>",                       desc = "Checkout commit" },
    { "<leader>go", "<cmd>Telescope git_status<CR>",                        desc = "Open changed file" },
    { "<leader>sB", "<cmd>Telescope buffers<CR>",                           desc = "Buffers" },
    { "<leader>sC", "<cmd>Telescope commands<CR>",                          desc = "Commands" },
    { "<leader>sH", '<cmd>Telescope highlights<CR>',                        desc = "Highlights" },
    { "<leader>sS", '<cmd>lua R("cange.telescope").browse_snippets()<CR>',  desc = "Edit snippets" },
    { "<leader>sW", '<cmd>lua R("cange.telescope").browse_workspace()<CR>', desc = "Current workspace" },
    { "<leader>sb", '<cmd>lua R("cange.telescope").file_browser()<CR>',     desc = "In current directory" },
    { "<leader>sh", "<cmd>Telescope help_tags<CR>",                         desc = "Nvim help" },
    { "<leader>sk", "<cmd>Telescope keymaps<CR>",                           desc = "Keybindings" },
    { "<leader>sn", '<cmd>lua R("cange.telescope").browse_nvim()<CR>',      desc = "Nvim config" },
    { "<leader>sr", "<cmd>Telescope oldfiles<CR>",                          desc = "Recently opened files" },
    { "<leader>st", "<cmd>TodoTelescope<CR>",                               desc = "Todo comments" },
    { "<leader>sw", "<cmd>Telescope grep_string<CR>",                       desc = "Current word" },
    { "<localleader>/", "<cmd>lua R('cange.telescope').live_grep()<CR>",    desc = "Search in Files" },
    { "cD", "<cmd>Telescope diagnostics<CR>",                               desc = "Workspace diagnostics" },
    { "cc", "<cmd>TextCaseOpenTelescope<CR>",                               desc = "Change Case", mode = { "v", "n" } },
    { "cl", '<cmd>lua R("cange.telescope").diagnostics_log()<CR>',          desc = "File diagnostics" },
  },
  -- stylua: ignore end
}
