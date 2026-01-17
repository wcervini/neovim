local opt = require("config.funciones").opts
local f = require("config.funciones")
local k = vim.keymap.set

k("n", "<leader>w", ":bd<CR>", opt("Close current buffer"))
k("n", "<Tab>", ":bnext<CR>", opt("Show next buffer"))
k("n", "<S-Tab>", ":bprevious<CR>", opt("Show previous buffer"))
k("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", opt("Show/Hide NvimTree"))
k("n", "<M-w>", ":split<CR>", opt("Split buffer Horizontal"))
k("n", "<M-v>", ":vsplit<CR>", opt("Split buffer Vertical"))
k("n", "<C-q>", ":quit<CR>", opt("Close current window"))
k("n", "<leader>ft", vim.lsp.buf.format, opt("format current buffer"))

-- Normal-mode commands
k("n", "<A-j>", ":MoveLine(1)<CR>", opt("Move Line Down"))
k("n", "<A-k>", ":MoveLine(-1)<CR>", opt("Move line Up"))
k("n", "<A-h>", ":MoveHChar(-1)<CR>", opt("No help"))
k("n", "<A-l>", ":MoveHChar(1)<CR>", opt("No Help"))
k("n", "<leader>wf", ":MoveWord(1)<CR>", opt("Move Word Down"))
k("n", "<leader>wb", ":MoveWord(-1)<CR>", opt("Move Word Up"))

-- Visual-mode commands
k("v", "<A-j>", ":MoveBlock(1)<CR>", opt("Visual Move Block down"))
k("v", "<A-k>", ":MoveBlock(-1)<CR>", opt("Visual Move Block Up"))
k("v", "<A-h>", ":MoveHBlock(-1)<CR>", opt(""))
k("v", "<A-l>", ":MoveHBlock(1)<CR>", opt(""))

-- Git keymaps
k("n", "<leader>ga", "<cmd>Gwrite<cr>", opt("Git Add current file"))
k("n", "<leader>gco", "<cmd>G commit<cr>", opt("Git Commit"))
k("n", "<leader>gpu", "<cmd>G push<cr>", opt("Git Commit"))
k("n", "<leader>gt", "<cmd>GitTree<cr>", opt("Git Commit"))

-- Emoji
k("i", "<leader>je", "<cmd>Telescope emoji<cr>", opt("Emojis"))
k("i", "<leader>ji", "<cmd>Telescope symbols sets=emoji,gitmoji<cr>", opt("Insertar Emoji"))
-- Archivo Borrador Changelog
k("n", "<leader>jn", f.abrir_borrador, { desc = "Anotar cambios (Journal)" })
k("n", "<leader>jc", f.git_commit_borrador, { desc = "Commit usando notas" })
