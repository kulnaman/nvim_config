-- ~/.config/nvim/lua/config/gutentags.lua

vim.g.gutentags_enabled = 1

vim.g.gutentags_cache_dir = vim.fn.expand("~/.cache_tuo/nvim/ctags/")

vim.fn.mkdir(vim.g.gutentags_cache_dir, "p")

vim.g.gutentags_project_root = { ".git", ".hg", ".svn", "Makefile", "package.json", "Cargo.toml" }

vim.g.gutentags_ctags_tagfile = ".tags"

-- Use universal-ctags extra fields
vim.g.gutentags_ctags_extra_args = {
  "--tag-relative=yes",
  "--fields=+ailmnS",
}

-- Exclude junk directories
vim.g.gutentags_ctags_exclude = {
  "*.git", "*.svn", "*.hg",
  "cache", "build", "dist", "node_modules",
  "*.pyc", "*.class", "*.jar",
  "*.min.js", "*.min.css",
  "vendor",
}

vim.g.gutentags_file_list_command = "rg --files"  -- uses ripgrep if available

vim.g.gutentags_define_advanced_commands = 1

