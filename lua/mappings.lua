require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- Build the LaTeX document
map("n", "<leader>b", "<cmd>VimtexCompile<CR>", { desc = "Build LaTeX document", silent = true })

-- Open/close the table of contents
map("n", "<leader>i", "<cmd>VimtexTocOpen<CR>", { desc = "Open LaTeX TOC", silent = true })

-- View the LaTeX document in the specified viewer
map("n", "<leader>v", "<cmd>VimtexView<CR>", { desc = "View LaTeX document", silent = true })

-- Clear the Vimtex cache
map("n", "<leader>ac", "<cmd>:VimtexClearCache All<CR>", { desc = "Clear all Vimtex cache", silent = true })

-- Clean auxiliary LaTeX files
map("n", "<leader>ak", "<cmd>VimtexClean<CR>", { desc = "Clean auxiliary LaTeX files", silent = true })

-- Count words in the LaTeX document
map("n", "<leader>aw", "<cmd>VimtexCountWords!<CR>", { desc = "Count words in LaTeX document", silent = true })

-- Open various LaTeX-related files
map("n", "<leader>ae", "<cmd>e ~/.config/nvim/lua/snippets/tex.snippets<CR>", { desc = "Edit LaTeX snippets", silent = true })
map("n", "<leader>ag", "<cmd>e ~/.config/nvim/lua/templates/Glossary.tex<CR>", { desc = "Edit LaTeX glossary template", silent = true })
-- Error handling and reporting for LaTeX
map("n", "<leader>ar", "<cmd>VimtexErrors<CR>", { desc = "Show LaTeX compile errors", silent = true })
map("i", "jk", "<ESC>", { desc = "Escape to normal mode", silent = true })
map("i", "<leader>q", "<cmd>TagbarToggle<CR>", { desc = "Toggle Tagbar side window", silent = true })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
