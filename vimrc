let mapleader = "\\"                            " Use \ as <leader>
let maplocalleader = "\\"                       " Use \ as <localleader>
filetype plugin indent on                       " Filetype-specific settings etc
let $VIMHOME=expand(split(&runtimepath,',')[0]) " First dir in runtime path
set directory=$VIMHOME/tmp/.vim-swapfiles       " Directory for swap files
set undodir=$VIMHOME/tmp/.undodir               " Persistend undo dir
set undofile                                    " Persistend undo
let skip_defaults_vim=1                         " Do not load defaults
set viminfo=""                                  " Do not create viminfo
set cryptmethod=blowfish2                       " medium to strong encryption
"...................... General system-dependent options .......................
if has('win32')                                 " WINDOWS (32 or 64 bit)
    set clipboard=unnamed                       " Always use system clipboard
    set pythonthreedll=python37.dll             " Specify which python dll
    let g:UltiSnipsUsePythonVersion = 3         " Tell ultisnips to use py3
    let g:tex_conceal = 'adbg'
else                                            " UNIX OR WSL
    set clipboard=unnamedplus                   " Always use system clipboard
    if system('uname -a')=~#'Microsoft'         " WSL
        let g:tex_conceal = 'adbg'
    else                                        " UNIX ONLY
        let g:tex_conceal='abdgm'
    endif
endif
".............................. Easier dev - TMP ...............................
map <silent> <leader>nn <Plug>SourceVimrc
map <silent> <leader>nc <Plug>SourceCurrent
map <silent> <leader>ns <Plug>SourceTheme
"................................... minpac ....................................
packadd minpac
if !exists('*minpac#init')
call system('git clone "https://github.com/k-takata/minpac/" '.
            \$VIMHOME.'/pack/minpac/opt/minpac')
packadd minpac
endif
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})
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
call minpac#add('vimwiki/vimwiki')                  " Personal wiki etc
call minpac#add('mattn/calendar-vim')               " Calendar
call minpac#add('w0rp/ale')                         " Async linting
call minpac#add('prabirshrestha/async.vim')         " Normalize async jobs
call minpac#add('prabirshrestha/vim-lsp')           " language server protocol
call minpac#add('tomtom/ttodo_vim')                 " todo.txt integration
call minpac#add('tomtom/tlib_vim')                  " dependency for ttodo_vim
" terminal plugins
call minpac#add('gu-fan/simpleterm.vim')            " Easy interaction w :term
call minpac#add('skywind3000/asyncrun.vim')         " Run cmds asynchronously
call minpac#add('christoomey/vim-tmux-navigator')   " Navigate vim and tmux
" colorscheme plugins:
call minpac#add('PietroPate/vim-nightsea')      
call minpac#add('flazz/vim-colorschemes')           " Colorscheme collection
call minpac#add('rafi/awesome-vim-colorschemes')    " Colorscheme collection
call minpac#add('gerw/vim-HiLinkTrace')             " Shows syntax tree
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
" packages loaded later:
call minpac#add('airblade/vim-gitgutter',{'type':'opt'})   " Gitdiff in sign col
call minpac#add('mhinz/vim-grepper',{'type':'opt'})        " grep asyncronously
" Commands for easier package management
command! PUpdate  packadd minpac | source $MYVIMRC | call minpac#update()
command! PClean   packadd minpac | source $MYVIMRC | call minpac#clean()
"............................. Lightline settings ..............................
set laststatus=2
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'nightsea',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified'],
      \             [ 'runningplugins' ] ],
      \ 'right': [ [ 'lineinfo' ],
      \            [ 'percent' ],
      \            [ 'fileformat', 'fileencoding', 'filetype'] ]
      \ },
      \ 'component_function': {
      \   'mode':           'LightlineMode',
      \   'paste':          'LightlinePaste',
      \   'gitbranch':      'LightlineGitbranch',
      \   'readonly':       'LightlineReadonly',
      \   'filename':       'LightlineFilename',
      \   'modified':       'LightlineModified',
      \   'runningplugins': 'LightlineRunningplugins',
      \   'lineinfo':       'LightlineLineinfo',
      \   'percent':        'LightlinePercent',
      \   'fileformat':     'LightlineFileformat',
      \   'fileencoding':   'LightlineFileencoding',
      \   'filetype':       'LightlineFiletype',
      \ },
	  \ 'separator': { 'left': '', 'right': '' },
	  \ 'subseparator': { 'left': '', 'right': '' },
      \ }
