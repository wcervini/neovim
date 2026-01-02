vim.g.mapleader = " "
require("config.options")
require("config.keymaps")
require("config.autocmd")
require("config.lazy")
require("config.lspconfig")
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
})
