return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewRefresh",
    "DiffviewFileHistory",
  },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview: Open" },
    { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Diffview: Close" },
    { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview: File History (repo)" },
    { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: File History (current file)" },
  },
opts = {
  enhanced_diff_hl = true, -- better looking diff highlights
  view = {
    merge_tool = {
      layout = "diff3_mixed", -- good default for 3-way merge conflicts
      disable_diagnostics = true, -- don't clutter conflict view with LSP diagnostics
    },
  },
  keymaps = {
    view = {
      -- these are the keymaps active *inside* the diffview window
      { "n", "<leader>co", "<cmd>DiffviewConflictChooseOurs<cr>" }, -- not a real default cmd, just illustrating the idea
    },
  },
},
}
