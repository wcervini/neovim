 -- vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
 --          pattern = {'*.c', '*.h', "*.lua"},
 --          callback = function(ev)
 --            print(string.format('event fired: %s', vim.inspect(ev)))
 --          end
 --        })
 --
vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function()
    vim.notify("Archivo guardado: " .. vim.fn.expand("%:t"), vim.log.levels.INFO)
  end,
}) 
