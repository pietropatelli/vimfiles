" NOTE: the .vimrc file in the home directory simply points here.
let mapleader = "\\"
let maplocalleader = "\\"
filetype plugin on
""""""""""""""""" MINPAC:
packadd minpac
call minpac#init()
" minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
" NOTE: I have added minpac as a submodule in my vimfiles repository.
" call minpac#add('k-takata/minpac', {'type': 'opt'})

" Add other plugins here.
call minpac#add('lervag/vimtex')
call minpac#add('flazz/vim-colorschemes')
call minpac#add('rafi/awesome-vim-colorschemes')
call minpac#add('scrooloose/nerdtree')
call minpac#add('tomtom/tcomment_vim')
call minpac#add('farmergreg/vim-lastplace')
call minpac#add('JuliaEditorSupport/julia-vim')
call minpac#add('tmhedberg/SimpylFold')
call minpac#add('gu-fan/simpleterm.vim')
call minpac#add('itchyny/lightline.vim')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-dispatch')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('guns/vim-sexp')
call minpac#add('skywind3000/asyncrun.vim')
""""""""""""""
" Interesting packages:
" call minpac#add('Valloric/YouCompleteMe')
" call minpac#add('scrooloose/nerdcommenter')
" call minpac#add('vim-syntastic/syntastic')
" call minpac#add('Xuyuanp/nerdtree-git-plugin')
" call minpac#add('altercation/vim-colors-solarized')
" call minpac#add('jpitblado/vim-stata')
" call minpac#add('bling/vim-bufferline')
" call minpac#add('ryanoasis/vim-devicons')
" call minpac#add('wellle/targets.vim')
" call minpac#add('vim-airline/vim-airline')
" call minpac#add('powerline/powerline')
" call minpac#add('godlygeek/tabular')
" call minpac#add('fadein/vim-FIGlet')
" call minpac#add('vim-pandoc/vim-pandoc') "NOTE: Requires python3 for commands to be useful
" call minpac#add('')
" Load the plugins right now. (optional)
packloadall
" Commands for easier package management
command! PUpdate call minpac#update()
command! PClean  call minpac#clean()
"""""""""""""""""""""""""""""""""
" Compatibility with Lightline, airline etc. 
set laststatus=2
set noshowmode
" Lightline settings
let g:lightline = { 'colorscheme': 'powerline','active': { 'left': [ [ 'mode', 'paste' ], [ 'gitbranch', 'readonly', 'filename', 'modified' ] ] }, 'component_function': { 'gitbranch': 'fugitive#head' }, } " NOTE: This setting must be before the colorscheme
"""""""""""""""""""""""""""	
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
" autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
runtime macros/matchit.vim "Enables matchit plugin (included in base vim)
"UNICODE stuff:
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc
" Highlight cursor line:
set cursorline
"""""""""""""""""""""""""
"""""""""""""""""""""""""
" set clipboard=unnamed " Always use system clipboard
"Key mappings:
"Pasting from system clipboard in command and insert mode with Ctrl-v
cmap <C-v> <C-r>*
imap <C-v> <C-r>*
"""""""""""""""""""""""""
" Making Y work like C or D:
map Y y$
" Habit breaking:
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
imap <Up> <NOP>
imap <Down> <NOP>
imap <Left> <NOP>
imap <Right> <NOP>
" easier switching buffers
noremap <F2> :ls<CR>:b
imap <F2> <Esc>:ls<CR>:b
cmap <F2> <Esc><CR>
" Easy toggle paste mode:
set pastetoggle=Ά "This is <F12> on my laptop
" Alternative shortcut to paste correctly from system clipboard
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>
" Easy search for current word in current directory
map ΅ :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
"Easier quoting/unquoting:
:nnoremap <Leader>q" ciw""<Esc>P
:nnoremap <Leader>q' ciw''<Esc>P
:nnoremap <Leader>q` ciw``<Esc>P
"store lots of :cmdline history
set history=1000
"
"code folding settings:
set foldmethod=indent
"
"faster scrolling when pressing Ctrl:
" nmap <c-j> 5j
" nmap <c-k> 5k
" nmap <c-h> 5h
" nmap <c-l> 5l
"
" Enable folding with the spacebar
nnoremap <space> zA
" Allow j and k to move in autocomplete list
inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))
"""""""""""""""""""""""""""
" Alt-t to start terminal at 10 size
nnoremap <silent> <a-t> :term ++rows=8 <CR>
" Terminal settings using simpleterm:
" let g:simpleterm.row=8
" nmap <silent> <a-t> :Stoggle<CR>
" nmap <silent> <a-e> :Sline<CR>
" vmap <silent> <a-e> :Sline<CR>
"NERDTree settings:
""""""""""""""""""""""""""""
map <silent> <F1> :NERDTreeToggle<CR>
imap <silent> <F1> <Esc>:NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeShowBookmarks=1 "Shows bookmarks
"open if vim is started without a file selcted:
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeQuitOnOpen = 1 "Closes NERDTree when opening a file
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore=['\c^ntuser\..*']
let g:NERDTreeUpdateOnWrite=1
" NERDtree git plugin settings: " FIXME: NERDTree-git-plugin doesn't work
" let g:NERDTreeUseSimpleIndicator = 1
" let g:NERDTreeShowGitStatus=1
"
"""""""""""""""""""""""""""
" Git gutter settings:
let g:gitgutter_enabled = 0
" nmap <a-g> :GitGutterToggle<CR>
nmap <a-g> :GitGutterEnable<CR>
nmap <a-G> :GitGutterDisable<CR>
"""""""""""""""""""""""""""
"Vimtex settings:
let g:tex_flavor='latex'
let g:vimtex_view_general_viewer = 'sumatrapdf' 
" let g:vimtex_view_general_options='-reuse-instance -forward-search @tex @line @pdf'
let g:vimtex_view_general_options
    \ = ' -reuse-instance -forward-search @tex @line @pdf'
    \ . ' -inverse-search "gvim --servername ' . v:servername
    \ . ' --remote-send \"^<C-\^>^<C-n^>'
    \ . ':drop \%f^<CR^>:\%l^<CR^>:normal\! zzzv^<CR^>'
    \ . ':execute ''drop '' . fnameescape(''\%f'')^<CR^>'
    \ . ':\%l^<CR^>:normal\! zzzv^<CR^>'
    \ . ':call remote_foreground('''.v:servername.''')^<CR^>^<CR^>\""'
let g:vimtex_view_general_options_latexmk='-reuse-instance'
let g:vimtex_latexmk_background       = 1
let g:vimtex_quickfix_mode=0
"""""""""""""""""""""""
" AsyncRun Settings
let g:asyncrun_open = 8 "opens quickfix by default
let g:asyncrun_last = 1
nnoremap <leader>as :AsyncStop<CR>
" See python realtime output
let $PYTHONUNBUFFERED=1




