-- lua/utils/python.lua
-- Shared Python interpreter detection for LSP, DAP and neotest.
-- Order: activated venv / conda env -> project .venv / venv -> system python3
local M = {}

function M.path(root)
  root = root or vim.fn.getcwd()

  for _, env in ipairs { vim.env.VIRTUAL_ENV, vim.env.CONDA_PREFIX } do
    if env and env ~= "" then
      local p = env .. "/bin/python"
      if vim.uv.fs_stat(p) then
        return p
      end
    end
  end

  for _, dir in ipairs { ".venv", "venv" } do
    local p = root .. "/" .. dir .. "/bin/python"
    if vim.uv.fs_stat(p) then
      return p
    end
  end

  local sys = vim.fn.exepath "python3"
  return sys ~= "" and sys or "python3"
end

return M

