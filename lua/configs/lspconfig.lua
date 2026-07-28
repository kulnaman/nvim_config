-- lua/configs/lspconfig.lua

local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init   = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local blink_cmp_capabilities = require("blink.cmp").get_lsp_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, blink_cmp_capabilities)

-- Use LspAttach autocmd instead of on_attach in vim.lsp.config
-- This avoids the function merging bug with the '*' wildcard
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf

    -- Call NvChad's on_attach for its default keymaps/settings
    on_attach(client, bufnr)
    on_init(client)

    -- Explicitly set gd / gD (not in Neovim defaults)
    local opts = { buffer = bufnr, silent = true }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition,  vim.tbl_extend("force", opts, { desc = "LSP Go to Definition" }))
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "LSP Go to Declaration" }))
  end,
})

-- Shared non-function config (capabilities is fine here, it's a table)
vim.lsp.config('*', {
  capabilities = capabilities,
})

-- pylsp-specific settings
vim.lsp.config('pylsp', {
  settings = {
    pylsp = {
      plugins = {
  rope_completion      = { enabled = false },  -- turn off, jedi is better + faster
  rope_autoimport      = { enabled = true, memory = false },  -- NEW: real import suggestions
  black                = { enabled = true, line_length = 88, preview = true },
  ruff                 = { enabled = true, lineLength = 88, select = {"E","F","I","W"}, ignore = {}, format = false },
  pycodestyle          = { enabled = false },
  autopep8             = { enabled = false },
  yapf                 = { enabled = false },
  pylint               = { enabled = false },
  pyflakes             = { enabled = false },
  mccabe               = { enabled = false },
  preload              = { enabled = false },
  jedi_completion      = { enabled = true, include_params = true, fuzzy = true },  -- FLIPPED ON
  jedi_hover           = { enabled = true },
  jedi_references      = { enabled = true },
  jedi_signature_help  = { enabled = true },
  jedi_symbols         = { enabled = true },
},
    },
  },
})

vim.lsp.enable({ 'clangd', 'pylsp' })

