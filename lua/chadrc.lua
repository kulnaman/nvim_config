-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}
M.base46 = {

	theme = "tokyonight",
  -- groups the theme already defines (tree-sitter)
  hl_override = {
    ["@keyword.import"]   = { fg = "purple", italic = true }, -- from / import
    ["@keyword.function"] = { fg = "purple" },                -- def
    ["@keyword.type"]     = { fg = "purple" },                -- class
    ["@keyword"]          = { fg = "purple" },
  },

  -- groups coming from basedpyright's semantic tokens (python only)
  hl_add = {
    ["@lsp.type.namespace.python"] = { fg = "baby_pink" },             -- cosched.config.model
    ["@lsp.type.class.python"]     = { fg = "yellow" },                -- Instance, Ledger, NodeView
    ["@lsp.type.typeParameter.python"] = { fg = "yellow", italic = true },
    ["@lsp.type.decorator.python"] = { fg = "orange" },                -- @dataclass
    ["@lsp.type.function.python"]  = { fg = "blue" },
    ["@lsp.type.method.python"]    = { fg = "blue" },
  },
}
M.base46 = {

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }

return M
