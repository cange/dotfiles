---@class cange.utils.Symbols
local M = {}

local kind_hls = {
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
local other_kind_hls = {
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

---Provides mapping for highlight groups of symbol items.
---@param id? string|nil
---@return table A certain highlight group or all if identifier is nil
function M.get_kind_hl(id)
  id = id or nil
  local hls = vim.tbl_extend("keep", kind_hls, other_kind_hls)

  return id and hls[id] or hls
end
return M
