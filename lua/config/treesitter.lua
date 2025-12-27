if vim.fn.has("win32") == 1 then
    vim.env.CC = "gcc" -- o "zig cc" si prefieres zig
end
require("nvim-treesitter").setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})
require("nvim-treesitter.install").compilers = { "gcc"}


local languages = {
      "vim",
      "lua",
      "vimdoc",
      "html",
      "css",
      "javascript",
      "typescript",
      "svelte",
      "python",
      "toml",
      "markdown",
      "vue",
      "luadoc",
      "json",
      "go",
      "gomod",
      "astro",
      "powershell",
}

local unix_languages = {
	"c",
	"cpp",
	"zig",
	"rust",
}

-- Combine languages based on platform
local languages_to_install = languages
if vim.fn.has("unix") == 1 then
    vim.list_extend(languages_to_install, unix_languages)
end

require("nvim-treesitter").install(languages_to_install)

-- Enable treesitter-based indentation for specific filetypes
-- This replaces: indent = { enable = true } from master branch

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"python",
		"lua",
		"rust",
		"javascript",
		"typescript",
		"tsx",
		"jsx",
		"c",
		"cpp",
		"html",
		"css",
	},
	callback = function()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

-- Enable treesitter-based folding
-- This replaces the fold module from master branch

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Optional folding settings
vim.opt.foldenable = false -- Start with folds open
vim.opt.foldlevel = 99 -- High foldlevel to keep most folds open
vim.opt.foldlevelstart = 99 -- Start editing with all folds open
vim.opt.foldnestmax = 4 -- Limit fold nesting

-- This replicates the old `auto_install = true` behavior
-- When you open a file, if the parser is missing, it will be installed

local function ensure_parser_installed(lang)
	local parsers = require("nvim-treesitter.parsers")

	-- Check if parser is already installed
	if not parsers[lang] then
		vim.notify("Installing treesitter parser for: " .. lang, vim.log.levels.INFO)
		-- require("nvim-treesitter").install({ lang })
	end
end

-- Auto-install parser when opening a file
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		-- Get the treesitter language for this filetype
		local lang = vim.treesitter.language.get_lang(args.match)

		if lang then
			ensure_parser_installed(lang)
		end
	end,
})

-- ============================================================================
-- USEFUL COMMANDS AND KEYMAPS
-- ============================================================================

-- Command to manually install a parser
vim.api.nvim_create_user_command("TSInstallLanguage", function(opts)
	local lang = opts.args
	if lang and lang ~= "" then
		require("nvim-treesitter").install({ lang })
	else
		vim.notify("Usage: :TSInstallLanguage <language>", vim.log.levels.ERROR)
	end
end, {
	nargs = 1,
	complete = function()
		-- You could add tab completion here for available parsers
		return {}
	end,
})


