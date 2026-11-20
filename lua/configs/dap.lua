-- lua/configs/dap.lua
-- Debugging: Python (debugpy) and C/C++ (codelldb)
-- Install adapters once:  :MasonInstall debugpy codelldb
-- Keymaps: lua/mappings.lua (Debugging section)

local dap, dapui = require "dap", require "dapui"
local py = require "utils.python"

dapui.setup()
require("nvim-dap-virtual-text").setup { commented = true }

dap.listeners.after.event_initialized.dapui = function() dapui.open() end
dap.listeners.before.event_terminated.dapui = function() dapui.close() end
dap.listeners.before.event_exited.dapui = function() dapui.close() end

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "Visual" })

-- Python: adapter from Mason's debugpy; your code runs in the active env
local debugpy = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python"
local dap_python = require "dap-python"
dap_python.setup(vim.uv.fs_stat(debugpy) and debugpy or py.path())
dap_python.test_runner = "pytest"
dap_python.resolve_python = function()
  return py.path()
end

-- C / C++: codelldb
local codelldb = vim.fn.exepath "codelldb"
if codelldb == "" then
  codelldb = vim.fn.stdpath "data" .. "/mason/bin/codelldb"
end
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = { command = codelldb, args = { "--port", "${port}" } },
}
dap.configurations.cpp = {
  {
    name = "Launch executable",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/build/", "file")
    end,
    args = function()
      return vim.split(vim.fn.input "Args: ", " ", { trimempty = true })
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
  {
    name = "Attach to running process",
    type = "codelldb",
    request = "attach",
    pid = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
  },
}
dap.configurations.c = dap.configurations.cpp
