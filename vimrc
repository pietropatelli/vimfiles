" NOTE: the .vimrc file in the home directory simply points here.
""""""""""""""""" MINPAC:
packadd minpac
call minpac#init()
" minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
call minpac#add('k-takata/minpac', {'type': 'opt'})

" Add other plugins here.
call minpac#add('flazz/vim-colorschemes')
call minpac#add('rafi/awesome-vim-colorschemes')
call minpac#add('scrooloose/nerdtree')
call minpac#add('tomtom/tcomment_vim')
call minpac#add('farmergreg/vim-lastplace')
call minpac#add('JuliaEditorSupport/julia-vim')
call minpac#add('lervag/vimtex')
call minpac#add('tmhedberg/SimpylFold')
call minpac#add('gu-fan/simpleterm.vim')
call minpac#add('itchyny/lightline.vim')
""""""""""""""
" Interesting packages:
" call minpac#add('altercation/vim-colors-solarized')
" call minpac#add('Xuyuanp/nerdtree-git-plugin')
" call minpac#add('tpope/vim-fugitive')
" call minpac#add('jpitblado/vim-stata')
" call minpac#add('fholgado/minibufexpl.vim')
" call minpac#add('ryanoasis/vim-devicons')
" call minpac#add('wellle/targets.vim')
" call minpac#add('vim-airline/vim-airline')
" call minpac#add('powerline/powerline')
" call minpac#add('')
" Load the plugins right now. (optional)
packloadall
" Commands for easier package management
command! PacUpdate call minpac#update()
command! PacClean  call minpac#clean()
"""""""""""""""""""""""""""""""""
"""Basic configuration:
syntax on " Enables syntax highlighting
set background=dark
set t_Co=256 "Enables 256 color terminal; necessary for colorscheme to function properly
colorscheme hemisu  "Good ones: meta5, iceberg, cobalt2, gruvbox, minimalist, badwolf, zenburn, apprentice, hemisu, vividchalk, distinguished, calmar256-dark, dracula, void
set number "Adds line numbers
set hidden
"
set noeb vb t_vb= "Disable beeping
set guifont=consolas:h10 "Font settings for gvim.
set showmatch "bracket matching
" set textwidth=80   "hard wrap lines
set autoread
set hlsearch
"Apply automatically to markdown:
au BufRead,BufNewFile *.md setlocal textwidth=80
set wrap
set autoindent
set tabstop=4
"Set default split direction:
set splitbelow
set splitright
" Ignore case when searching unless query contains an uppercase letter:
set ignorecase
set smartcase
" Number of lines to keep above-below-to the side of the cursor:
set scrolloff=3
set sidescrolloff=5
" Disable comment continuation on <Enter>
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
runtime macros/matchit.vim "Enables matchit plugin (included in base vim)
"UNICODE stuff:
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc
" Enable Airline 
set laststatus=2
set noshowmode
" Highlight cursor line:
set cursorline
"""""""""""""""""""""""""
"""""""""""""""""""""""""
"Key mappings:
"Pasting system clipboard with Alt-v:
nmap <silent> <a-v> "*p
imap <silent> <a-v> <C-r>*
cmap <a-v> <C-r>*
" Habit breaking:
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
imap <Up> <NOP>
imap <Down> <NOP>
imap <Left> <NOP>
imap <Right> <NOP>
" easier access to command mode:
nnoremap <F1> :
imap <F1> <Esc>-:
vmap <F1> <Esc>-:
" easier switching buffers
map <F2> :ls<CR>:b
"Easier quoting/unquoting:
:nnoremap <Leader>q" ciw""<Esc>P
:nnoremap <Leader>q' ciw''<Esc>P
:nnoremap <Leader>q` ciw``<Esc>P
"""""""""""""""""""""""""""
" Alt-t to start terminal at 10 size
" nnoremap <silent> <a-t> :term ++rows=8 <CR>
" Terminal settings using simpleterm:
let g:simpleterm.row=8
nnor <silent> <a-t> :Stoggle<CR>
nnor <silent> <a-e> :Sline<CR>
vnor <silent> <a-e> :Sline<CR>
"store lots of :cmdline history
set history=1000
"
"Show current mode at bottom:
" set showmode " NOTE: Disabled because of other status bar
"
"code folding settings:
set foldmethod=indent
"
"faster scrolling when pressing Ctrl:
nmap <c-j> 5j
nmap <c-k> 5k
nmap <c-h> 5h
nmap <c-l> 5l
"
" Enable folding with the spacebar
nnoremap <space> za
"NERDTree settings:
map <silent> <C-1> :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1 "Shows bookmarks
"open if vim is started without a file selcted:
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeQuitOnOpen = 1 "Closes NERDTree when opening a file
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore=['\c^ntuser\..*']
"
"Vimtex settings:
let g:tex_flavor='latex'
let g:vimtex_view_general_viewer = 'sumatrapdf' 
" let g:vimtex_view_method = 'SumatraPDF'
let g:vimtex_view_general_options='-reuse-instance -forward-search @tex @line @pdf'
let g:vimtex_view_general_options_latexmk='-reuse-instance'
let g:vimtex_latexmk_background       = 1
" let g:vimtex_latexmk_build_dir = 'livepreview'
let g:vimtex_quickfix_mode=0


