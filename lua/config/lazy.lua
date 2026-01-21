-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ "404pilo/aicommits.nvim", config = true },
		{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },
		{
			"catppuccin/nvim",
			name = "catppuccin",
			priority= 1000,
			config = function()
				vim.cmd.colorscheme "catppuccin"
			end
		},
		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform will run multiple formatters sequentially
					python = { "isort", "black" },
					-- You can customize some of the format options for the filetype (:help conform.format)
					rust = { "rustfmt", lsp_format = "fallback" },
					-- Conform will run the first available formatter
					javascript = { "prettierd", "prettier", stop_after_first = true },
					typescript = { "prettierd", "prettier", stop_after_first = true },
					javascriptreact = { "prettierd", "prettier", stop_after_first = true },
					typescriptreact = { "prettierd", "prettier", stop_after_first = true },
					vue = { "prettierd", "prettier", stop_after_first = true },
					astro = { "prettierd", "prettier", stop_after_first = true },
					html = { "prettierd", "prettier", stop_after_first = true },
					css = { "prettierd", "prettier", stop_after_first = true },
					scss = { "prettierd", "prettier", stop_after_first = true },
					sass = { "prettierd", "prettier", stop_after_first = true },
					less = { "prettierd", "prettier", stop_after_first = true },
					markdown = { "prettierd", "prettier", stop_after_first = true },
					svelte = { "prettierd", "prettier", stop_after_first = true },
					go = { "goimports", "gofmt", stop_after_first = true },
				},
				format_on_save = { lsp_fallback = false },
			},
		},
		{
			"zbirenbaum/copilot.lua",
			cmd = "Copilot",
			event = "InsertEnter",
			config = function()
				require("copilot").setup({
					suggestion = {
						enabled = false,
						auto_trigger = true,
						keymap = {
							accept = "<M-l>",
							next = "<M-]>",
							prev = "<M-[>",
						},
					},
					panel = { enabled = false },
				})
			end,
		},
		{ "tpope/vim-fugitive", opt = {} },
		{
			'lewis6991/gitsigns.nvim',
			opts = {
				on_attach = function(bufnr)
					local gitsigns = require 'gitsigns'

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map('n', ']c', function()
						if vim.wo.diff then
							vim.cmd.normal { ']c', bang = true }
						else
							gitsigns.nav_hunk 'next'
						end
					end, { desc = 'Jump to next git [c]hange' })

					map('n', '[c', function()
						if vim.wo.diff then
							vim.cmd.normal { '[c', bang = true }
						else
							gitsigns.nav_hunk 'prev'
						end
					end, { desc = 'Jump to previous git [c]hange' })

					-- Actions
					-- visual mode
					map('v', '<leader>hs', function()
						gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
					end, { desc = 'git [s]tage hunk' })
					map('v', '<leader>hr', function()
						gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
					end, { desc = 'git [r]eset hunk' })
					-- normal mode
					map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
					map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
					map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
					map('n', '<leader>hu', gitsigns.stage_hunk, { desc = 'git [u]ndo stage hunk' })
					map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
					map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
					map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
					map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
					map('n', '<leader>hD', function()
						gitsigns.diffthis '@'
					end, { desc = 'git [D]iff against last commit' })
					-- Toggles
					map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
					map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })
				end,
			},
		},
		{
			'lukas-reineke/indent-blankline.nvim',
			-- Enable `lukas-reineke/indent-blankline.nvim`
			-- See `:help ibl`
			main = 'ibl',
			opts = {},
		},
		{
			"mfussenegger/nvim-lint",
			event = { "BufReadPre", "BufNewFile" },
			config = function()
				require("lint").linters_by_ft = {
					python = { "ruff" },
					javascript = { "eslint" },
					lua = { "luacheck" },
				}
				vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
					callback = function()
						require("lint").try_lint()
					end,
				})
			end,
		},
		{ "neovim/nvim-lspconfig", opt = {} },
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			opts = {
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					always_show_tabline = true,
					globalstatus = false,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
						refresh_time = 16, -- ~60fps
						events = {
							"WinEnter",
							"BufEnter",
							"BufWritePost",
							"SessionLoadPost",
							"FileChangedShellPost",
							"VimResized",
							"Filetype",
							"CursorMoved",
							"CursorMovedI",
							"ModeChanged",
						},
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			},
		},
		{
			"mason-org/mason.nvim",
			opts = {
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗"
					}
				},
				max_concurrent_installers = 10,
				keymaps = {
					toggle_package_expand = "<CR>",
					install_package = "i",
					update_package = "u",
					check_package_version = "c",
					update_all_packages = "U",
					check_outdated_packages = "C",
					uninstall_package = "X",
					cancel_installation = "<C-c>",
					apply_language_filter = "<C-f>",
					toggle_package_install_log = "<CR>",
					toggle_help = "g?",
				}
			}
		},
		{ "nvim-mini/mini.icons", version = "*" },
		{
			'fedepujol/move.nvim',
			opts = {
				line = {
					enable = true, -- Enables line movement
					indent = true  -- Toggles indentation
				},
				block = {
					enable = true, -- Enables block movement
					indent = true  -- Toggles indentation
				},
				word = {
					enable = true, -- Enables word movement
				},
				char = {
					enable = false -- Enables char movement
				}
			}
		},
		{
			"rcarriga/nvim-notify",
			config = function()
				require("notify").setup({
					timeout = 400,
					top_down = false,
					stages = "fade_in_slide_out",
					render = "default",
					max_width = 60,
				})
				vim.notify = function(msg, level, opts)
					if msg:match("treesitter") then return end
					require("notify")(msg, level, opts)
				end
			end,
		}, 
		{
			"nvim-tree/nvim-tree.lua",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			opts = {
				actions = {
					open_file = {
						quit_on_open = true,
					}
				}
			},
		},   
		{
			"NickvanDyke/opencode.nvim",
			dependencies = {
				-- Recommended for `ask()` and `select()`.
				-- Required for `snacks` provider.
				---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
				{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
			},
			config = function()
				---@type opencode.Opts
				vim.g.opencode_opts = {
					-- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
				}

				-- Required for `opts.events.reload`.
				vim.o.autoread = true

				-- Recommended/example keymaps.
				vim.keymap.set({ "n", "x" }, "<C-a>", function()
					require("opencode").ask("@this: ", { submit = true })
				end, { desc = "Ask opencode" })
				vim.keymap.set({ "n", "x" }, "<C-x>", function()
					require("opencode").select()
				end, { desc = "Execute opencode action…" })
				vim.keymap.set({ "n", "t" }, "<C-F1>", function()
					require("opencode").toggle()
				end, { desc = "Toggle opencode" })

				vim.keymap.set({ "n", "x" }, "go", function()
					return require("opencode").operator("@this ")
				end, { expr = true, desc = "Add range to opencode" })
				vim.keymap.set("n", "goo", function()
					return require("opencode").operator("@this ") .. "_"
				end, { expr = true, desc = "Add line to opencode" })

				vim.keymap.set("n", "<S-C-u>", function()
					require("opencode").command("session.half.page.up")
				end, { desc = "opencode half page up" })
				vim.keymap.set("n", "<S-C-d>", function()
					require("opencode").command("session.half.page.down")
				end, { desc = "opencode half page down" })

				-- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
				vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
				vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
			end,
		},
		{ "tpope/vim-rhubarb" },
		{
			"nvim-telescope/telescope-symbols.nvim",
			dependencies = { "nvim-telescope/telescope.nvim" },
		},
		{
			"nvim-telescope/telescope.nvim",
			tag = "v0.2.0",
			dependencies = { "nvim-lua/plenary.nvim" },
			keys = {
				{ "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Telescope find files" } },
				{ "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Telescope live grep" } },
				{ "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Telescope buffers" } },
				{ "<leader>fg", "<cmd>Telescope help_tags<CR>", { desc = "Telescope helps" } },
				{ "<leader>fs", "<cmd>Telescope command_history<CR>", { desc = "Telescope helps" } },
				{ "<leader>fm", "<cmd>Telescope keymaps<CR>", { desc = "Telescope keymaps" } },
				{ "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Telescope Git Status" } },
				{ "<leader>fx", "<cmd>Telescope live_grep<CR>", { desc = "Telescope live grep" } },
			},
			opts = {},
		},
		{
			"nvim-treesitter/nvim-treesitter",
			branch = "main",  
			lazy = false,     
			build = ":TSUpdate",
			config = function()
				require("config.treesitter")
			end,
		},
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			opts = {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			},
			keys = {
				{
					"<leader>?",
					function()
						require("which-key").show({ global = false })
					end,
					desc = "Buffer Local Keymaps (which-key)",
				},
			},
		},
		{
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			dependencies = {
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-cmdline",
				"saadparwaiz1/cmp_luasnip",
				"L3MON4D3/LuaSnip",
				"zbirenbaum/copilot-cmp",   -- Copilot
				"tzachar/cmp-ai",           -- DeepSeek
				"jcdickinson/codeium.nvim", -- Alternativa tipo-Copilot con Ollama
			},
			config = function()
				local cmp = require("cmp")
				local luasnip = require("luasnip")

				cmp.setup({
					snippet = {
						expand = function(args)
							luasnip.lsp_expand(args.body)
						end,
					},
					mapping = cmp.mapping.preset.insert({
						["<C-b>"] = cmp.mapping.scroll_docs(-4),
						["<C-f>"] = cmp.mapping.scroll_docs(4),
						["<C-Space>"] = cmp.mapping.complete(),
						["<C-e>"] = cmp.mapping.abort(),
						["<CR>"] = cmp.mapping.confirm({ select = true }),
						["<Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_next_item()
							elseif luasnip.expand_or_jumpable() then
								luasnip.expand_or_jump()
							else
								fallback()
							end
						end, { "i", "s" }),
						["<S-Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_prev_item()
							elseif luasnip.jumpable(-1) then
								luasnip.jump(-1)
							else
								fallback()
							end
						end, { "i", "s" }),
					}),
					sources = cmp.config.sources({
						{ name = "copilot",  priority = 1000 }, -- Copilot primero
						{ name = "codeium",  priority = 950 }, -- Ollama Codeium
						{ name = "nvim_lsp", priority = 900 },
						{ name = "cmp_ai",   priority = 800 }, -- DeepSeek
						{ name = "luasnip",  priority = 700 },
						{ name = "buffer",   priority = 600 },
						{ name = "path",     priority = 500 },
					}),
					formatting = {
						format = function(entry, vim_item)
							local icons = {
								copilot = "",
								nvim_lsp = "🔧",
								cmp_ai = "🤖",
								luasnip = "✨",
								buffer = "📄",
								path = "📁",
							}
							vim_item.kind = icons[entry.source.name] or vim_item.kind
							return vim_item
						end,
					},
				})

				-- CMDLINE
				cmp.setup.cmdline({ "/", "?" }, {
					mapping = cmp.mapping.preset.cmdline(),
					sources = { { name = "buffer" } }
				})

				cmp.setup.cmdline(":", {
					mapping = cmp.mapping.preset.cmdline(),
					sources = cmp.config.sources(
						{ { name = "path" } },
						{ { name = "cmdline" } }
					)
				})
			end
		},
		{
			"zbirenbaum/copilot.lua",
			event = "InsertEnter",
			config = function()
				require("copilot").setup({
					suggestion = {
						enabled = true,
						auto_trigger = true,
						keymap = {
							accept = "<M-l>",
							accept_word = false,
							accept_line = false,
							next = "<M-]>",
							prev = "<M-[>",
							dismiss = "<C-]>",
						},
					},
					panel = { enabled = false },
				})
			end
		},
		{
			"zbirenbaum/copilot-cmp",
			dependencies = { "zbirenbaum/copilot.lua", "hrsh7th/nvim-cmp" },
			config = function()
				require("copilot_cmp").setup({
					method = "getCompletionsCycling",
				})
			end
		},
		{
			"jcdickinson/codeium.nvim",
			event = "InsertEnter",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"MunifTanjim/nui.nvim",
				"hrsh7th/nvim-cmp",
			},
			config = function()
				require("codeium").setup({
					tools = {
						enabled = true,
						ollama = {
							model = "deepseek-coder:6.7b",
							system_prompt = "Eres un asistente de código especializado. Proporciona sugerencias concisas y precisas.",
							temperature = 0.1,
							top_p = 0.1,
						},
					},
					autocomplete = {
						enabled = true,
						trigger = "<C-g>",
						delay = 100,
						insert_on_accept = true,
					},
					cmp = {
						enabled = true,
					},
				})
			end
		},
		{
			"nomnivore/ollama.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"stevearc/dressing.nvim",
			},
			cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },
			keys = {
				{
					"<leader>oc",
					function()
						require("ollama").prompt({
							prompt = "Contexto del archivo:\n$context\n\nPregunta: $input\nRespuesta:",
							action = "display",
						})
					end,
					desc = "Chat con contexto",
					mode = "n",
				},
				{
					"<leader>or",
					function()
						require("ollama").prompt({
							prompt = "Refactoriza este código para mejorarlo:\n$input\n\nCódigo refactorizado:",
							action = "display",
						})
					end,
					desc = "Refactorizar código",
					mode = "v",
				},
				{
					"<leader>od",
					function()
						require("ollama").prompt({
							prompt = "Genera documentación para este código:\n$input\n\nDocumentación:",
							action = "display",
						})
					end,
					desc = "Generar documentación",
					mode = "v",
				},
			},
			opts = {
				model = "deepseek-coder:6.7b",
				system_prompt =
				"Eres DeepSeek-Coder, un asistente de programación especializado. Proporciona respuestas concisas y código limpio.",
				stream = true,
				context = true,
				context_lines = 15,
				prompts = {
					Complete_Line = {
						prompt = "Completa esta línea de código. Solo devuelve la continuación:\n$input",
						action = "replace",
						extract = "^(.*)$",
					},
					Explain_Code = {
						prompt = "Explica este código brevemente:\n$input",
						action = "display",
					},
					Fix_Bug = {
						prompt = "Encuentra y corrige los errores en este código:\n$input\n\nCódigo corregido:",
						action = "display",
					},
				},
			},
		},
		{
			"tzachar/cmp-ai",
			dependencies = { "hrsh7th/nvim-cmp" },
			config = function()
				require("cmp_ai.config"):setup({
					max_lines = 1000,
					provider = "OpenAI",
					model = "deepseek-coder",
					api_key = os.getenv("DEEPSEEK_API_KEY"),
					api_base = "https://api.deepseek.com/v1",
					temperature = 0.1,
					top_p = 0.1,
				})
			end
		},
		{
			"L3MON4D3/LuaSnip",
			dependencies = { "rafamadriz/friendly-snippets" },
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
				local ls = require("luasnip")
				local s = ls.snippet
				local t = ls.text_node
				local i = ls.insert_node

				ls.add_snippets("gitcommit", {
					s("feat", { t("feat: "), i(1, "description") }),
					s("fix", { t("fix: "), i(1, "description") }),
					s("docs", { t("docs: "), i(1, "description") }),
					s("style", { t("style: "), i(1, "description") }),
					s("refactor", { t("refactor: "), i(1, "description") }),
					s("perf", { t("perf: "), i(1, "description") }),
					s("test", { t("test: "), i(1, "description") }),
					s("chore", { t("chore: "), i(1, "description") }),
					s("ci", { t("ci: "), i(1, "description") }),
					s("build", { t("build: "), i(1, "description") }),
					s("feat-scope", { t("feat("), i(1, "scope"), t("): "), i(2, "description") }),
					s("fix-scope", { t("fix("), i(1, "scope"), t("): "), i(2, "description") }),
				})
			end,
		}
	},

	defaults = {
		lazy = false,
		version = false,
	},
	checker = {
		enabled = true,
		notify = false,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				--"matchit",
				--"matchparen",
				--"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
