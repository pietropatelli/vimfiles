set nocompatible                                " Better vim, less Vi-compatible
let mapleader = "\\"                            " Use \ as <leader>
let maplocalleader = "\\"                       " Use \ as <localleader>
filetype plugin indent on                       " Filetype-specific settings etc
let $VIMHOME=expand(split(&runtimepath,',')[0]) " First dir in runtime path
set directory=$VIMHOME/tmp/.vim-swapfiles       " Directory for swap files
set undodir=$VIMHOME/tmp/.undodir               " Persistend undo dir
set undofile                                    " Persistend undo
set cm=blowfish2                                " medium to strong encryption
"...................... General system-dependent options .......................
if has('win32')                                 " WINDOWS (32 or 64 bit)
    set clipboard=unnamed                       " Always use system clipboard
    set pythonthreedll=python37.dll             " Specify which python dll
    let g:UltiSnipsUsePythonVersion = 3         " Tell ultisnips to use py3
    let g:tex_conceal = "adbg"
else                                            " UNIX OR WSL
    set clipboard=unnamedplus                   " Always use system clipboard
    if system('uname -a')=~#'Microsoft'         " WSL
        let g:tex_conceal = "adbg"
    else                                        " UNIX ONLY
        let g:tex_conceal="abdgm"
    endif
endif
"................................. Easier dev - TMP ..................................
map <silent> <leader>nn <Plug>SourceVimrc
map <silent> <leader>nc <Plug>SourceCurrent
map <silent> <leader>ns <Plug>SourceTheme
"................................... minpac ....................................
" NOTE: I have added minpac as a git submodule
packadd minpac
call minpac#init()
" Essential plugins:
call minpac#add('scrooloose/nerdtree')              " File tree browser
call minpac#add('tomtom/tcomment_vim')              " Toggle comments
call minpac#add('farmergreg/vim-lastplace')         " Reopen files at last pos
call minpac#add('itchyny/lightline.vim')            " Statusline
call minpac#add('tpope/vim-fugitive')               " Git integration
call minpac#add('godlygeek/tabular')                " Align text
call minpac#add('wellle/targets.vim')               " Working w pairs of ([{,'
call minpac#add('milkypostman/vim-togglelist')      " Toggle quickfix
call minpac#add('SirVer/ultisnips')                 " Snippet engine
" terminal plugins
call minpac#add('gu-fan/simpleterm.vim')            " Easy interaction w :term
call minpac#add('skywind3000/asyncrun.vim')         " Run cmds asynchronously
call minpac#add('christoomey/vim-tmux-navigator')   " Navigate vim and tmux
" colorscheme plugins:
call minpac#add('PietroPate/vim-nightsea')          " My colorscheme
call minpac#add('flazz/vim-colorschemes')           " Colorscheme collection
call minpac#add('rafi/awesome-vim-colorschemes')    " Colorscheme collection
" language-specific plugins:
call minpac#add('tmhedberg/SimpylFold')             " Smart python code folding
call minpac#add('JuliaEditorSupport/julia-vim')     " Julia support
call minpac#add('lervag/vimtex')                    " Simple latex integration
call minpac#add('PietroPate/vim-tex-conceal')       " Improved conceal for tex
call minpac#add('zizhongyan/stata-vim-syntax')      " Stata grammar
call minpac#add('PProvost/vim-ps1')                 " Powershell
call minpac#add('vim-pandoc/vim-pandoc-syntax')     " Pandoc Markdown
" session management
call minpac#add('xolox/vim-session')                " Session management
call minpac#add('xolox/vim-misc')                   " Req by vim-session
" plugins loaded later:
call minpac#add('gerw/vim-HiLinkTrace',  {'type': 'opt'}) " Shows syntax tree
call minpac#add('airblade/vim-gitgutter',{'type': 'opt'}) " Gitdiff in sign col
call minpac#add('w0rp/ale',              {'type': 'opt'}) " Async linting
packloadall                                         " Load the plugins now
" Commands for easier package management
command! PUpdate  packadd minpac | source $MYVIMRC | call minpac#update()
command! PClean   packadd minpac | source $MYVIMRC | call minpac#clean()
".......................... Lightline, airline etc.  ...........................
set laststatus=2
set noshowmode
" Lightline settings - Note: This must be before the colorscheme
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified'],
      \             [ 'linting', 'gitgutter' ] ],
      \ 'right': [ [ 'lineinfo' ],
      \            [ 'percent' ],
      \            [ 'fileformat', 'fileencoding', 'filetype'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'linting': 'ALErunning',
      \   'gitgutter': 'GitGutterRunning',
      \ },
      \ }
