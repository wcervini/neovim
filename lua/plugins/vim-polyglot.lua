return {
	{
		"sheerun/vim-polyglot",
		lazy = false, -- o true + event = "VeryLazy"
		priority = 1000, -- carga temprano para syntax/indent
	},
	{
		"mattn/emmet-vim",
		ft = { "html", "css", "javascript", "vue", "astro" }, -- opcional lazy-load
		init = function()
			vim.g.user_emmet_leader_key = "," -- cambia trigger (default <C-y>)
		end,
	},
}
