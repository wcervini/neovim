local k = vim.keymap.set
local opts = { noremap = true, silent = true }

k("n", "<leader>bc", ":bd<CR>", opts)
k("n", "<leader>w", ":w<CR>", opts)
k("n", "<leader>5", ":source %<CR>", opts)
k("n", "<Tab>", ":bnext<CR>", opts)
k("n", "<S-Tab>", ":bprevious<CR>", opts)
k("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", opts)
k("n", "<M-w>", ":split<CR>", opts)
k("n", "<M-v>", ":vsplit<CR>", opts)
k("n", "<C-q>", ":quit<CR>", opts)
k("n", "<leader>ft", vim.lsp.buf.format, { desc = "Format file" }, opts)
-- Normal-mode commands
k('n', '<A-j>', ':MoveLine(1)<CR>', opts)
k('n', '<A-k>', ':MoveLine(-1)<CR>', opts)
k('n', '<A-h>', ':MoveHChar(-1)<CR>', opts)
k('n', '<A-l>', ':MoveHChar(1)<CR>', opts)
k('n', '<leader>wf', ':MoveWord(1)<CR>', opts)
k('n', '<leader>wb', ':MoveWord(-1)<CR>', opts)

-- Visual-mode commands
k('v', '<A-j>', ':MoveBlock(1)<CR>', opts)
k('v', '<A-k>', ':MoveBlock(-1)<CR>', opts)
k('v', '<A-h>', ':MoveHBlock(-1)<CR>', opts)
k('v', '<A-l>', ':MoveHBlock(1)<CR>', opts)

-- Git keymaps
k("n", "<leader>ga", "<cmd>G add %<cr>", opts)
