vim.g.mapleader = " "
vim.g.localmapleader = "\\"
require("config.options")
require("config.keymaps")
require("config.commits_functions")
require("config.autocmd")
require("config.lazy")
require("config.telescope_tree")
require("config.lspconfig")
require("plugins.autocomplete") -- ✅ Añade esta

vim.api.nvim_create_autocmd("FileType", {
	pattern = "gitcommit",
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.textwidth = 72
		vim.cmd("startinsert")
	end,
})

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
})
