-- Icons works best with "FiraCode Nerd Font"
-- https://github.com/microsoft/vscode/blob/main/src/vs/base/common/codicons.ts
-- go to the above and then enter <c-v>u<unicode> and the symbold should appear
-- or go here and upload the font file: https://mathew-kurian.github.io/CharacterMap/
-- find more here: https://www.nerdfonts.com/cheat-sheet

local M = {}

-- stylua: ignore start
M.ui = {
  ArrowRight          = "▸", -- U+25B8
  Beaker              = "", -- nf-cod-beaker
  Book                = "", -- nf-cod-book
  Bookmark            = "", -- nf-cod-bookmark
  Bug                 = "", -- nf-cod-bug
  Check               = "", -- nf-cod-check
  CheckAll            = "", -- nf-cod-check_all
  ChevronDown         = "", -- nf-cod-chevron_down
  ChevronRight        = "", -- nf-cod-chevron_right
  Close               = "", -- nf-cod-close
  Code                = "", -- nf-cod-code
  Copilot             = "", -- nf-oct-copilot
  CopilotError        = "", -- nf-oct-copilot_error
  CopilotWarning      = "", -- nf-oct-copilot_warning
  Database            = "", -- nf-cod-database
  Dot                 = "", -- nf-cod-circle
  DotFill             = "", -- nf-cot-circle_fill
  Ellipsis            = "", -- nf-oct-ellipsis
  Edit                = "", -- nf-cod-edit
  Globe               = "", -- nf-cod-globe
  Lock                = "", -- nf-cod-lock
  Multiline           = "", -- nf-cod-word_wrap
  Note                = "", -- nf-cod-note
  Neovim              = "", -- nf-custom-neovim
  Library             = "", -- nf-cod-library
  Package             = "", -- nf-cod-package
  Path                = "", -- nf-oct-rel_file_path
  Plus                = "", -- nf-doc-plus
  Eye                 = "", -- nf-cod-eye
  EyeClosed           = "", -- nf-cod-eye_closed
  Search              = "", -- nf-cod-search
  Stethoscope         = "󰓙", -- nf-md-stethoscope
  Sync                = "", -- nf-cod-sync
  Tab                 = "", -- nf-oct-tab
  Tabnine             = "⌬", -- U+232C
  -- shapes
  TriangleLeft        = "", -- nf-ple-upper_left_triangle
  TriangleRight       = "", -- nf-ple-lower_right_triangle
  VLineLeft           = "▎", -- U+258E
  VThinLineLeft       = "▏", -- U+258F
  Pipe                = "|", -- U+007C
  VDashedLine         = "┆", -- U+2506
  VThinLine           = "│", -- U+2502
}
M.extensions = {
  Babelrc             = "󰨥", -- nf-md-babel
  Lua                 = "", -- nf-seti-lua
  Nuxt                = "󱄆", -- nf-md-nuxt
  Stylelint           = "", -- nf-seti-stylelint
  Yarn                = "", -- nf-seti-yarn
}
M.documents = {
  Briefcase           = "", -- nf-oct-briefcase
  EmptyFolder         = "", -- nf-cod-folder
  EmptyOpenFolder     = "", -- nf-cod-folder_open
  File                = "", -- nf-oct-file
  Files               = "", -- nf-cod-files
  Folder              = "", -- nf-oct-file_directory_fill
  NewFile             = "", -- nf-oct-file_added
  OpenFolder          = "", -- nf-oct-file_directory_open_fill
  Repo                = "", -- nf-oct-repo
  SymlinkFile         = "", -- nf-oct-file_symlink_file
  SymlinkFolder       = "", -- nf-oct-file_submodule
}
M.sets = {
  batteries           = "󰂎 󰁺 󰁻 󰁼 󰁽 󰁾 󰂀 󰂁 󰂂 󰁹", -- nf-md-battery_[outline|10-90|]
  circles             = "󰝦 󰪞 󰪟 󰪠 󰪡 󰪢 󰪣 󰪤 󰪥", -- nf-md-circle_slice_[1-8]
}
M.git = {
  Add                 = "", -- nf-oct-diff_added,
  Mod                 = "", -- nf-oct-diff_modified
  Remove              = "", -- nf-oct-diff_removed
  Ignore              = "", -- nf-oct-diff_ignored
  Rename              = "", -- nf-oct-diff_renamed
  Diff                = "", -- nf-oct-diff
  Branch              = "", -- nf-oct-git_branch
  Commit              = "", -- nf-cod-git_commit
}
M.git_states = {
  unstaged            = M.git.Mod,
  staged              = "",  -- none on purpose
  unmerged            = "", -- nf-oct-git_pull_request_closed
  renamed             = M.git.Rename,
  untracked           = M.git.Add,
  deleted             = M.git.Remove,
  ignored             = M.git.Ignore,
}
M.diagnostics = {
  Error               = "", -- nf-oct-stop
  Warn                = "", -- nf-oct-alert
  Info                = "", -- nf-oct-info
  Hint                = "", -- nf-oct-light_bulb
}
local kinds = {
  Class               = "", -- nf-cod-symbol_class
  Color               = "", -- nf-cod-symbol_color
  Constant            = "", -- nf-cod-symbol_constant
  Constructor         = "", -- nf-cod-symbol_method
  Enum                = "", -- nf-cod-symbol_enum
  EnumMember          = "", -- nf-cod-symbol_enum_member
  Event               = "", -- nf-cod-symbol_event
  Field               = "", -- nf-cod-symbol_field
  File                = "", -- nf-cod-symbol_file
  Folder              = M.documents.Folder,
  Function            = "", -- nf-cod-symbol_method
  Interface           = "", -- nf-cod-symbol_interface
  Keyword             = "", -- nf-cod-symbol_keyword
  Method              = "", -- nf-cod-symbol_method
  Module              = "", -- nf-cod-symbol_namespace
  Operator            = "", -- nf-cod-symbol_operator
  Property            = "", -- nf-cod-symbol_property
  Reference           = M.documents.SymlinkFile,
  Snippet             = "", -- nf-cod-symbol_snippet
  Struct              = "", -- nf-cod-symbol_structure
  Text                = "", -- nf-cod-symbol_key
  TypeParameter       = "", -- nf-cod-symbol_parameter
  Value               = "", -- nf-oct-number
  Variable            = "", -- nf-cod-symbol_variable
}
M.cmp_kinds = vim.tbl_extend("keep", kinds, {
  Array               = "", -- nf-cod-symbol_array
  Boolean             = "", -- nf-cod-symbol_boolean
  Key                 = kinds.Text,
  Misc                = "", -- nf-cod-symbol_misc
  Namespace           = kinds.Module,
  Null                = "󰟢", -- nf-md-null
  SingleLine          = kinds.Text,
  MultiLine           = M.ui.Multiline,
  Number              = "", -- nf-cod-symbol_numeric
  Object              = kinds.Module,
  Package             = "", -- nf-cod-package
  String              = "", -- nf-cod-symbol_string
  Unit                = "", -- nf-cod-symbol_ruler
})
-- stylua: ignore end

return M
