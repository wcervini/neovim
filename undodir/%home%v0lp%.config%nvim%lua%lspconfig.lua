Vim�UnDo� ��B�����șo�$'�A�d��L���xR�U              "      #       #   #   #    b��    _�                             ����                                                                                                                                                                                                                                                                                                                                                             b��    �                 !local use=require("vim-plug").use   'require("vim,-plug").startup(function()     use 'neovim-nvim-lspcoinfig'   end)5��                                   n               5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             b�$     �               require("mason").setup()5��                         �                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             b�%     �               #require("lspconfig").dartls.setup{}5��                         �                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             b�&     �               *require('lspconfig').ccsmodules_ls.setup{}5��                         �                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             b�&     �               !require('lspconfig').html.setup {5��                                              5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             b�)     �                require'lspconfig').html.setup {5��                                              5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             b�)     �               )require'lspconfig').ccsmodules_ls.setup{}5��                         �                     5�_�      	                     ����                                                                                                                                                                                                                                                                                                                                                             b�*     �               "require"lspconfig").dartls.setup{}5��                         �                     5�_�      
           	          ����                                                                                                                                                                                                                                                                                                                                                             b�+     �               require"mason").setup()5��                         �                     5�_�   	              
           ����                                                                                                                                                                                                                                                                                                                                                             b�6     �               (-- require("nvim-lsp-installer").setup({5��                          B                      5�_�   
                         ����                                                                                                                                                                                                                                                                                                                                                             b�6     �               '- require("nvim-lsp-installer").setup({5��                          B                      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             b�7     �               & require("nvim-lsp-installer").setup({5��                          B                      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             b�7     �               �--    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)5��                          h                      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             b�7     �               �-    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)5��                          h                      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             b�8     �               �    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)5��                          h                      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             b�8     �               --    ui = {5��                          �                      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             b�8     �               -    ui = {5��                          �                      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             b�9     �               
    ui = {5��                          �                      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             b�=     �                	   ui = {5��               	          �       	              5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             b�>     �                  -- ui = {5��                          �                      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             b�?     �                 -- ui = {5��                          �                      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             b�?     �               
 -- ui = {5��                          �                      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             b�?     �               	-- ui = {5��                          �                      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             b�?     �               - ui = {5��                          �                      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             b�A     �                ui = {5��                          �                      5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             b�D     �      	         --        icons = {5��                          �                      5�_�                    	        ����                                                                                                                                                                                                                                                                                                                                                             b�E     �      
         '--            server_installed = "✓",5��                          	                     5�_�                    
        ����                                                                                                                                                                                                                                                                                                                                                             b�F     �   	            %--            server_pending = "➜",5��    	                      /                     5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             b�G     �   
            (--            server_uninstalled = "✗"5��    
                      S                     5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             b�G     �               --        }5��                          z                     5�_�                             ����                                                                                                                                                                                                                                                                                                                                                             b�H     �               --    }5��                          �                     5�_�      !                       ����                                                                                                                                                                                                                                                                                                                                                             b�I    �               --})5��                          �                     5�_�       "           !      "    ����                                                                                                                                                                                                                                                                                                                                                             b��    �               �   automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)5��       "       b           �       b               5�_�   !   #           "          ����                                                                                                                                                                                                                                                                                                                                                             b��    �                 require'lspconfig'.html.setup {     capabilities = capabilities,   }       %require("nvim-lsp-installer").setup({   "   automatic_installation = true,    	   ui = {           icons = {   %            server_installed = "✓",   #            server_pending = "➜",   &            server_uninstalled = "✗"   	        }       }   })5��                                   +              5�_�   "               #           ����                                                                                                                                                                                                                                                                                                                                                             b��    �                 require"mason".setup()   !require"lspconfig".dartls.setup{}   (require'lspconfig'.ccsmodules_ls.setup{}   require'lspconfig'.html.setup {     capabilities = capabilities,   }5��                                  �              5��