-- En tu archivo de plugins principal
return {
	{
		"wuelnerdotexe/vim-astro",
		ft = "astro",
		config = function()
			require("config.astro") -- Llama a un módulo específico
		end,
	},
}
