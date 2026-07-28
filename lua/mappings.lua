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


map("n", "<leader>e", ":lua require('nvim-tree.api').tree.toggle({focus=true,find_file=true})<CR>", { desc = "Toggle nvtree",silent=true })
-- Neogen docstring generator
map("n", "<Leader>nf", ":lua require('neogen').generate({type='func'})<CR>", {desc="Neogen generate annotation for current function"})
map("n", "<Leader>nc", ":lua require('neogen').generate({type = 'class'})<CR>", {desc="Neogen generate annotation for current class"})

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
--
--
-- Tagbar
--
map("n", "<leader>tb", "<cmd>TagbarToggle<CR>", { desc = "Toggle Tagbar side window", silent = true })


-- Trouble LSP 
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>",{ desc = "Workspace Diagnostics (Trouble)" })

-- Current buffer diagnostics only
map("n", "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",{ desc = "Buffer Diagnostics (Trouble)" })

-- ─── LSP ──────────────────────────────────────────────────────────────────────
-- Document symbols (like tagbar but powered by LSP)
map("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false win.position=right<CR>",{ desc = "Document Symbols (Trouble)" })

-- LSP references for word under cursor
map("n", "<leader>xr", "<cmd>Trouble lsp_references toggle focus=false win.position=right<CR>",{ desc = "LSP References (Trouble)" })

-- LSP definitions
map("n", "<leader>xd", "<cmd>Trouble lsp_definitions toggle<CR>",{ desc = "LSP Definitions (Trouble)" })

-- LSP type definitions
map("n", "<leader>xt", "<cmd>Trouble lsp_type_definitions toggle<CR>",{ desc = "LSP Type Definitions (Trouble)" })

-- LSP implementations
map("n", "<leader>xi", "<cmd>Trouble lsp_implementations toggle<CR>",{ desc = "LSP Implementations (Trouble)" })

-- Incoming calls
map("n", "<leader>xI", "<cmd>Trouble lsp_incoming_calls toggle<CR>",{ desc = "LSP Incoming Calls (Trouble)" })

-- Outgoing calls
map("n", "<leader>xO", "<cmd>Trouble lsp_outgoing_calls toggle<CR>", { desc = "LSP Outgoing Calls (Trouble)" })

-- ─── Quickfix / Loclist ───────────────────────────────────────────────────────
map("n", "<leader>xq", "<cmd>Trouble qflist toggle<CR>", { desc = "Quickfix List (Trouble)" })

map("n", "<leader>xl", "<cmd>Trouble loclist toggle<CR>", { desc = "Location List (Trouble)" })

-- ─── Navigate items without opening Trouble window ────────────────────────────
-- Jump to next diagnostic item (wraps around)
map("n", "]x", function()
  require("trouble").next({ skip_groups = true, jump = true })
end, { desc = "Next Trouble Item" })

-- Jump to previous diagnostic item (wraps around)
map("n", "[x", function()
  require("trouble").prev({ skip_groups = true, jump = true })
end, { desc = "Prev Trouble Item" })

-- Jump to first item
map("n", "[X", function()
  require("trouble").first({ skip_groups = true, jump = true })
end, { desc = "First Trouble Item" })

-- Jump to last item
map("n", "]X", function()
  require("trouble").last({ skip_groups = true, jump = true })
end, { desc = "Last Trouble Item" })

-- ─── Telescope / fzf-lua integration ──────────────────────────────────────────
-- After a telescope search, send results to Trouble instead of quickfix
-- (call this from inside a telescope picker)
map("n", "<leader>xT", function()
  require("trouble.sources.telescope").open()
end, { desc = "Send Telescope Results to Trouble" })
