-- lua/configs/neotest.lua
-- Run pytest from inside nvim. Needs pytest installed in the project env.
-- Keymaps: lua/mappings.lua (Tests section)

local py = require "utils.python"
require("neotest").setup {
  adapters = {
    require "neotest-python" {
      runner = "pytest",
      python = function()
        return py.path()
      end,
      dap = { justMyCode = false },
    },
  },
  status = { virtual_text = true },
  output = { open_on_run = false },
}
