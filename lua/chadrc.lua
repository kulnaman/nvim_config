-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "espresso", -- must be here, written with double quotes

  hl_override = {
    ["@keyword.import"]   = { fg = "purple", italic = true },
    ["@keyword.function"] = { fg = "purple" },
    ["@keyword.type"]     = { fg = "purple" },
    ["@keyword"]          = { fg = "purple" },
  },

  hl_add = {
    ["@lsp.type.namespace.python"]     = { fg = "baby_pink" },
    ["@lsp.type.class.python"]         = { fg = "yellow" },
    ["@lsp.type.typeParameter.python"] = { fg = "yellow", italic = true },
    ["@lsp.type.decorator.python"]     = { fg = "orange" },
    ["@lsp.type.function.python"]      = { fg = "blue" },
    ["@lsp.type.method.python"]        = { fg = "blue" },
  },
}

-- keep your other sections (M.ui, M.nvdash, ...) as they are

return M
