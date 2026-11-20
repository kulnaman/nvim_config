require "nvchad.mappings"

-- All custom keybindings live in this file.
-- Plugin specs in lua/plugins/ contain no keymaps; lazy.nvim loads a plugin the
-- first time one of these mappings calls require("<plugin>") or runs its :Command.

local map = vim.keymap.set

-- ─── General ──────────────────────────────────────────────────────────────────
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "Escape to normal mode", silent = true })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- ─── File tree ────────────────────────────────────────────────────────────────
map("n", "<leader>e", function()
  require("nvim-tree.api").tree.toggle { focus = true, find_file = true }
end, { desc = "Toggle nvtree", silent = true })

-- ─── LaTeX (vimtex) ───────────────────────────────────────────────────────────
map("n", "<leader>b", "<cmd>VimtexCompile<CR>", { desc = "Build LaTeX document", silent = true })
map("n", "<leader>i", "<cmd>VimtexTocOpen<CR>", { desc = "Open LaTeX TOC", silent = true })
map("n", "<leader>v", "<cmd>VimtexView<CR>", { desc = "View LaTeX document", silent = true })
map("n", "<leader>ac", "<cmd>VimtexClearCache All<CR>", { desc = "Clear all Vimtex cache", silent = true })
map("n", "<leader>ak", "<cmd>VimtexClean<CR>", { desc = "Clean auxiliary LaTeX files", silent = true })
map("n", "<leader>aw", "<cmd>VimtexCountWords!<CR>", { desc = "Count words in LaTeX document", silent = true })
map("n", "<leader>ae", "<cmd>e ~/.config/nvim/lua/snippets/tex.snippets<CR>", { desc = "Edit LaTeX snippets", silent = true })
map("n", "<leader>ag", "<cmd>e ~/.config/nvim/lua/templates/Glossary.tex<CR>", { desc = "Edit LaTeX glossary template", silent = true })
map("n", "<leader>ar", "<cmd>VimtexErrors<CR>", { desc = "Show LaTeX compile errors", silent = true })

-- ─── Neogen (docstrings) ──────────────────────────────────────────────────────
map("n", "<leader>nf", function() require("neogen").generate { type = "func" } end, { desc = "Neogen annotate function" })
map("n", "<leader>nc", function() require("neogen").generate { type = "class" } end, { desc = "Neogen annotate class" })

-- ─── Outline (aerial, replaces tagbar) ────────────────────────────────────────
map("n", "<leader>o", "<cmd>AerialToggle!<CR>", { desc = "Outline: toggle sidebar", silent = true })
map("n", "<leader>O", "<cmd>AerialNavToggle<CR>", { desc = "Outline: floating navigator", silent = true })

-- ─── Trouble ──────────────────────────────────────────────────────────────────
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Workspace Diagnostics (Trouble)" })
map("n", "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Buffer Diagnostics (Trouble)" })
map("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false win.position=right<CR>", { desc = "Document Symbols (Trouble)" })
map("n", "<leader>xr", "<cmd>Trouble lsp_references toggle focus=false win.position=right<CR>", { desc = "LSP References (Trouble)" })
map("n", "<leader>xd", "<cmd>Trouble lsp_definitions toggle<CR>", { desc = "LSP Definitions (Trouble)" })
map("n", "<leader>xt", "<cmd>Trouble lsp_type_definitions toggle<CR>", { desc = "LSP Type Definitions (Trouble)" })
map("n", "<leader>xi", "<cmd>Trouble lsp_implementations toggle<CR>", { desc = "LSP Implementations (Trouble)" })
map("n", "<leader>xI", "<cmd>Trouble lsp_incoming_calls toggle<CR>", { desc = "LSP Incoming Calls (Trouble)" })
map("n", "<leader>xO", "<cmd>Trouble lsp_outgoing_calls toggle<CR>", { desc = "LSP Outgoing Calls (Trouble)" })
map("n", "<leader>xq", "<cmd>Trouble qflist toggle<CR>", { desc = "Quickfix List (Trouble)" })
map("n", "<leader>xl", "<cmd>Trouble loclist toggle<CR>", { desc = "Location List (Trouble)" })

map("n", "]x", function() require("trouble").next { skip_groups = true, jump = true } end, { desc = "Next Trouble Item" })
map("n", "[x", function() require("trouble").prev { skip_groups = true, jump = true } end, { desc = "Prev Trouble Item" })
map("n", "[X", function() require("trouble").first { skip_groups = true, jump = true } end, { desc = "First Trouble Item" })
map("n", "]X", function() require("trouble").last { skip_groups = true, jump = true } end, { desc = "Last Trouble Item" })

