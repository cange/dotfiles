local ok, _ = pcall(require, "telescope")
if not ok then error('"telescope" not found') end
local builtin = require("telescope.builtin")

local M = {}

function M.custom_live_grep(opts)
  local conf = require("telescope.config").values
  local make_entry = require("telescope.make_entry")
  local finders = require("telescope.finders")
  local pickers = require("telescope.pickers")

  ---Ask for a file extension and filtering by it
  ---@param prompt_bufnr number
  local function file_extension_filter_input(prompt_bufnr)
    opts = { default = "*.", prompt = "Files via Regex", icon = Icon.ui.Filter }
    local on_confirm = function(glob_input)
      if not glob_input then return end

      require("telescope.actions").close(prompt_bufnr)

      M.custom_live_grep({
        glob_pattern = glob_input,
        default_text = require("telescope.actions.state").get_current_line(),
      })
    end

    require("snacks").input.input(opts, on_confirm) -- see: vim.ui.input
  end

  opts = opts or {}
  opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()
  opts.shortcuts = opts.shortcuts
    or {
      ["l"] = "*.lua",
      ["v"] = "*.vue",
      ["s"] = "*.{spec,stories}.{js,ts}",
    }
  opts.pattern = opts.pattern or "%s"

  local finder = finders.new_async_job({
    command_generator = function(prompt)
      if not prompt or prompt == "" then return nil end
      local pieces = vim.split(prompt, "  ")

      local args = { "rg" }
      if pieces[1] then
        table.insert(args, "--regexp")
        table.insert(args, pieces[1])
      end

      if pieces[2] then
        table.insert(args, "--glob")

        local pattern
        if opts.shortcuts[pieces[2]] then
          pattern = opts.shortcuts[pieces[2]]
        else
          pattern = pieces[2]
        end

        table.insert(args, string.format(opts.pattern, pattern))
      end

      local additional_args = {}
      if type(opts.glob_pattern) == "string" then
        additional_args[#additional_args + 1] = "--glob=" .. opts.glob_pattern
      elseif type(opts.glob_pattern) == "table" then
        for i = 1, #opts.glob_pattern do
          additional_args[#additional_args + 1] = "--glob=" .. opts.glob_pattern[i]
        end
      end

      return vim
        .iter({
          args,
          additional_args,
          { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
        })
        :flatten(2)
        :totable()
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  })

  pickers
    .new(opts, {
      attach_mappings = function(_, map)
        map({ "i" }, "<C-f>", file_extension_filter_input)
        return true
      end,
      debounce = 100,
      finder = finder,
      layout_strategy = "bottom_pane", -- equivalent to `theme: ivy`
      previewer = conf.grep_previewer(opts),
      prompt_title = "Live Grep (via Regex)",
      sorter = require("telescope.sorters").empty(),
    })
    :find()
end

function M.browse_nvim()
  builtin.find_files({
    cwd = vim.fn.stdpath("config"),
    previewer = false,
    prompt_title = Icon.ui.Neovim .. " Neovim",
  })
end

function M.browse_snippets()
  builtin.find_files({
    cwd = "~/.config/snippets",
    previewer = true,
    prompt_title = Icon.ui.Library .. " Snippets",
  })
end

function M.diagnostics_log()
  builtin.diagnostics(require("telescope.themes").get_ivy({
    bufnr = 0,
    initial_mode = "normal",
    no_listed = true, -- if true, shows only listed buffers
    previewer = false,
    prompt_title = Icon.ui.Stethoscope .. " Diagnostics Log",
  }))
end

function M.browse_workspace()
  builtin.find_files({
    cwd = "~/workspace/",
    hidden = true,
    prompt_title = Icon.documents.Briefcase .. " Workspace",
    shorten_path = false,
  })
end

function M.browse_test_files()
  local file_base_name = vim.fn.expand("%:t:r")

  builtin.find_files({
    prompt_title = Icon.ui.Beaker .. " Find Files (associated test files)",
    find_command = { "rg", "--files", "--iglob", file_base_name .. "{.,_}{spec,test,stories}.{js,ts,rb,lua}" },
  })
end

return M
