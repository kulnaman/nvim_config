-- lua/configs/lspconfig.lua
-- Python: basedpyright (completion, auto-import, types) + ruff (lint, import sort, fixes)
-- C/C++:  clangd

local nvlsp = require "nvchad.configs.lspconfig"

local capabilities = vim.tbl_deep_extend(
  "force",
  nvlsp.capabilities,
  require("blink.cmp").get_lsp_capabilities()
)

---------------------------------------------------------------------------
-- Python interpreter detection
-- Order: activated venv/conda env -> project .venv/venv -> system python3
---------------------------------------------------------------------------
local function python_path(root)
  for _, env in ipairs { vim.env.VIRTUAL_ENV, vim.env.CONDA_PREFIX } do
    if env and env ~= "" then
      return env .. "/bin/python"
    end
  end
  if root then
    for _, dir in ipairs { ".venv", "venv" } do
      local p = root .. "/" .. dir .. "/bin/python"
      if vim.uv.fs_stat(p) then
        return p
      end
    end
  end
  return vim.fn.exepath "python3"
end

---------------------------------------------------------------------------
-- Shared attach logic
---------------------------------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end
    local bufnr = args.buf

    nvlsp.on_attach(client, bufnr)
    -- NvChad's on_init disables semantic tokens; keep them for basedpyright
    if client.name ~= "basedpyright" then
      nvlsp.on_init(client)
    end
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
    end
    map("n", "gd", vim.lsp.buf.definition, "LSP Go to Definition")
    map("n", "gD", vim.lsp.buf.declaration, "LSP Go to Declaration")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP Code action (add import, fixes)")
    map("n", "<leader>th", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }, { bufnr = bufnr })
    end, "Toggle inlay hints")

    -- Let basedpyright own hover; ruff's hover is just rule docs
    if client.name == "ruff" then
      client.server_capabilities.hoverProvider = false
    end
  end,
})

vim.lsp.config("*", { capabilities = capabilities })

---------------------------------------------------------------------------
-- basedpyright
---------------------------------------------------------------------------
vim.lsp.config("basedpyright", {
  before_init = function(_, config)
    config.settings = config.settings or {}
    config.settings.python = { pythonPath = python_path(config.root_dir) }
  end,
  settings = {
    basedpyright = {
      disableOrganizeImports = true, -- ruff sorts imports
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly", -- "workspace" is slower on big repos
        typeCheckingMode = "standard", -- "basic" quieter, "recommended"/"all" stricter
        inlayHints = {
          variableTypes = true,
          functionReturnTypes = true,
          callArgumentNames = true,
          genericTypes = false,
        },
      },
    },
  },
})

---------------------------------------------------------------------------
-- ruff (native LSP; project pyproject.toml / ruff.toml takes precedence)
---------------------------------------------------------------------------
vim.lsp.config("ruff", {
  init_options = {
    settings = {
      lineLength = 88,
      lint = { select = { "E", "F", "W", "I", "B", "UP" } },
      configurationPreference = "filesystemFirst",
    },
  },
})

vim.lsp.enable { "clangd", "basedpyright", "ruff" }

-- Optional: keep pylsp around as a fallback by swapping it into the list above.
