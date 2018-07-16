" NOTE: the .vimrc file in the home directory simply points here.
" """""""""""""""""" VIM-PLUG:
if has('win32') "Note: works for both 32 and 64 bit systems.
    let $MYPLUGDIRECTORY = "~/vimfiles/plugged"
else
    let $MYPLUGDIRECTORY = "~/.vim/plugged"
endif
call plug#begin($MYPLUGDIRECTORY)
Plug 'flazz/vim-colorschemes'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tomtom/tcomment_vim'
Plug 'farmergreg/vim-lastplace'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'lervag/vimtex'
Plug 'tmhedberg/SimpylFold'
"Plug 'fholgado/minibufexpl.vim'
call plug#end()
"""""""""""""""""""""""""""""""""
"""Basic configuration:
syntax on " Enables syntax highlighting
set t_Co=256 "Enables 256 color terminal; necessary for colorscheme to function properly
colorscheme vividchalk  "Good ones: meta5, iceberg, cobalt2, gruvbox, minimalist, badwolf, zenburn, apprentice, hemisu, vividchalk, distinguished
set number "Adds line numbers
"
set noeb vb t_vb= "Disable beeping
set guifont=consolas:h10 "Font settings for gvim.
set showmatch "bracket matching
set textwidth=80
set autoread
"Apply automatically to markdown:
au BufRead,BufNewFile *.md setlocal textwidth=80
set wrap
set autoindent
set tabstop=4
"Set default split direction:
set splitbelow
set splitright
" Disable comment continuation on <Enter>
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" runtime macros/matchit.vim "Enables matchit plugin (included in base vim)
"UNICODE stuff:
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc
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
"store lots of :cmdline history
set history=100
"
"Show current mode at bottom:
set showmode
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
"TComment settings:
nmap <silent> <C-c> gcc
"FIXME: "nmap <silent> <Count><C-c> gc<Count>c

"Vimtex settings:
let g:tex_flavor='latex'
let g:vimtex_view_general_viewer = 'sumatrapdf' 
" let g:vimtex_view_method = 'SumatraPDF'
let g:vimtex_view_general_options='-reuse-instance -forward-search @tex @line @pdf'
let g:vimtex_view_general_options_latexmk='-reuse-instance'
let g:vimtex_latexmk_background       = 1
" let g:vimtex_latexmk_build_dir = 'livepreview'
let g:vimtex_quickfix_mode=0

" Terminal settings:
let termwinsize="10*0" "FIXME
" TODO: Shortcut to send single line to terminal and to send the whole file.
