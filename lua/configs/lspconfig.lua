-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- Import blink.cmp capabilities
local blink_cmp_capabilities = require("blink.cmp").get_lsp_capabilities()

-- Merge blink.cmp capabilities with nvchad's default capabilities
capabilities = vim.tbl_deep_extend("force", capabilities, blink_cmp_capabilities)

local lspconfig = require "lspconfig"
local servers = { "clangd","pylsp" }

lspconfig.pylsp.setup {
  settings = {
    pylsp = {
      plugins = {
        -- Rope for completion
        rope_completion = {
          enabled = true,
          eager = true
        },
        -- Black for formatting
        black = {
          enabled = true,
          line_length = 88,  -- default black line length
          preview = true,
        },
        -- Ruff for linting/everything else
        ruff = {
          enabled = true,
          lineLength = 88,  -- match black's line length
          select = {"E", "F", "I", "W"},  -- default rules
          ignore = {},
          format = false  -- let black handle formatting
        },
        -- Disable other plugins to avoid conflicts
        pycodestyle = { enabled = false },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        pylint = { enabled = false },
        pyflakes = { enabled = false },
        mccabe = { enabled = false },
        preload = { enabled = false },
        jedi_completion = { enabled = false },  -- using rope instead
        jedi_hover = { enabled = true },  -- keep hover functionality
        jedi_references = { enabled = true },  -- keep references functionality
        jedi_signature_help = { enabled = true },  -- keep signature help
        jedi_symbols = { enabled = true }  -- keep document symbols
      }
    }
  }
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

