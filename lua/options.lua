require "nvchad.options"

local g=vim.g
local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!
o.spell=true
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
vim.g.clipboard = {
  name = "tmux",
  copy = {
    ["+"] = "tmux load-buffer -",
    ["*"] = "tmux load-buffer -",
  },
  paste = {
    ["+"] = "tmux save-buffer -",
    ["*"] = "tmux save-buffer -",
  },
  cache_enabled = 1,
}

