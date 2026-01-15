return {
	cmd = { "astro-ls", "--stdio" },
	filetypes = { "astro" },
	root_markers = { "astro.config.mjs", "package.json", ".git" },
	single_file_support = true,
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = false
	end,
}
