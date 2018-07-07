" NOTE: the .vimrc file in the home directory consists of a single line: 'source ~/vimfiles/vimrc
" """""""""""""""""" VIM-PLUG:
if has('win32') "Note: works for bot 32 and 64 bit systems.
    let $MYPLUGDIRECTORY = "~/vimfiles/plugged"
else
    let $MYPLUGDIRECTORY = "~/.vim/plugged"
endif
call plug#begin($MYPLUGDIRECTORY)
Plug 'flazz/vim-colorschemes'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree'
"Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'terryma/vim-multiple-cursors'
"""" FIXME (for some reason Vim-Plug does not install it):""" Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'tomtom/tcomment_vim'
Plug 'farmergreg/vim-lastplace'
Plug 'JuliaEditorSupport/julia-vim'
call plug#end()
"""""""""""""""""""""""""""""""""
"""Basic configuration:
syntax on " Enables syntax highlighting
set t_Co=256 "Enables 256 color terminal; necessary for colorscheme to function properly
colorscheme iceberg "default is ron, good ones include meta5, iceberg and cobalt2
set number "Adds line numbers
"
set noeb vb t_vb= "Disable beeping
set guifont=consolas:h10 "Font settings for gvim.
set showmatch "bracket matching
set wrap
set autoindent
" runtime macros/matchit.vim "Enables matchit plugin (included in base vim)
"UNICODE stuff:
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc
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
"
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
nmap <c-j> 4j
nmap <c-k> 4k
nmap <c-h> 4h
nmap <c-l> 4l
"
"NERDTree settings:
map <silent> <C-1> :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1 "Shows bookmarks
"open if vim is started without a file selcted:
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeQuitOnOpen = 1 "Closes NERDTree when opening a file
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
"
"Vim-Multiple-Cursor settings:
let g:multi_cursor_use_default_mapping=0
"
" Default mapping (TODO: change them)
" let g:multi_cursor_start_word_key      = '<C-n>'
" let g:multi_cursor_select_all_word_key = '<A-n>'
" let g:multi_cursor_start_key           = 'g<C-n>'
" let g:multi_cursor_select_all_key      = 'g<A-n>'
" let g:multi_cursor_next_key            = '<C-n>'
" let g:multi_cursor_prev_key            = '<C-p>'
" let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'
"
"TComment settings:
nmap <silent> <C-c> gcc
"FIXME: "nmap <silent> <Count><C-c> gc<Count>c
