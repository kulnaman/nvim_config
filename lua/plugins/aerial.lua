-- Code outline. Loads on :Aerial* commands (mapped in mappings.lua)
return {
  "stevearc/aerial.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  cmd = { "AerialToggle", "AerialOpen", "AerialNavToggle" },
  opts = function()
    return require "configs.aerial"
  end,
}