"............................ Basic configuration: .............................
syntax on                                  " Enables syntax highlighting
set background=dark                        " Use dark background
set t_Co=256                               " Enables 256 color terminal
try                                        " If missing colorscheme use default
colorscheme nightsea
" GOOD ONES: meta5, iceberg, cobalt2, gruvbox, minimalist, badwolf, zenburn,
" apprentice, hemisu, vividchalk, distinguished, calmar256-dark, dracula, void,
" lucius, greenvision
catch
endtry
set swapfile                               " use swapfiles
set encoding=utf-8                         " unicode compatibility
scriptencoding utf-8                       " unicode compatibility
set fileencoding=utf-8                     " unicode compatibility
set fileencodings=ucs-bom,utf8,prc         " unicode compatibility
set noerrorbells vb t_vb=                  " Disable beeping
set number                                 " Adds line numbers
set cursorline                             " Highlight cursor line
set hidden                                 " Allows hidden edited bufferd
set wrap                                   " wrap dynamically to window width
set scrolloff=3                            " keep 3 lines above-below cursor
set sidescrolloff=5                        " keep 5 columns left-right of cursor
set splitbelow                             " default horizontal split
set splitright                             " default vertical split
set diffopt+=vertical                      " Fugitive open diff vertically
set autoread                               " listen for external changes to file
set history=500                            " store long :cmdline history
set showcmd                                " show partial command
set lazyredraw                             " No redraw while executing macros
set ttyfast                                " Faster redrawing
set noshowmatch                            " don't jump to matching parentheris
" let loaded_matchparen = 1                " don't load marchparen
runtime macros/matchit.vim                 " Enables matchit plugin
" Search settings:
set ignorecase                             " Ignore case if search is lowercase
set smartcase                              " Use case if search has uppercase
set nohlsearch                             " Do not highlight search results
" Indentation settings:
" set foldmethod=indent                    " Code folding using indent
set foldlevelstart=1                       " Open level x-level folds on start
set tabstop=4                              " Tab length
set expandtab                              " Use spaces instead of <Tab>
set shiftwidth=4                           " Indentation length
" set breakindent                            " Wrapped line continue indented
" set formatoptions-=r formatoptions-=o      " No autocontinue comment
" set formatoptions-=t                       " Do not automatically break lines
".................................. Mappings ...................................
" Easier commands
nnoremap ò :
inoremap ò <esc>:
" Easier search
nnoremap <space> /
nnoremap <leader><space> ?
" Easier resizing
nnoremap <leader>- :resize -10<CR>
nnoremap <leader>+ :resize +10<CR>
" Easier append to word
map E ea
" Easy make first letter uppercase
map <leader>m bvU
" Making Y work like C or D:
map Y y$
" Making H work like J but putting the current line after the next one
map H ddpkJ
" Make Enter insert new line below
nmap <CR> o<Esc>
" Allow j and k to move in autocomplete list
inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))
" Clear search and toggle search highlight
nnoremap <silent> <leader>ch :let @/ = ""<CR>:call clearmatches()<CR>
nnoremap <silent> <leader>noh :set hlsearch!<CR>
" Easier switching buffers
noremap <F2> :ls<CR>:b
imap <F2> <Esc>:ls<CR>:b
cmap <F2> <Esc><CR>
" Habit breaking:
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
imap <Up> <NOP>
imap <Down> <NOP>
imap <Left> <NOP>
imap <Right> <NOP>
" Make 81st column stand out
nnoremap <silent> <leader>8 :call matchadd('ColorColumn', '\%81v', 100)<CR>
"Easier quoting/unquoting:
nnoremap <Leader>q" ciw""<Esc>P
nnoremap <Leader>q' ciw''<Esc>P
nnoremap <Leader>q` ciw``<Esc>P
nnoremap <Leader>Q" ciW""<Esc>P
nnoremap <Leader>Q' ciW''<Esc>P
nnoremap <Leader>Q` ciW``<Esc>P
" Easy switching between splits (NOTE: in windows <c-h> affects backspace)
tmap <c-j> <c-w>j
tmap <c-k> <c-w>k
tmap <c-l> <c-w>l
" Easy reload file:
nnoremap <leader>e :edit!<CR>
" Shortcut for folding
nnoremap <leader>f zR
" Pasting from system clipboard in insert mode with Ctrl-v
imap <C-v> <C-r>*
" Paste multiple lines correctly from system clipboard in normal mode
nnoremap <Leader>p :set paste <CR>o<esc>"*p :set nopaste<CR>
nnoremap <Leader>P :set paste <CR>O<esc>"*p :set nopaste<CR>
" Delete to the 'black hole' register
nnoremap <Leader>d "_d
nnoremap <Leader>D "_D
" Paste last yank in vim:
nnoremap \yp "0p
vnoremap \yp "0p
nnoremap \yP "0P
" Toggle note
nmap <silent><F12> <Plug>ToggleNote
" Section title
nmap <silent><leader>tt <Plug>SectionTitle
" Get file path
nmap <silent> <leader>o <Plug>GetFilePath
" Check sintax highlighting group under cursor using HiLinkTrace
map <F10> :packadd vim-HiLinkTrace<CR>:HLT<CR>
" Quickfix shortcuts
nmap <script> <silent> <leader>cc :call ToggleQuickfixList()<CR>
nnoremap <silent> <leader>cn :cn<CR>
nnoremap <silent> <leader>cp :cp<CR>
" conceal settings
set conceallevel=2
let g:pandoc#syntax#conceal#use=0
"............................ Better paste in WSL ..............................
if has('unix') && system('uname -a')=~#'Microsoft' "This checks if we are in WSL
    let s:clip = '/mnt/c/Windows/System32/clip.exe'
    if executable(s:clip)
        augroup WSLYank
            autocmd!
            autocmd TextYankPost * call system('echo '.shellescape
                        \(join(v:event.regcontents, "\<CR>")).' | '.s:clip)
        augroup END
    end
    nnoremap <silent> <leader>p :r !powershell.exe -Command Get-Clipboard<CR>
    nnoremap <silent> <leader>P k:r !powershell.exe -Command Get-Clipboard<CR>
