return {
	cmd = { "vscode-css-language-server", "--stdio" }, -- mismo servidor soporta SCSS
	filetypes = { "scss", "sass", "less" },
	root_markers = { "package.json", ".git" },
}
