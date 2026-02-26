return {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	-- Añadimos "manage.py" para Django y "app.py" o "wsgi.py" para Flask
	root_markers = {
		"manage.py",
		"app.py",
		"wsgi.py",
		"pyproject.toml",
		"setup.py",
		"requirements.txt",
		".git",
		"main.py",
	},
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace",
				-- Añadimos esto para que no sea tan estricto con los tipos dinámicos de Django/Flask
				typeCheckingMode = "basic",
			},
		},
	},
}
