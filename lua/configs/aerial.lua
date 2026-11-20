-- lua/configs/aerial.lua
-- Code outline from LSP / tree-sitter. Replaces tagbar + vim-gutentags.
-- Keymaps: lua/mappings.lua (Outline section)
return {
  backends = { "lsp", "treesitter", "markdown", "man" },
  layout = { default_direction = "prefer_right", min_width = 30, max_width = { 50, 0.25 } },
  show_guides = true,
  attach_mode = "global",
  highlight_on_hover = true,
  autojump = true,
}
