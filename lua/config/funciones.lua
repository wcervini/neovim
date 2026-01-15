-- lua/config/funciones.lua
local M = {}

-- 1. Ayudante para las descripciones de los keymaps
M.opts = function(desc)
	return { noremap = true, silent = true, desc = desc }
end

-- 2. Función para obtener la ruta de TypeScript (Solución al error del LSP)
M.get_pnpm_tsdk = function()
	-- Ejecuta pnpm root -g y limpia espacios/saltos de línea
	local handle = io.popen("pnpm root -g")
	local pnpm_root = handle:read("*a"):gsub("%s+$", "")
	handle:close()

	if pnpm_root ~= "" then
		-- Convertimos barras de Windows \ a / y añadimos la ruta de TS
		local path = pnpm_root .. "/typescript/lib"
		return path:gsub("\\", "/")
	end
	return nil
end

-- 3. Abrir borrador de cambios (.git/COMMIT_DRAFT)
M.abrir_borrador = function()
	-- Obtener la carpeta .git del proyecto actual
	local git_dir = vim.fn.system("git rev-parse --git-dir"):gsub("%s+$", "")

	if vim.v.shell_error ~= 0 then
		print("Error: No estás en un repositorio Git")
		return
	end

	-- Construir ruta del archivo temporal
	local draft_path = (git_dir .. "/COMMIT_DRAFT"):gsub("\\", "/")

	-- Abrir en un split vertical a la derecha
	vim.cmd("vsplit " .. draft_path)

	-- Configurar el buffer
	vim.bo.filetype = "markdown"
	vim.cmd("setlocal wrap")

	-- Si el archivo está vacío, poner una guía
	if vim.api.nvim_buf_line_count(0) <= 1 and vim.api.nvim_buf_get_lines(0, 0, -1, false)[1] == "" then
		vim.api.nvim_buf_set_lines(0, 0, 0, false, { "# Notas para el commit:", "- " })
	end
end

-- 4. Hacer commit usando las notas
M.git_commit_borrador = function()
	local git_dir = vim.fn.system("git rev-parse --git-dir"):gsub("%s+$", "")
	if vim.v.shell_error ~= 0 then
		return
	end

	local draft_path = (git_dir .. "/COMMIT_DRAFT"):gsub("\\", "/")

	if vim.fn.filereadable(draft_path) == 0 then
		print("No hay notas guardadas en " .. draft_path)
		return
	end

	-- Comando:
	-- -a: añade cambios detectados
	-- -F: usa el archivo como mensaje
	-- --edit: te permite escribir el título antes de finalizar
	local cmd = string.format("split | term git commit -a -F %s --edit", vim.fn.shellescape(draft_path))

	vim.cmd(cmd)
	print("¡Ponle título al commit arriba de tus notas, guarda y cierra!")
end

return M
