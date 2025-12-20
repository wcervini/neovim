local builtin = require('telescope.builtin')
local k = vim.keymap.set
k('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
k('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
k('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
k('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
