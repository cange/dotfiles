local ok, _ = pcall(require, "lspconfig")
if not ok then return end

require("cange.lsp.mason")
require("cange.lsp.mason-tool-installer")
