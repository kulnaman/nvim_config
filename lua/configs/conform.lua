local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    c   = { "clang_format" },
    cpp = { "clang_format" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
  -- Tell clang-format to look for the .clang-format file
  formatters = {
    clang_format = {
      prepend_args = { "--style=file" },
    },
  },

  -- Optional: format on save
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
