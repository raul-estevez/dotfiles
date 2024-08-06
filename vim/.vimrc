syntax on 
filetype plugin indent on
set hidden

set nu
set ruler " Show cursor current position
set laststatus=2 " Para el plugin de la barra de abajo
set noshowmode " Lo mismo
set ignorecase " Ignore cases when searching
set smartcase " 
set hlsearch " Highlight search results
set showmatch " Show matching brackets when text indicator is over them
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set expandtab " En vez de tabs, espacios
set smarttab
set shiftwidth=4
set tabstop=4
set ai " Auto indent
set si " Smart indent
"set wrap " Wrap lines cuando se salen de la pantalla
set backspace=indent,eol,start
set relativenumber

set textwidth=130
set colorcolumn=130

let maplocalleader = ","
let mapleader = ","

" Use a line cursor within insert mode and a block cursor everywhere else.
"
" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Installation of Plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
    Plug 'preservim/nerdtree'
    Plug 'itchyny/lightline.vim'
    " Themes
    Plug 'morhetz/gruvbox'
    Plug 'sainnhe/everforest'   
    " gcc to comment line, gc to coment block
    Plug 'tpope/vim-commentary' " gcc para comentar línea, gc para comentar en bloque
    " LaTeX
    Plug 'lervag/vimtex'
    Plug 'SirVer/ultisnips'
    " Python
    Plug 'Vimjas/vim-python-pep8-indent'
    Plug 'vim-python/python-syntax'
call plug#end()

" Vimtex
let g:tex_flavor='luatex'
let g:vimtex_view_method='zathura'
"
"" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="jk"
let g:UltiSnipsJumpBackwardTrigger="kj"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']

" Spell check
setlocal spell
set spelllang=es,en_gb
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Fix spell check highlight. Always before :coloscheme
augroup my_colours
  autocmd!
  autocmd ColorScheme everforest hi SpellBad cterm=underline
augroup END

" Important!!
if has('termguicolors')
  set termguicolors
endif

set background=dark
" Available values: 'hard', 'medium'(default), 'soft'
let g:everforest_background = 'hard'
" For better performance
let g:everforest_better_performance = 1
colorscheme everforest

let g:lightline = {
      \ 'colorscheme': 'one',
      \ }

" NERDTree
" Open shortcut
nnoremap <C-f> :NERDTreeFind<CR>
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
" Auto open
autocmd VimEnter * NERDTree
autocmd BufEnter * NERDTreeMirror

autocmd VimEnter * wincmd w


"Moverse entre splits
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
inoremap <M-h> <C-w>h
inoremap <M-j> <C-w>j
inoremap <M-k> <C-w>k
inoremap <M-l> <C-w>l

" Move lines up/down
nnoremap <C-k> :m-2<CR>
nnoremap <C-j> :m+<CR>
nnoremap <C-h> <<
nnoremap <C-l> >>
nnoremap <C-k> :m-2<CR>
vnoremap <C-h> <gv
vnoremap <C-l> >gv
vnoremap <C-k> :m-2<CR>
vnoremap <C-j> :m+<CR>

" New Line
nnoremap <C-o> o<Esc>

" Delete without cutting 
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

" Beginning/End of line
nnoremap H ^
nnoremap L $
nnoremap <Leader>d ""d
noremap <Leader>d ""d
