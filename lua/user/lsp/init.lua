local status_ok,lsp = pcall(require, "lspconfig")
if not status_ok then
  return
end
local status_ok,coq=pcall(require,"coq")
if not status_ok then
  return
end
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = coq.lsp_ensure_capabilities(capabilities)
lsp.clangd.setup(coq.lsp_ensure_capabilities()) -- after
lsp.pylsp.setup {
  cmd={"/home/nkulshre/miniforge3/bin/pylsp"},
  on_attach = custom_attach,
  settings = {
    pylsp = {
      plugins = {
        -- Formatter options
        black = { enabled = true },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        -- Linter options
        pylint = { enabled = true, executable = "pylint" },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        -- Type checker
        pylsp_mypy = { enabled = true },
        -- Auto-completion options
        jedi_completion = { fuzzy = true },
        -- Import sorting
        pyls_isort = { enabled = true },
      },
    },
  },
  flags = {
    debounce_text_changes = 200,
  },
  capabilities = capabilities, -- Pass the enhanced capabilities to the lsp server
}


