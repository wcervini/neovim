--[[ return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  config = function()
    local tsserver_path = require(config.funciones).get_pnpm_tsdk
    require("typescript-tools").setup(){
      tsserver_path = tsserver_path .. "/node_modules/typescript/lib",
    }
  -- opts = {
  --  settings = {
  --    tsserver_path = tsserver_path .. "/node_modules/typescript/lib",
      -- O usa la ruta de mason si lo tienes instalado:
      -- tsserver_path = vim.fn.stdpath("data") .. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
  --  },
}
 ]]

 return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = function()
    -- 1. Call your function to get the path
    -- Note: Ensure "config.funciones" is in quotes if it's a file path
    local tsdk = require("config.funciones").get_pnpm_tsdk()

    -- 2. Return the settings table
    return {
      settings = {
        -- 'tsserver_path' should point to the actual tsserver.js file 
        -- or the directory containing it.
        tsserver_path = tsdk,
        
        -- If you want to use the Mason version instead, uncomment this:
        -- tsserver_path = vim.fn.stdpath("data") .. "/mason/packages/typescript-language-server/node_modules/typescript/lib/tsserver.js",
      },
    }
  end,
}