require "nvchad.options"

-- add yours here!

-- local o = vim.o
local g=vim.g
-- o.cursorlineopt ='both' -- to enable cursorline!
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

