vim.g.mapleader = " "
require("config.options")
require("config.keymaps")
require("config.autocmd")
require("config.lazy")
require("config.lspconfig")
--require('lspconfig').rust_analyzer.setup{
--  settings = {
--    ['rust-analyzer'] = {
--      diagnostics = { enable = true },
--    },
--  },
--}

-- require("config.menu").open("menu_opts",{})