endif
"............................ vim-session settings .............................
let g:session_menu = 0
let g:session_autoload = 'no'
let g:session_autosave = 'no'
let g:session_autosave_periodic = 0
let g:session_verbose_messages = 0
set sessionoptions-=help    " Don't restore help windows
set sessionoptions-=buffers " Don't save hidden and unloaded buffers in sessions
" Session mappings:
noremap <F3> :OpenSession<CR>
imap <F3> <Esc>:w<CR>:OpenSession<CR>
noremap AA :OpenSession default<CR>
noremap SS :ccl<CR>:lcl<CR>:wa<CR>:SaveSession<CR>
noremap SC :CloseSession!<CR>
noremap ZZ :ccl<CR>:lcl<CR>:SaveSession<CR>:wqa<CR>
"............................. Ultisnips settings ..............................
let g:UltiSnipsSnippetDirectories=[expand($VIMHOME.'/mysnippets')] "Snippets dir
" Trigger config. Avoid <tab> if using https://github.com/Valloric/YouCompleteMe
let g:UltiSnipsExpandTrigger='<c-tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'
let g:UltiSnipsEditSplit='horizontal' " :UltiSnipsEdit split window direction.
command! USE :UltiSnipsEdit
function! ExpandPossibleShorterSnippet()
  if len(UltiSnips#SnippetsInCurrentScope()) == 1 "only one candidate...
    let curr_key = keys(UltiSnips#SnippetsInCurrentScope())[0]
    if curr_key !~ ')?' "Avoid regular expression snippets
        exe "normal  i \<esc>".'vb"_c'.curr_key." \<esc>"
    endif
        return 1
  endif
  return 0
endfunction
inoremap <silent> <tab> <C-R>=(ExpandPossibleShorterSnippet() == 0? '<tab>': UltiSnips#ExpandSnippet())<CR>
"................................ ALE Settings .................................
let g:ale_enabled=0        " Disabled at startup
let g:ale_set_highlights=0 " Do not highlight problems in text
nmap <silent> <leader>g :packadd ale<CR>:packadd vim-gitgutter<CR>
            \:GitGutterDisable<CR>:ALEToggle<CR>
nmap <silent> [g <Plug>(ale_previous_wrap)
nmap <silent> ]g <Plug>(ale_next_wrap)
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['autopep8'],
\   'matlab': ['mlint'],
\   'vim': ['vint'],
\   'r': ['lintr'],
\   'tex': ['chktex'],
\   'julia': ['languageserver'],
\}
function! ALErunning()
    if g:ale_enabled==0
        return ''
    else
        return 'linting'
    end
endfunction
"............................ simpleterm settings ..............................
if exists('g:simpleterm')
    let g:simpleterm.row=8
    nmap <silent> <leader><tab> :normal <leader>slj<CR>
    nmap <leader>sk :Skill<CR>
endif
"............................. NERDTree settings: ..............................
" Open split and then toggle nerdtree (more precse than the other way around)
nnoremap <silent> <leader>i :new \| :NERDTreeToggle<CR>
nnoremap <silent> <leader>v :vnew \| :NERDTreeToggle<CR>
" Shortcuts to toggle NERDTree:
map <silent> <F1> :call NERDTreeToggleInCurDir()<CR>
imap <silent> <F1> <Esc>:call NERDTreeToggleInCurDir()<CR>
cmap <F1> <Esc><Esc>:call NERDTreeToggleInCurDir()<CR>
let NERDTreeShowHidden=1    " Show hidden files (eg. dotfiles)
let NERDTreeShowBookmarks=1 " Shows bookmarks
let NERDTreeQuitOnOpen = 1  " Closes NERDTree when opening a file
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore=['\c^ntuser\..*']
let g:NERDTreeUpdateOnWrite=1
" Toggle NERDTree in current file directory (or /home if no file is open)
function! NERDTreeToggleInCurDir()
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeClose"
  elseif &filetype!="help" " Try to open at current file dir, otherwise at pwd
    exe ":silent! NERDTree %:p:h"
      if !(exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
        exe ":NERDTreeCWD"
      endif
  else
    exe ":NERDTreeCWD"
  endif
endfunction
"............................ Git gutter settings: .............................
let g:gitgutter_enabled = 0
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk
nmap <silent> <leader>hh :packadd ale<CR>:packadd vim-gitgutter<CR>
            \:ALEDisable<CR>:GitGutterToggle<CR>
function! GitGutterRunning()
    if g:gitgutter_enabled==0
        return ''
    else
        return 'gitgutter'
    end
endfunction
".............................. Vimtex settings: ...............................
let g:tex_flavor='latex'
if has('win32')
    let g:vimtex_view_general_viewer = 'sumatrapdf'
else
    let g:vimtex_view_general_viewer = 'zathura'
endif
let g:vimtex_view_general_options
    \ = ' -reuse-instance -forward-search @tex @line @pdf'
    \ . ' -inverse-search "gvim --servername ' . v:servername
    \ . ' --remote-send \"^<C-\^>^<C-n^>'
    \ . ':drop \%f^<CR^>:\%l^<CR^>:normal\! zzzv^<CR^>'
    \ . ':execute ''drop '' . fnameescape(''\%f'')^<CR^>'
    \ . ':\%l^<CR^>:normal\! zzzv^<CR^>'
    \ . ':call remote_foreground('''.v:servername.''')^<CR^>^<CR^>\""'
let g:vimtex_view_general_options_latexmk='-reuse-instance'
let g:vimtex_latexmk_background=1
let g:vimtex_quickfix_mode=0
let g:tex_fast='cmMprsSvV' " Fix colorscheme loading issue in tex files
"............................. AsyncRun Settings ...............................
let g:asyncrun_last=1      " Scroll only if cursor is on last line
let g:asyncrun_exit='echo "Done"'
let $PYTHONUNBUFFERED=1    " See python realtime output
nnoremap <leader>as :AsyncStop<CR>
" Run
nmap <silent> <leader>aa <Plug>MyAsyncRun:echo("Running...")<CR>
nmap <silent> <leader>ll <Plug>MyAsyncRunBis:echo("Running...")<CR>
nmap <silent> <leader>aq <Plug>MyAsyncRun:copen<CR>:wincmd p<CR>
