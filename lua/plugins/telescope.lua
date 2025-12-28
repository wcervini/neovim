return {
  "nvim-telescope/telescope.nvim", 
  tag = "v0.2.0",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {'<leader>ff', "<cmd>Telescope find_files<CR>", { desc = 'Telescope find files' }},
    {'<leader>fg', "<cmd>Telescope live_grep<CR>", { desc = 'Telescope live grep'}} ,
    {'<leader>fb', "<cmd>Telescope find_buffers<CR>", { desc = 'Telescope buffers' }},
    {'<leader>fg', "<cmd>Telescope help_tags<CR>", { desc = 'Telescope helps' }},
    {'<leader>fm', "<cmd>Telescope keymaps<CR>", { desc = 'Telescope keymaps' }},
    {'<leader>gs', "<cmd>Telescope git_status<CR>", { desc = 'Telescope Git Status' }},
  },
  opts = {
    }, 
}
  
