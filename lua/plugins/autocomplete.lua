-- lua/plugins/autocomplete.lua (REEMPLAZA tu blink.lua)
return {
	-- Sistema principal de autocompletado
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
			"zbirenbaum/copilot-cmp", -- Copilot
			"tzachar/cmp-ai", -- DeepSeek
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
					{ name = "copilot", priority = 1000 }, -- Copilot primero
					{ name = "codeium", priority = 950 }, -- Ollama Codeium
					{ name = "nvim_lsp", priority = 900 },
					{ name = "cmp_ai", priority = 800 }, -- DeepSeek
					{ name = "luasnip", priority = 700 },
					{ name = "buffer", priority = 600 },
					{ name = "path", priority = 500 },
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
				sources = { { name = "buffer" } },
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
			})
		end,
	},

	-- Copilot backend
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
		end,
	},

	-- Integración Copilot con nvim-cmp
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "zbirenbaum/copilot.lua", "hrsh7th/nvim-cmp" },
		config = function()
			require("copilot_cmp").setup({
				method = "getCompletionsCycling",
			})
		end,
	},

	-- Codeium con Ollama (para autocompletado tipo-Copilot)
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
		end,
	},

	-- Ollama.nvim para funcionalidades avanzadas
	{
		"nomnivore/ollama.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
		},
		cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },
		keys = {
			-- Chat con contexto
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
			-- Refactorizar código seleccionado
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
			-- Generar documentación
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
			system_prompt = "Eres DeepSeek-Coder, un asistente de programación especializado. Proporciona respuestas concisas y código limpio.",
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

	-- DeepSeek
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
		end,
	},

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			local ls = require("luasnip")
			local s = ls.snippet
			local t = ls.text_node
			local i = ls.insert_node
			-- Carga snippets de terceros (incluye muchos de Django/Flask por defecto)
			require("luasnip.loaders.from_vscode").lazy_load()
			-- SNIPPETS PARA PYTHON (Django y Flask)
			ls.add_snippets("python", {
				-- Django Model
				s("djmodel", {
					t({ "class " }),
					i(1, "MyModel"),
					t({ "(models.Model):", "    " }),
					i(2, "name"),
					t({ " = models.CharField(max_length=255)", "    " }),
					t({
						"created_at = models.DateTimeField(auto_now_add=True)",
						"",
						"    def __str__(self):",
						"        return self.",
					}),
					i(3, "name"),
				}),
				-- Flask Route
				s("flroute", {
					t({ "@app.route('" }),
					i(1, "/"),
					t({ "', methods=['GET'])", "def " }),
					i(2, "index"),
					t({ "():", "    return " }),
					i(3, "render_template('index.html')"),
				}),
			})

			-- SNIPPETS PARA TEMPLATES (Django/Jinja2)
			local django_snippets = {
				s(
					"block",
					{ t("{% block "), i(1, "content"), t({ " %}", "    " }), i(0), t({ "", "{% endblock %}" }) }
				),
				s("if", { t("{% if "), i(1), t({ " %}", "    " }), i(0), t({ "", "{% endif %}" }) }),
				s(
					"for",
					{ t("{% for "), i(1), t(" in "), i(2), t({ " %}", "    " }), i(0), t({ "", "{% endfor %}" }) }
				),
				s("var", { t("{{ "), i(1), t(" }}") }),
				s("url", { t("{% url '"), i(1), t("' %} ") }),
			}

			-- Aplicar los mismos snippets a ambos tipos de archivo
			ls.add_snippets("djangohtml", django_snippets)
			ls.add_snippets("htmldjango", django_snippets)
			--
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
	},
}
