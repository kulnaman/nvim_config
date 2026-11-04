-- lua/configs/conform.lua
local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    -- sort imports first, then format (both via ruff; reads pyproject.toml / ruff.toml)
    python = { "ruff_organize_imports", "ruff_format" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  formatters = {
    clang_format = {
      -- use the project's .clang-format; fall back to LLVM style if none exists
      prepend_args = { "--style=file", "--fallback-style=llvm" },
    },
  },

  format_on_save = function(bufnr)
    -- toggle with :FormatToggle (global) or :FormatToggle! (this buffer only)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 1000, lsp_format = "fallback" }
  end,
}

vim.api.nvim_create_user_command("FormatToggle", function(args)
  if args.bang then
    vim.b.disable_autoformat = not vim.b.disable_autoformat
    vim.notify("Buffer autoformat: " .. (vim.b.disable_autoformat and "off" or "on"))
  else
    vim.g.disable_autoformat = not vim.g.disable_autoformat
    vim.notify("Global autoformat: " .. (vim.g.disable_autoformat and "off" or "on"))
  end
end, { bang = true, desc = "Toggle format on save" })

return options
