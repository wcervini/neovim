local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- Capacidades para el autocompletado
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

-- Lista de servidores a configurar
local servers = {
	"lua_ls",
	"pyright",
	"emmet_language_server",
	"astro",
	"ts_ls",
	"vue_ls",
	"marksman", -- markdown
	"gopls", -- go
	"html",
	"cssls", -- css
	"rust_analyzer", -- rust
	"templ",
	"sassls", -- sass
	"svelte",
}

-- Función para cargar configuración personalizada desde la carpeta /lsp/
local function get_config(server_name)
	-- Mapeo de nombres de lspconfig a tus archivos en /lsp/ si son diferentes
	local name_map = {
		ts_ls = "typescript",
		marksman = "markdown",
		gopls = "go",
		cssls = "css",
		rust_analyzer = "rust",
		sassls = "sass",
	}

	local config_file = name_map[server_name] or server_name
	local status_ok, custom_config = pcall(require, "lsp." .. config_file)
	
	if status_ok then
		-- Mezclar capabilities personalizadas con las de cmp si existen
		custom_config.capabilities = vim.tbl_deep_extend(
			"force",
			capabilities,
			custom_config.capabilities or {}
		)
		return custom_config
	end
	
	return { capabilities = capabilities }
end

-- Configurar cada servidor
for _, server in ipairs(servers) do
	local config = get_config(server)
	lspconfig[server].setup(config)
end
