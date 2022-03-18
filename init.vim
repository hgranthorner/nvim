" Turn on line numbers
set number
set relativenumber

set nocompatible " turn off vi compatibility
set backspace=indent,eol,start
filetype on

" Fix hanging O
set ttimeoutlen=10

filetype plugin indent on " Filetype auto-detection
syntax on " Syntax highlighting

" Fuzzy finding
set path+=**
set wildignore+=**/node_modules/**
set wildmenu

" Tab goodness
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab " use spaces instead of tabs.
set smarttab " let's tab key insert 'tab stops', and bksp deletes tabs.
set shiftround " tab / shifting moves to closest tabstop.
set autoindent " Match indents on new lines.
set smartindent " Intelligently dedent / indent new lines based on rules.

" Make search more sane
set ignorecase " case insensitive search
set smartcase " If there are uppercase letters, become case-sensitive.
set incsearch " live incremental searching
set showmatch " live match highlighting
set nohlsearch " highlight matches

" Let splitting make more sense
set splitbelow
set splitright

call plug#begin()

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-fugitive', { 'on': 'Git' }
Plug 'LnL7/vim-nix'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'Olical/conjure', { 'for': 'clojure' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'kovisoft/paredit', { 'for': ['clojure', 'scheme'] }
Plug 'jremmen/vim-ripgrep', { 'on': 'Rg' }

call plug#end()

lua require ('config')

set termguicolors
set background=dark " or light if you want light mode
colorscheme tokyonight

let mapleader = " "
let maplocalleader = ","

nnoremap <C-h>      <C-w>h
nnoremap <C-j>      <C-w>j
nnoremap <C-k>      <C-w>k
nnoremap <C-l>      <C-w>l
nnoremap <leader>h  <C-w>h
nnoremap <leader>j  <C-w>j
nnoremap <leader>k  <C-w>k
nnoremap <leader>l  <C-w>l
nnoremap gh         h
nnoremap gj         j
nnoremap gk         k
nnoremap gl         l
nnoremap <leader>rr :source $MYVIMRC<CR>
nnoremap <leader>re :e $MYVIMRC<CR>
nnoremap <localleader>re :e ~/.config/nvim/ftplugin<CR>
nnoremap <leader>fs :w<CR>
nnoremap <leader>ff :e <Space>
nnoremap <leader>ft :setl filetype?<CR>
nnoremap <leader>wv :vsplit<CR>
nnoremap <leader>wh :split <CR>
nnoremap <leader>wk :close<CR>
nnoremap <leader>w= :wincmd =<CR>
nnoremap <leader>wmh :wincmd _<CR>
nnoremap <leader>wmw :wincmd \|<CR>
nnoremap <leader>q  :q<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>Q  :q!<CR>
nnoremap <leader>bb :buffers<CR>:b<Space>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>Pi :PlugInstall<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFocus<CR>
nnoremap <leader>gc :Git<Space>
nnoremap <leader>gp :Git pull<CR>
nnoremap <leader>gP :Git push<CR>
nnoremap <leader>gg :Git<CR>
nnoremap <leader>sr :Rg<space>
nnoremap <leader>sp :find<Space>