"............................ Basic configuration: .............................
syntax on                                  " Enables syntax highlighting
set background=dark                        " Use dark background
if !empty($ConEmuBuild)                    " ConEmu compatibility
    set term=pcansi
    set ttyscroll=10
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
    let &t_kb="\xcex"
    let &t_ku="\xceH"
    let &t_kd="\xceP"
    let &t_kl="\xceK"
    let &t_kr="\xceM"
endif
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
set scrolloff=5                            " keep 5 lines above-below cursor
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
runtime macros/matchit.vim                 " Enables matchit plugin
" Search settings:
set ignorecase                             " Ignore case if search is lowercase
set smartcase                              " Use case if search has uppercase
set nohlsearch                             " Do not highlight search results
" Conceal settings:
set conceallevel=0
let g:pandoc#syntax#conceal#use=0
" Indentation settings:
" set foldmethod=indent                    " Code folding using indent
set foldlevelstart=1                       " Open level x-level folds on start
set tabstop=4                              " Tab length
set expandtab                              " Use spaces instead of <Tab>
set shiftwidth=4                           " Indentation length
set backspace=indent,eol,start             " Backspace over everything in insert
".................................. Mappings ...................................
nnoremap <c-s> :w<CR>
inoremap <c-s> <esc>:w<CR>a
" Easier commands
nnoremap ò :
" Easier search
nnoremap <space> /
nnoremap <leader><space> ?
" Easier resizing
nnoremap <leader>- :resize -10<CR>
nnoremap <leader>+ :resize +10<CR>
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
vmap <F2> <Esc>:ls<CR>:b
cmap <F2> <Esc><CR>
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
nnoremap <Leader>p :set paste <CR>o<esc>"*p <esc>:set nopaste<CR>
nnoremap <Leader>P :set paste <CR>O<esc>"*p <esc>:set nopaste<CR>
" Delete to the 'black hole' register
nnoremap <Leader>d "_d
nnoremap <Leader>D "_D
" Paste last yank in vim:
nnoremap \yp "0p
vnoremap \yp "0p
nnoremap \yP "0P
" Check sintax highlighting group under cursor using HiLinkTrace
map <F10> :HLT<CR>
" Quickfix shortcuts
nmap <script> <silent> <leader>cc :call ToggleQuickfixList()<CR>
nnoremap <silent> <leader>cn :cn<CR>
nnoremap <silent> <leader>cp :cp<CR>
set switchbuf+=usetab,newtab
" Mappings to my plugins
nnoremap <silent><F12> :ToggleNote<CR>
nnoremap <silent>' :ToggleTodo<CR>
nmap <silent><leader>tt <Plug>SectionTitle
nmap <silent> <leader>o <Plug>GetFilePath
" Command to record values:
command! RecVal :call RecVal(glob(g:vimwiki_list[0].path."/diary/my_data.csv"))
" FZF mapping:
nnoremap <silent><F4> :FZF<CR>
let g:fzf_layout = { 'down': '~30%' }
"............................... LSP for Julia .................................
let g:lsp_auto_enable = 0
let g:lsp_diagnostics_echo_cursor = 1
if executable('julia')
    augroup VIM_LSP
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'julia',
    \ 'cmd': {server_info->['julia','--startup-file=no --history-file=no','-e',
    \ 'using LanguageServer; server = LanguageServer.LanguageServerInstance(
    \ stdin, stdout, false); server.runlinter = true; run(server);']},
    \ 'whitelist': ['julia'],
    \ })
    augroup END
