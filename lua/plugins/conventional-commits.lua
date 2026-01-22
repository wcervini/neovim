return {
	"zerbiniandrea/conventional-commits.nvim",
	cmd = "ConventionalCommit",
	config = function()
			-- Optional configuration here
			local show_emoji_step = true, -- Show emoji selection step
			local show_preview = true, -- Show preview before committing
			local border = "rounded", -- Border style ('rounded', 'single', 'double', 'solid')

			-- Customize commit types
			commit_types = {
				{ key = "feat", description = "A new feature" },
				{ key = "fix", description = "A bug fix" },
				{ key = "docs", description = "Documentation changes" },
				{ key = "refactor", description = "Code refactoring" },
				-- Add your own types...
		}
	end,
	keys = {
		{ "<leader>xc", "<cmd>ConventionalCommit<cr>", desc = "Conventional Commit" },
	},
}

