---This highlights groups relates to syntactic fragments also known kinds
---@class HighlightGroups
---@field kinds table Completion kinds Highlight definition map
---@field other_kinds table Completion kinds Highlight definition map

---@class HighlightGroups
local M = {}

M.kinds = {
  Text = { link = "CmpItemKindText" },
  Method = { link = "CmpItemKindMethod" },
  Function = { link = "CmpItemKindFunction" },
  Constructor = { link = "CmpItemKindConstructor" },
  Field = { link = "CmpItemKindField" },
  Variable = { link = "CmpItemKindVariable" },
  Class = { link = "CmpItemKindClass" },
  Interface = { link = "CmpItemKindInterface" },
  Module = { link = "CmpItemKindModule" },
  Property = { link = "CmpItemKindProperty" },
  Unit = { link = "CmpItemKindUnit" },
  Value = { link = "CmpItemKindValue" },
  Enum = { link = "CmpItemKindEnum" },
  Keyword = { link = "CmpItemKindKeyword" },
  Snippet = { link = "CmpItemKindSnippet" },
  Color = { link = "CmpItemKindColor" },
  File = { link = "CmpItemKindFile" },
  Reference = { link = "CmpItemKindReference" },
  Folder = { link = "CmpItemKindFolder" },
  EnumMember = { link = "CmpItemKindEnumMember" },
  Constant = { link = "CmpItemKindConstant" },
  Struct = { link = "CmpItemKindStruct" },
  Event = { link = "CmpItemKindEvent" },
  Operator = { link = "CmpItemKindOperator" },
  TypeParameter = { link = "CmpItemKindTypeParameter" },
}
M.other_kinds = {
  Namespace = { link = "@namespace" },
  Package = { link = "@namespace" },
  String = { link = "@string" },
  Number = { link = "@number" },
  Boolean = { link = "@boolean" },
  Array = { link = "@keyword" },
  Object = { link = "@keyword" },
  Key = { link = "@keyword" },
  Null = { link = "@keyword" },
}

return M
