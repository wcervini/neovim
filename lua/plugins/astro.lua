return {
	{
		"wuelnerdotexe/vim-astro",
		ft = "astro",
		config = function()
			vim.g.astro_typescript = "enable"
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"astro", -- Añade astro a los parsers instalados
				-- otros parsers que uses...
			},
		},
	},
}
