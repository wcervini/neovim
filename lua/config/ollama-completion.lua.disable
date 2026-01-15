local M = {}

-- Configuración para autocompletado automático con Ollama
function M.setup_auto_completion()
  local ollama = require("ollama")
  
  -- Grupo de autocomandos
  local ollama_group = vim.api.nvim_create_augroup("OllamaCompletion", { clear = true })
  
  -- Autocompletado después de ciertos patrones
  vim.api.nvim_create_autocmd("InsertCharPre", {
    group = ollama_group,
    callback = function(args)
      local char = vim.v.char
      local triggers = {
        ["."] = true,  -- Métodos/propiedades
        [":"] = true,  -- Atributos
        ["("] = true,  -- Parámetros
        ["["] = true,  -- Arrays
        ["{"] = true,  -- Objetos/bloques
        ["="] = true,  -- Asignaciones
      }
      
      if triggers[char] then
        vim.defer_fn(function()
          M.trigger_completion()
        end, 300) -- 300ms delay
      end
    end,
  })
  
  -- Autocompletado después de palabras clave
  vim.api.nvim_create_autocmd("InsertLeave", {
    group = ollama_group,
    callback = function()
      local line = vim.fn.getline(".")
      local keywords = {
        "function%s+%w*$",
        "if%s+.*$",
        "for%s+.*$",
        "while%s+.*$",
        "return%s+.*$",
        "local%s+%w+%s*=%s*.*$",
      }
      
      for _, pattern in ipairs(keywords) do
        if line:match(pattern) then
          vim.defer_fn(function()
            M.trigger_completion()
          end, 500)
          break
        end
      end
    end,
  })
end

-- Función para disparar autocompletado
function M.trigger_completion()
  -- Obtener contexto
  local bufnr = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local start_line = math.max(1, row - 3)
  local end_line = math.min(vim.api.nvim_buf_line_count(bufnr), row + 1)
  
  local context_lines = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)
  local context = table.concat(context_lines, "\n")
  local current_line = vim.fn.getline(".")
  local prefix = current_line:sub(1, col)
  
  -- Usar Codeium para autocompletado (si está disponible)
  local codeium = package.loaded["codeium"]
  if codeium then
    codeium.get_completions()
    return
  end
  
  -- Fallback a Ollama directo
  require("ollama").prompt({
    prompt = "Contexto:\n" .. context .. "\n\nCompleta esta línea concisamente:\n" .. prefix,
    stream = true,
    action = function(response)
      local suggestion = response:gsub("^%s*(.-)%s*$", "%1")
      suggestion = suggestion:gsub("^```%w*\n", ""):gsub("\n```$", "")
      
      if suggestion and #suggestion > 0 then
        -- Insertar sugerencia
        vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, {suggestion})
      end
    end,
  })
end

-- Atajos de teclado
function M.setup_keymaps()
  -- Completar línea actual
  vim.keymap.set("i", "<C-l>", function()
    local line = vim.fn.getline(".")
    require("ollama").prompt({
      prompt = "Completa esta línea de código:\n" .. line,
      action = function(response)
        local completion = response:match("^[^\n]+")
        if completion then
          vim.api.nvim_put({ completion }, "c", false, true)
        end
      end,
    })
  end, { desc = "Completar línea con Ollama" })
  
  -- Generar código con selección
  vim.keymap.set("v", "<leader>og", function()
    local selected = require("ollama.util").get_visual_selection()
    require("ollama").prompt({
      prompt = "Genera código para: " .. selected,
      action = "display",
    })
  end, { desc = "Generar código desde selección" })
  
  -- Explicar código
  vim.keymap.set("v", "<leader>oe", function()
    local selected = require("ollama.util").get_visual_selection()
    require("ollama").prompt({
      prompt = "Explica este código:\n" .. selected,
      action = "display",
    })
  end, { desc = "Explicar código seleccionado" })
end

-- Inicializar
M.setup_auto_completion()
M.setup_keymaps()

return M
