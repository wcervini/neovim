return {
	"fedepujol/move.nvim",
	opts = {
		line = {
			enable = true, -- Enables line movement
			indent = true, -- Toggles indentation
		},
		block = {
			enable = true, -- Enables block movement
			indent = true, -- Toggles indentation
		},
		word = {
			enable = true, -- Enables word movement
		},
		char = {
			enable = false, -- Enables char movement
		},
	},
	keys = {
		-- Normal Mode
		{ "<A-j>", ":MoveLine(1)<CR>", desc = "Move Line Up" },
		{ "<A-k>", ":MoveLine(-1)<CR>", desc = "Move Line Down" },
		{ "<A-h>", ":MoveHChar(-1)<CR>", desc = "Move Character Left" },
		{ "<A-l>", ":MoveHChar(1)<CR>", desc = "Move Character Right" },
		{ "<leader>wf", ":MoveWord(1)<CR>", desc = "Move Word Forward" },
		{ "<leader>wb", ":MoveWord(-1)<CR>", desc = "Move Word Backward" },
	},
}
