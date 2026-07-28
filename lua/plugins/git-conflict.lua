return {
  "akinsho/git-conflict.nvim",
  version = "*",
  event = "VeryLazy", -- or "BufReadPost" if you want it ready as soon as a file loads
  opts = {
    default_mappings = true, -- disable if you want to define your own below
    default_commands = true, -- disable if you want to define your own commands
    disable_diagnostics = false, -- true if LSP diagnostics clutter the conflict markers
    list_opener = "copen", -- command used to open quickfix list with :GitConflictListQf
    highlights = {
      incoming = "DiffAdd",
      current = "DiffText",
    },
  },
}
