local fn = vim.fn
local install_path= fn.stdpath 'data'..'/site/(pack/packer/start/packer.vim'
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP= fn.system({
		"git",
		"clone",
		"depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path})
		print "Instalando Packer...."
		vim.cmd [[packadd packer.vim]]

end

return require('packer').startup(function(use)

use 'wbthomason/packer.nvim'

use 'sainnhe/gruvbox-material'
-- Snippet Javascript
use 'SirVer/ultisnips'
use 'honza/vim-snippets'
-- Comentarios para vim
use 'preservim/nerdtree'
use 'preservim/nerdcommenter'
use 'vim-airline/vim-airline-themes'
use 'vim-airline/vim-airline'
use 'vim-airline/vim-airline-themes'
use 'ryanoasis/vim-devicons'
use 'kien/ctrlp.vim'
-- Autocompletion
use 'hrsh7th/nvim-compe'
-- Treesitter
use {'nvim-treesitter/nvim-treesitter', run= ':TSUpdate' }
use 'neovim/nvim-lspconfig'
use 'williamboman/mason-lspconfig.nvim'
use 'williamboman/mason.nvim'
use 'jose-elias-alvarez/null-ls.nvim'
use 'mhartington/formatter.nvim'
use 'hrsh7th/cmp-nvim-lsp'
use 'hrsh7th/cmp-buffer'
use 'hrsh7th/cmp-path'
use 'hrsh7th/cmp-cmdline'
use 'hrsh7th/nvim-cmp'
use 'SirVer/ultisnips'
use 'quangnguyen30192/cmp-nvim-ultisnips'

end)


-- Enable nvim-treesitter
--require('nvim-treesitter.configs').setup {
--  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
--  highlight = {
--    enable = true, -- False will disable the whole extension
--  },
