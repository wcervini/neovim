return {
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	root_dir = require("lspconfig.util").root_pattern("tsconfig.json", "package.json", ".git"),
	init_options = {
		typescript = {
			tsdk = "./node_modules/typescript/lib",
		},
	},
}
