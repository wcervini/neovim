-- lua/config/commits_functions.lua
local M = {}

M.get_pnpm_tsdk = function()
	local handle = io.popen("pnpm root -g")
	if not handle then
		return nil
	end
	local pnpm_root = handle:read("*a") or ""
	handle:close()

	pnpm_root = pnpm_root:gsub("%s+$", "")
	if pnpm_root ~= "" then
		local path = pnpm_root .. "/typescript/lib"
		return path:gsub("\\", "/")
	end
	return nil
end

M.abrir_borrador = function()
	local git_dir = vim.fn.system("git rev-parse --git-dir")
	if vim.v.shell_error ~= 0 then
		print("Error: No estás en un repositorio Git")
		return
	end
	git_dir = git_dir:gsub("%s+$", "")

	local draft_path = (git_dir .. "/COMMIT_DRAFT"):gsub("\\", "/")

	vim.cmd("vsplit " .. draft_path)
	vim.bo.filetype = "markdown"
	vim.cmd("setlocal wrap")

	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	if #lines == 1 and lines[1] == "" then
		vim.api.nvim_buf_set_lines(0, 0, 1, false, { "# Notas para el commit:", "- " })
	end
end

M.git_commit_borrador = function()
	local git_dir = vim.fn.system("git rev-parse --git-dir")
	if vim.v.shell_error ~= 0 then
		print("Error: No estás en un repositorio Git")
		return
	end
	git_dir = git_dir:gsub("%s+$", "")

	local draft_path = (git_dir .. "/COMMIT_DRAFT"):gsub("\\", "/")
	if vim.fn.filereadable(draft_path) == 0 then
		print("No hay notas guardadas en " .. draft_path)
		return
	end

	local cmd = string.format("split | term git commit -a -F %s --edit", vim.fn.shellescape(draft_path))
	vim.cmd(cmd)
	print("¡Ponle título al commit arriba de tus notas, guarda y cierra!")
end
return M
