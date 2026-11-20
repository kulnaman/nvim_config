-- lua/configs/lspconfig.lua
-- Python: basedpyright (completion, auto-import, types) + ruff (lint, import sort, fixes)
-- C/C++:  clangd (auto-#include, clang-tidy, background index)
-- Keymaps: see lua/mappings.lua (LSP section)

local nvlsp = require "nvchad.configs.lspconfig"
local py = require "utils.python"

local capabilities = vim.tbl_deep_extend(
  "force",
  nvlsp.capabilities,
  require("blink.cmp").get_lsp_capabilities()
)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    nvlsp.on_attach(client, args.buf)
    -- NvChad's on_init disables semantic tokens; keep them for basedpyright
    if client.name ~= "basedpyright" then
      nvlsp.on_init(client)
    end

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
    config.settings.python = { pythonPath = py.path(config.root_dir) }
  end,
  settings = {
    basedpyright = {
      disableOrganizeImports = true, -- ruff sorts imports
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
        typeCheckingMode = "standard",
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

---------------------------------------------------------------------------
-- clangd
-- Needs compile_commands.json at the project root (or in build/):
--   CMake: cmake -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
--   Make:  bear -- make
---------------------------------------------------------------------------
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu", -- auto-add #include when accepting a completion
    "--completion-style=detailed",
    "--fallback-style=llvm",
    "-j=4",
    -- On the cluster, if clangd can't find system/MPI headers, uncomment and adjust:
    -- "--query-driver=/usr/bin/g++,/opt/**/bin/g++*,/opt/**/bin/mpic*",
  },
  init_options = { clangdFileStatus = true },
})

vim.lsp.enable { "clangd", "basedpyright", "ruff" }
