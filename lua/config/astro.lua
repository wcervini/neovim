-- Crea el archivo ~/.config/nvim/lua/config/astro.lua
local M = {}

function M.setup()
	-- Configuraciones del plugin
	vim.g.astro_typescript = "enable"
	vim.g.astro_indent = {
		enable = true,
		shiftwidth = 2,
	}

	-- Configurar keymaps específicas para astro (opcional)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "astro",
		callback = function()
			vim.keymap.set("n", "<leader>fa", "gg=G", { buffer = true, desc = "Format Astro file" })
		end,
	})
end

return M
