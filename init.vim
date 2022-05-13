call plug#begin()

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'jremmen/vim-ripgrep', { 'on': 'Rg' }
Plug 'tpope/vim-fugitive',  { 'on': 'Git' }
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'mattn/emmet-vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Olical/conjure'

call plug#end()

" Turn on line numbers
set number
set relativenumber
set clipboard=unnamed,unnamedplus

" Force 256 colors
set t_Co=256

set nocompatible " turn off vi compatibility
set backspace=indent,eol,start
filetype off

" Fix hanging O
set ttimeoutlen=10

filetype plugin indent on " Filetype auto-detection
syntax on " Syntax highlighting
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
autocmd FileType json syntax match Comment +\/\/.\+$+

let g:user_emmet_install_global = 0
autocmd FileType html,css,typescriptreact EmmetInstall

" Fuzzy finding
set path+=**
set wildignore+=**/node_modules/**
set wildmenu

" Tab goodness
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab   " use spaces instead of tabs.
set smarttab    " let's tab key insert 'tab stops', and bksp deletes tabs.
set shiftround  " tab / shifting moves to closest tabstop.
set autoindent  " Match indents on new lines.
set smartindent " Intelligently dedent / indent new lines based on rules.

" Make search more sane
set ignorecase " case insensitive search
set smartcase  " If there are uppercase letters, become case-sensitive.
set incsearch  " live incremental searching
set showmatch  " live match highlighting
set nohlsearch " highlight matches

" Let splitting make more sense
set splitbelow
set splitright

" File browsing
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_liststyle=3

" Leader
nnoremap <SPACE> <Nop>
let mapleader = " "

" Easier line wrap navigation
nnoremap j gj
nnoremap k gk

" Have files autoreload
set autoread

" Move swp file location
:set directory=$HOME/.vim/swapfiles/


let g:coc_global_extensions = [
      \ 'coc-tsserver'
      \ ]
let g:coc_disable_startup_warning = 1

let mapleader = " "
let maplocalleader = ","

nnoremap <C-h>      <C-w>h
nnoremap <C-j>      <C-w>j
nnoremap <C-k>      <C-w>k
nnoremap <C-l>      <C-w>l
nnoremap <leader>wh  <C-w>h
nnoremap <leader>wj  <C-w>j
nnoremap <leader>wk  <C-w>k
nnoremap <leader>wl  <C-w>l
nnoremap gh         h
nnoremap gj         j
nnoremap gk         k
nnoremap gl         l
nnoremap <leader>rr :source $MYVIMRC<CR>
nnoremap <leader>re :e $MYVIMRC<CR>
nnoremap <leader>fs :w<CR>
nnoremap <leader>ff :e <Space>
nnoremap <leader>ft :setl filetype?<CR>
nnoremap <leader>wv :vsplit<CR>
nnoremap <leader>ws :split <CR>
nnoremap <leader>w= :wincmd =<CR>
nnoremap <leader>wmh :wincmd _<CR>
nnoremap <leader>wmw :wincmd \|<CR>
nnoremap <leader>q  :q<CR>
nnoremap <leader>wd :close<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>Q  :q!<CR>
nnoremap <leader>bb :Buffers<CR>
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
nnoremap <leader>pf :Files<CR>

nnoremap <leader><space> :GFiles<CR>

" LSP Configuration
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nnoremap g] :call CocAction('diagnosticNext')<CR>
nnoremap g[ :call CocAction('diagnosticPrevious')<CR>

nmap <leader>cr <Plug>(coc-rename)
nmap gd <Plug>(coc-definition)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <leader>ch :call <SID>show_documentation()<CR>

nnoremap cD :CocDiagnostics<CR>
function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

nmap <leader>cf <Plug>(coc-format-selected)
