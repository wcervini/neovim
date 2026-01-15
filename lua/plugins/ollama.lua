return {
  "nomnivore/ollama.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim",
  },

  cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },

  keys = {
    -- Autocompletado inline (como Copilot)
    {
      "<Tab>",
      function()
        if vim.fn.pumvisible() == 1 then
          return "<C-n>"
        end
        require("ollama.integrations.completion").complete()
        return ""
      end,
      desc = "Ollama autocomplete",
      mode = "i",
      expr = true,
    },

    -- Completar línea actual
    {
      "<C-Space>",
      ":lua require('ollama').prompt('Complete_Line')<cr>",
      desc = "Complete current line",
      mode = "i",
    },

    -- Generar código desde selección
    {
      "<leader>og",
      ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
      desc = "Generate code from selection",
      mode = "v",
    },

    -- Explicar código seleccionado
    {
      "<leader>oe",
      ":<c-u>lua require('ollama').prompt('Explain_Code')<cr>",
      desc = "Explain selected code",
      mode = "v",
    },

    -- Chat con contexto del archivo
    {
      "<leader>oc",
      ":<c-u>lua require('ollama').prompt('Chat_With_Context')<cr>",
      desc = "Chat with file context",
      mode = "n",
    },
  },

  opts = {
    model = "deepseek-coder:6.7b",

    -- Configuración específica para DeepSeek-Coder
    system_prompt = [[Eres DeepSeek Coder, un asistente de IA especializado en programación.
    - Proporciona solo código sin explicaciones a menos que se solicite específicamente
    - Mantén las respuestas concisas y al punto
    - Sigue las convenciones del lenguaje actual
    - Considera el contexto del archivo actual]],

    -- Prompts personalizados para DeepSeek-Coder
    prompts = {
      Complete_Line = {
        prompt = "Completa la siguiente línea de código. Solo devuelve la continuación, sin explicaciones:\n$input",
        action = "replace",
        extract = "^(.*)$",
      },

      Generate_Code = {
        prompt = "Genera código para: $input\n\nConsidera el contexto:\n$context\n\nSolo devuelve el código:",
        action = "display",
      },

      Explain_Code = {
        prompt = "Explica este código:\n$input\n\nExplicación:",
        action = "display",
      },

      Chat_With_Context = {
        prompt = "Contexto del archivo actual:\n$context\n\nPregunta: $input\n\nRespuesta:",
        action = "display",
      },

      -- Autocompletado inteligente
      AutoComplete = {
        prompt =
        "Dado el siguiente código, sugiere la siguiente línea o completación. Solo devuelve la sugerencia de código:\n$context\n\nÚltima línea: $input\nSugerencia:",
        action = "replace",
        extract = "^(.*)$",
      },
    },

    -- Configuración de streaming
    stream = true,

    -- Timeouts optimizados para DeepSeek-Coder
    request_timeout = 30000,

    -- Contexto del archivo
    context = true,
    context_lines = 10,
  },

  config = function(_, opts)
    require("ollama").setup(opts)

    -- Función de autocompletado automático
    local ollama_group = vim.api.nvim_create_augroup("OllamaAutoComplete", { clear = true })

    -- Autocompletado después de ciertos caracteres
    vim.api.nvim_create_autocmd("InsertCharPre", {
      group = ollama_group,
      callback = function()
        local line = vim.fn.getline(".")
        local col = vim.fn.col(".") - 1

        -- Disparadores para autocompletado automático
        local triggers = {
          ["."] = true,      -- Métodos/propiedades
          [":"] = true,      -- Atributos/heredación
          ["("] = true,      -- Parámetros de función
          ["["] = true,      -- Arrays/índices
          [" "] = function() -- Después de espacio, solo en ciertos contextos
            local prev_text = line:sub(1, col - 1)
            return prev_text:match("function%s+$")
                or prev_text:match("if%s+$")
                or prev_text:match("for%s+$")
                or prev_text:match("while%s+$")
                or prev_text:match("return%s+$")
          end
        }

        local char = vim.v.char
        local trigger = triggers[char]

        if trigger then
          if type(trigger) == "function" then
            if not trigger() then return end
          end

          -- Esperar un poco antes de disparar el autocompletado
          vim.defer_fn(function()
            require("ollama").prompt({
              prompt = opts.prompts.AutoComplete.prompt
                  :gsub("$input", line)
                  :gsub("$context", vim.fn.join(vim.fn.getline(1, vim.fn.line(".")), "\n")),
              action = function(response)
                local suggestion = response:match("^%s*(.-)%s*$")
                if suggestion and #suggestion > 0 and not suggestion:match("^```") then
                  -- Insertar sugerencia
                  vim.api.nvim_put({ suggestion }, "c", true, true)
                end
              end,
            })
          end, 500) -- 500ms de delay
        end
      end,
    })
  end,
}
