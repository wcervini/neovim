set nu
syntax enable
set showcmd
set showmatch
set relativenumber
set tabstop=2       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=2    " Indents will have a width of 4.
set softtabstop=2   " Sets the number of columns for a TAB.
set expandtab       " Expand TABs to spaces.
set termguicolors
set smartindent
set numberwidth=1
set signcolumn=yes
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set nohlsearch
set ignorecase
set smartcase
set nowrap
set splitbelow
set splitright
set hidden
set scrolloff=999
set noshowmode
set updatetime=250 
set encoding=UTF-8
set mouse=a

call plug#begin("~/.config/vim/plugged")
Plug 'sainnhe/gruvbox-material'
" Instalacion del servidor de lenguajes LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
" Snippet Javascript
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'mattn/emmet-vim'
"Comentarios para vim
Plug 'tpope/vim-commentary'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
Plug 'kien/ctrlp.vim'
" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'onsails/lspkind-nvim'
Plug 'voronkovich/ultisnips-vue'
call plug#end()

" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Configuracion GRUVBOX
let g:gruvbox_material_background='medium'
let g:colorscheme="gruvbox-material"
set background=dark
" LSP Configuracion

" Emmet configuracion
"
let g:user_emet_mode='n'
let g:user_emmet_leader_key=","
let g:user_emmet_settings={
\'javascript':{
\'extends':'jsx'
\}
\}
"configuracion de tpope comentary
vmap <space>/ :Commentary<cr>
nmap <space>/ :Commentary<cr>

"configuracion de airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = '|'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_theme="papercolor"
let g:airline_left_sep=""
let g:airline_left_sep_alt=" "
let g:airline_right_sep="<"
let g:airline_right_alt_sep=" "
" Nerdtree config

let g:NERDTreeQuitOnOpen=1 "Close NERDTree windows before select a file 
nmap <silent> <C-n> :NERDTreeToggle<cr>

nmap <silent> <leader><Enter> :noh<cr>
let mapleader="."
nmap <leader>ve :e $MYVIMRC<cr>
nmap <silent> <leader>re :so %<cr>

nmap <C-w> :w<cr>


imap <leader>jj <Esc>

"Prettier config
nmap <leader>p :Prettier<cr>

"Buffers Settings
nmap <leader>bl :buffers<cr>
nmap <leader>bd :bd<cr>
nmap <tab> :bnext<cr>