endif
"............................ Better paste in WSL ..............................
if has('unix') && system('uname -a')=~#'Microsoft' " Checks if we are in WSL
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
"............................. ttodo_vim settings ..............................
let g:ttodo#dirs=[$HOME.'/Dropbox/.todo']
let g:ttodo#mapleader="<LocalLeader>"
let g:ttodo#sort='done,-next,-overdue,pri,due,lists,tags,idx'
let g:ttodo#new_task={'pri': 'C'}
let g:ttodo_nmap='<Leader>1'
let g:ttodo_localmap='<Leader>2'
".............................. vimwiki settings ...............................
nmap <Leader>wn <Plug>VimwikiNextLink
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{'path':'~/Dropbox/.vimwiki', 'syntax':'markdown', 'ext':'.md'}]
nnoremap <leader>rr :VimwikiTabMakeDiaryNote<CR>
nnoremap <silent>^ :ToggleDiary<CR>
nnoremap <silent>ì :ToggleWiki<CR>
"............................ vim-session settings .............................
let g:session_menu = 0
let g:session_autoload = 'no'
let g:session_autosave = 'no'
let g:session_autosave_periodic = 0
let g:session_verbose_messages = 0
set sessionoptions-=help    " Don't restore help windows
set sessionoptions-=buffers " Don't save hidden and unloaded buffers in sessions
noremap <F3> :OpenSession<CR>
imap <F3> <Esc>:w<CR>:OpenSession<CR>
vmap <F3> <Esc>:w<CR>:OpenSession<CR>
cmap <F3> <Esc><CR>:OpenSession<CR>
noremap AA :OpenSession default<CR>
noremap SS :ccl<CR>:lcl<CR>:wa<CR>:SaveSession<CR>
noremap SC :CloseSession!<CR>
noremap ZZ :ccl<CR>:lcl<CR>:SaveSession<CR>:wqa<CR>
"............................. Ultisnips settings ..............................
if exists('did_plugin_ultisnips')
    let g:UltiSnipsSnippetDirectories=[expand($VIMHOME.'/mysnippets')] "Snippets dir
    let g:UltiSnipsExpandTrigger='<c-tab>'
    let g:UltiSnipsJumpForwardTrigger='<tab>'
    let g:UltiSnipsJumpBackwardTrigger='<c-z>'
    let g:UltiSnipsEditSplit='horizontal' " :UltiSnipsEdit split window direction.
    command! USE :UltiSnipsEdit
    imap <silent> <tab> <Plug>ExpandPossibleSnippetOrTab
endif
"................................ ALE Settings .................................
let g:ale_enabled=0        " Disabled at startup
let g:ale_set_highlights=0 " Do not highlight problems in text
nmap <silent> <leader>gg :packadd vim-gitgutter<CR>:GitGutterDisable<CR>
            \:ALEToggle<CR>
nmap <silent> [g <Plug>(ale_previous_wrap)
nmap <silent> ]g <Plug>(ale_next_wrap)
"............................ simpleterm settings ..............................
if exists('g:simpleterm')
    let g:simpleterm.row=8
    nmap <silent> <leader><tab> :normal <leader>slj<CR>
    nmap <leader>sk :Skill<CR>
endif
"............................. NERDTree settings: ..............................
map <silent> <F1> <Plug>NERDTreeToggleInFileDir
imap <silent> <F1> <Esc><Plug>NERDTreeToggleInFileDir
vmap <silent> <F1> <Esc><Plug>NERDTreeToggleInFileDir
cmap <F1> <Esc><Esc><Plug>NERDTreeToggleInFileDir
" Open split and then toggle nerdtree (more precse than the other way around)
nnoremap <silent> <leader>i :new \| :NERDTreeToggle<CR>
nnoremap <silent> <leader>v :vnew \| :NERDTreeToggle<CR>
let NERDTreeShowHidden=1    " Show hidden files (eg. dotfiles)
let NERDTreeShowBookmarks=1 " Shows bookmarks
let NERDTreeQuitOnOpen = 1  " Closes NERDTree when opening a file
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore=['\c^ntuser\..*']
let g:NERDTreeUpdateOnWrite=1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeStatusline='NERDTree'
"............................ Git gutter settings: .............................
let g:gitgutter_enabled = 0
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap <leader>hs <Plug>(GitGutterStageHunk)
nmap <leader>hu <Plug>(GitGutterUndoHunk)
nmap <silent> <leader>hh :packadd vim-gitgutter<CR>:ALEDisable<CR>
            \:GitGutterToggle<CR>
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
let g:vimtex_compiler_latexmk = { 
        \ 'continuous' : 0,
        \ 'executable' : 'latexmk',
        \ 'options' : [ 
        \   '-xelatex',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}
let g:vimtex_view_general_options_latexmk='-reuse-instance'
let g:vimtex_latexmk_background=1
let g:vimtex_quickfix_mode=0
let g:tex_fast='cmMprsSvV' " Fix colorscheme loading issue in tex files
let g:vimtex_include_search_enabled=0 " Disable tag indexing for performance
"............................. AsyncRun Settings ...............................
let g:asyncrun_last=1      " Scroll only if cursor is on last line
let g:asyncrun_exit='echo "Done"'
let $PYTHONUNBUFFERED=1    " See python realtime output
nnoremap <leader>as :AsyncStop<CR>
nmap <silent> <leader>aa <Plug>MyAsyncRun:echo("Running...")<CR>
nmap <silent> <leader>aq <Plug>MyAsyncRun:copen<CR>:wincmd p<CR>
