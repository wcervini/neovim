vim.g.mapleader = " "
require("config.options")
require("config.keymaps")
require("config.autocmd")
require("config.lazy")
require("config.telescope_tree")
require("config.lspconfig")
require("config.mason_autoinstall")
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
})
