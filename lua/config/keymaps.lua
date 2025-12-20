local k = vim.keymap.set
k("n","<leader>bc" , ":bd<CR>")
k("n","<leader>w", ":w<CR>")
k("n","<leader>5", ":source %<CR>")
k("n", "<Tab>", ":bnext<CR>")
k("n","<S-Tab>",":bprevious<CR>")
k("n","<C-n>",":Explore<CR>")
k("n","<M-w>",":split<CR>")
k("n","<M-v>",":split<CR>")
k("n","<C-q>",":quit<CR>")



