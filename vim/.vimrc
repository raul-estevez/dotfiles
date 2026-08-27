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

" Folding
set foldmethod=marker
autocmd FileType tex set foldmarker=<<<,>>>

" Search down into subfolders. Provides tab completion for all file related task
set path+=**
" Display matching files when tab complete
set wildmenu 

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
    " highligt #ifed
    Plug 'vim-scripts/ifdef-highlighting'

    " Auto-update ctags and highlight typedefs and all that
    Plug 'ludovicchabant/vim-gutentags'

    Plug 'https://github.com/bkad/CamelCaseMotion' 
    Plug 'ledger/vim-ledger'

    Plug 'zenbones-theme/zenbones.nvim'

call plug#end()

" Detect .v as Verilog
autocmd BufNewFile,BufRead *.v,*.vs set syntax=verilog
autocmd BufNewFile,BufRead *.cir set syntax=spice

" Gutentags
let g:gutentags_modules = ['ctags']
let g:gutentags_background_update = 1


" Vimtex
" let g:tex_flavor='luatex'
" let g:tex_flavor='xelatex'
" let g:vimtex_view_method='zathura'
let g:vimtex_view_method='general'
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_quickfix_mode=2
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
" augroup my_colours
"   autocmd!
"   autocmd ColorScheme everforest hi SpellBad cterm=underline
" augroup END

" Important!!
if has('termguicolors')
  set termguicolors
endif

set background=dark
colorscheme zenwritten 
" Available values: 'hard', 'medium'(default), 'soft'
" let g:everforest_background = 'hard'
" " For better performance
" let g:everforest_better_performance = 1
" colorscheme everforest

let g:lightline = {
      \ 'colorscheme': 'zenwritten',
      \ }

" NERDTree
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror | endif


" Start remote server for Vimtex forward/inverse search
if empty(v:servername) && exists('*remote_startserver')
  call remote_startserver('VIM')
endif

function! ZathuraHook() dict abort
  if self.xwin_id <= 0 | return | endif

  silent call system('xdotool windowactivate ' . self.xwin_id . ' --sync')
  silent call system('xdotool windowraise ' . self.xwin_id)
endfunction

" let g:vimtex_view_zathura_hook_view = 'ZathuraHook'

nmap <localleader>v <plug>(vimtex-view)

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


" Navigate buffers
map gn :bnext<cr>
map gp :bprevious<cr>
map gd :bdelete<cr> 

" Navigate tabs
map tn :tabnext<cr>
map tp :tabprev<cr>
map td :tabclose<cr>
map t1 :tabm 0<cr>
map t2 :tabm 1<cr>
map t3 :tabm 2<cr>
map t4 :tabm 3<cr>
map t5 :tabm 4<cr>

map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge
