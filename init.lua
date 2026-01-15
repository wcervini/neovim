vim.g.mapleader = " "
require("config.options")
require("config.keymaps")
require("config.autocmd")
require("config.lazy")
require("config.telescope_tree")
require("config.lspconfig")
require("plugins.autocomplete")  -- ✅ Añade esta
require("config.ollama-completion")
-- Comando para cambiar modelo de Ollama
vim.api.nvim_create_user_command("OllamaModel", function(opts)
  require("ollama").setup({ model = opts.args })
  print("Modelo cambiado a: " .. opts.args)
end, { nargs = 1, complete = function()
  return { "deepseek-coder:6.7b", "codellama:7b", "mistral", "llama2" }
end })

-- Desactivo de momento ollama ya que no lo uso
-- Ver modelo actual
-- vim.api.nvim_create_user_command("OllamaCurrentModel", function()
--   local ollama = require("ollama")
--   print("Modelo actual: " .. (ollama.opts.model or "No configurado"))
-- end, {})
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
})
