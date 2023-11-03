local has_telescope, telescope = pcall(require, "telescope")

if not has_telescope then error("This plugins requires nvim-telescope/telescope.nvim") end

local pickers = require("telescope.builtin")
local config = require("specto.config")

local lang = require("nvim-treesitter.parsers").get_parser():lang()
local util = require("specto.util"):new(lang)

local Highlight = require("todo-comments.highlight")
local make_entry = require("telescope.make_entry")

---@return table
local function get_keywords()
  local keywords = util:get_keywords("skip", true) or {}
  table.insert(keywords, util:get_keywords("only", true) or {})
  return vim.tbl_flatten(keywords)
end

local function find_spec_toggles(opts)
  opts = opts or {}
  opts.vimgrep_arguments = { config.search.command }
  vim.list_extend(opts.vimgrep_arguments, config.search.args)

  -- opts.search = Config.search_regex(get_keywords)
  opts.prompt_title = "Skip/Only Spec Marks"
  opts.use_regex = true

  local entry_maker = make_entry.gen_from_vimgrep(opts)

  opts.entry_maker = function(line)
    local ret = entry_maker(line)
    ret.display = function(entry)
      local display = string.format("%s:%s:%s ", entry.filename, entry.lnum, entry.col)
      local text = entry.text
      local start, finish, kw = Highlight.match(text)

      local hl = {}

      if start then
        kw = config.keywords[kw] or kw
        local icon = config.keywords[kw].icon
        display = icon .. " " .. display
        table.insert(hl, { { 1, #icon + 1 }, "SpectoFg" .. kw })
        text = vim.trim(text:sub(start))

        table.insert(hl, {
          { #display, #display + finish - start + 2 },
          "SpectoBg" .. kw,
        })
        table.insert(hl, {
          { #display + finish - start + 1, #display + finish + 1 + #text },
          "SpectoFg" .. kw,
        })
        display = display .. " " .. text
      end

      return display, hl
    end
    return ret
  end
  pickers.grep_string(opts)
end

local mod = {
  exports = { toggles = find_spec_toggles },
}

return telescope.register_extension(mod)