-- NOTE: trouble.sources.telescope.open() needs a picker's prompt buffer, so it
-- only works as a mapping *inside* Telescope (telescope defaults.mappings),
-- not from normal mode. Left here commented for reference.
-- map("n", "<leader>xT", function() require("trouble.sources.telescope").open() end, { desc = "Send Telescope Results to Trouble" })

-- ─── Debugging (nvim-dap) ─────────────────────────────────────────────────────
local function dap(fn, ...)
  local args = { ... }
  return function()
    require("dap")[fn](unpack(args))
  end
end
local function dapui(fn)
  return function()
    require "dap" -- loads nvim-dap and runs its config (which sets up dap-ui)
    require("dapui")[fn]()
  end
end

map("n", "<F5>", dap "continue", { desc = "Debug: start / continue" })
map("n", "<leader>dc", dap "continue", { desc = "Debug: start / continue" })
map("n", "<leader>db", dap "toggle_breakpoint", { desc = "Debug: toggle breakpoint" })
map("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input "Condition: ")
end, { desc = "Debug: conditional breakpoint" })
map("n", "<leader>dn", dap "step_over", { desc = "Debug: step over (next)" })
map("n", "<leader>di", dap "step_into", { desc = "Debug: step into" })
map("n", "<leader>do", dap "step_out", { desc = "Debug: step out" })
map("n", "<leader>dC", dap "run_to_cursor", { desc = "Debug: run to cursor" })
map("n", "<leader>dl", dap "run_last", { desc = "Debug: rerun last" })
map("n", "<leader>dq", dap "terminate", { desc = "Debug: stop" })
map("n", "<leader>dr", function() require("dap").repl.toggle() end, { desc = "Debug: toggle REPL" })
map("n", "<leader>du", dapui "toggle", { desc = "Debug: toggle UI" })
map({ "n", "v" }, "<leader>de", dapui "eval", { desc = "Debug: evaluate expression" })

-- ─── Tests (neotest) ──────────────────────────────────────────────────────────
local function nt(fn)
  return function()
    fn(require "neotest")
  end
end

map("n", "<leader>tt", nt(function(n) n.run.run() end), { desc = "Test: run nearest" })
map("n", "<leader>tf", nt(function(n) n.run.run(vim.fn.expand "%") end), { desc = "Test: run file" })
map("n", "<leader>ta", nt(function(n) n.run.run(vim.fn.getcwd()) end), { desc = "Test: run all" })
map("n", "<leader>tl", nt(function(n) n.run.run_last() end), { desc = "Test: rerun last" })
map("n", "<leader>td", nt(function(n) n.run.run { strategy = "dap" } end), { desc = "Test: debug nearest" })
map("n", "<leader>tS", nt(function(n) n.run.stop() end), { desc = "Test: stop" })
map("n", "<leader>ts", nt(function(n) n.summary.toggle() end), { desc = "Test: summary tree" })
map("n", "<leader>to", nt(function(n) n.output.open { enter = true, auto_close = true } end), { desc = "Test: show output" })
map("n", "<leader>tO", nt(function(n) n.output_panel.toggle() end), { desc = "Test: output panel" })
map("n", "]t", nt(function(n) n.jump.next { status = "failed" } end), { desc = "Next failed test" })
map("n", "[t", nt(function(n) n.jump.prev { status = "failed" } end), { desc = "Prev failed test" })

-- ─── Formatting ───────────────────────────────────────────────────────────────
-- :FormatToggle / :FormatToggle! (defined in configs/conform.lua) switch format-on-save

-- ─── LSP (buffer-local, set when a server attaches) ───────────────────────────
-- NvChad's own LSP maps are still applied from configs/lspconfig.lua.
local function lsp_maps(client, bufnr)
  local function bmap(mode, lhs, rhs, desc)
    map(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
  end

  bmap("n", "gd", vim.lsp.buf.definition, "LSP Go to Definition")
  bmap("n", "gD", vim.lsp.buf.declaration, "LSP Go to Declaration")
  bmap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP Code action (add import, fixes)")
  bmap("n", "<leader>lh", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }, { bufnr = bufnr })
  end, "LSP Toggle inlay hints")

  if client.name == "clangd" then
    bmap("n", "<leader>cs", "<cmd>LspClangdSwitchSourceHeader<CR>", "Switch source/header")
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspMappings", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      lsp_maps(client, args.buf)
    end
  end,
})

-- NvChad loads this file slightly after startup; cover servers that attached first
for _, client in ipairs(vim.lsp.get_clients()) do
  for bufnr in pairs(client.attached_buffers) do
    lsp_maps(client, bufnr)
  end
end

