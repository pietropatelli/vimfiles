" NOTE: the .vimrc file in the home directory simply points here.
let mapleader = "\\"                            " Use \ as <leader>
let maplocalleader = "\\"                       " Use \ as <localleader>
filetype plugin on                              " Allow plugins for filetypes
let $VIMHOME=expand(split(&runtimepath,',')[0]) " First dir in runtime path
set directory=$VIMHOME/tmp/.vim-swapfiles       " Directory for swap files
set undodir=$VIMHOME/tmp/.undodir               " Persistend undo dir
set undofile                                    " Persistend undo
"...................... General system-dependent options .......................
if has('win32')                                 " WINDOWS (32 or 64 bit)
    set clipboard=unnamed                       " Always use system clipboard
    set pythonthreedll=python37.dll             " Specify which python dll
    let g:UltiSnipsUsePythonVersion = 3         " Tell ultisnips to use py3
    set guifont=consolas:h10                    " Font settings for gvim.
    let g:tex_conceal = "adbg"
    map <silent> <leader>ww :w<CR>:so $MYVIMRC<CR>
    map <silent> <leader>nn :w<CR>:call system
                \('powershell -command "COPY ~/github/vim-nightsea/colors/nightsea.vim ~/vimfiles/colors/nightsea_dev.vim"')<CR>
                \:colorscheme nightsea_dev<CR>
    else                                        " UNIX OR WSL
    set clipboard=unnamedplus                   " Always use system clipboard
    if system('uname -a')=~#'Microsoft'         " WSL
        let g:tex_conceal = "adbg"
        map <silent> <leader>ww :w<CR>:call system
                    \('dos2unix -n $WINHOME"/vimfiles/vimrc" ~/.vim/vimrc')<CR>
                    \:so $MYVIMRC<CR>
        map <silent> <leader>nn :w<CR>:call system
                    \('dos2unix -n $WINHOME"/github/vim-nightsea/colors/nightsea.vim" ~/.vim/colors/nightsea_dev.vim')<CR>
                    \:colorscheme nightsea_dev<CR>
    else                                        " UNIX ONLY
        map <silent> <leader>ww :w<CR>:so $MYVIMRC<CR>
        let g:tex_conceal="abdgm"
    endif
endif
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
" terminal plugins
if v:version >=801
    call minpac#add('gu-fan/simpleterm.vim')        " Easy interction w :term
endif
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
" plugins loaded later:
call minpac#add('gerw/vim-HiLinkTrace',  {'type': 'opt'}) " Shows syntax tree
call minpac#add('xolox/vim-session',     {'type': 'opt'}) " Session management
call minpac#add('xolox/vim-misc',        {'type': 'opt'}) " Req by vim-session
call minpac#add('SirVer/ultisnips',      {'type': 'opt'}) " Snippet engine
call minpac#add('airblade/vim-gitgutter',{'type': 'opt'}) " Gitdiff in sign col
call minpac#add('w0rp/ale',              {'type': 'opt'}) " Async linting
""""" Interesting packages:
" call minpac#add('honza/vim-snippets')             " Snippets
" call minpac#add('christoomey/vim-tmux-runner')    " Send commands to tmux
" call minpac#add('Valloric/YouCompleteMe')         " Needs the engine
" call minpac#add('ryanoasis/vim-devicons')         " Requires appropriate font
" call minpac#add('guns/vim-sexp')                  " Not working for me
" call minpac#add('')
" Load the plugins right now:
packloadall
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
set autoread                               " listen for external changes to file
set history=500                            " store long :cmdline history
set showcmd                                " show partial command
set lazyredraw                             " No redraw while executing macros
set ttyfast                                " Faster redrawing
set noshowmatch                            " don't jump to matching parentheris
" let loaded_matchparen = 1                  " don't load marchparen
" Search settings:
set ignorecase                             " Ignore case if search is lowercase
set smartcase                              " Use case if search has uppercase
set nohlsearch                             " Do not highlight search results
" Indentation settings:
filetype indent on                         " Filetype indenting
set breakindent                            " Wrapped line continue indented
" set foldmethod=indent                    " Code folding using indent
set foldlevelstart=1                       " Open level x-level folds on start
set tabstop=4                              " Tab length
set expandtab                              " Use spaces instead of <Tab>
set shiftwidth=4                           " Indentation length
set formatoptions-=r formatoptions-=o      " No autocontinue comment
runtime macros/matchit.vim                 " Enables matchit plugin
".................................. Mappings ...................................
nnoremap <space> /
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
" Easy search for word under cursor in current directory:
map <F11> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
"Easier quoting/unquoting:
nnoremap <Leader>q" ciw""<Esc>P
nnoremap <Leader>q' ciw''<Esc>P
nnoremap <Leader>q` ciw``<Esc>P
nnoremap <Leader>Q" ciW""<Esc>P
nnoremap <Leader>Q' ciW''<Esc>P
nnoremap <Leader>Q` ciW``<Esc>P
" Easy switching betWeen splits:
" NOTE: With windows <c-h> affects backspace as well.
tmap <c-j> <c-w>j
tmap <c-k> <c-w>k
tmap <c-l> <c-w>l
" Easy reload file:
nnoremap <leader>e :edit!<CR>
" Enable folding with the spacebar
nnoremap <leader>f zR
" Pasting from system clipboard in command and insert mode with Ctrl-v
" cmap <C-v> <C-r>*
" imap <C-v> <C-r>*
" Paste multiple lines correctly from system clipboard in normal mode
nnoremap <Leader>p :set paste <CR>o<esc>"*p :set nopaste<CR>
nnoremap <Leader>P :set paste <CR>O<esc>"*p :set nopaste<CR>
" Delete to the 'black hole' register
nnoremap <Leader>d "_d
nnoremap <Leader>D "_D
" Paste last yank in vim:
nnoremap 0p "0p
nnoremap 0P "0P
"............................ Better paste in WSL ..............................
if has('unix') && system('uname -a')=~#'Microsoft' "This checks if we are in WSL
    let s:clip = '/mnt/c/Windows/System32/clip.exe'
    if executable(s:clip)
        augroup WSLYank
            autocmd!
            autocmd TextYankPost * call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' | '.s:clip)
        augroup END
    end
    nnoremap <silent> <leader>p :r !powershell.exe -Command Get-Clipboard<CR>
    nnoremap <silent> <leader>P k:r !powershell.exe -Command Get-Clipboard<CR>
endif
"............................ general autocommands .............................
augroup general
    autocmd!
    autocmd filetype markdown setlocal nonumber textwidth=80
    autocmd filetype * setlocal breakindent formatoptions-=r formatoptions-=o
    autocmd BufWritePre * :%s/\s\+$//e   " Remove trailing space on write
    au BufEnter * call CloseLastWindow() " Close last window if quickfix etc
augroup END
function! CloseLastWindow()
  if winnr('$')==1 " If window is the last window
      if &buftype==?'quickfix'
          quit
      elseif &buftype==?'terminal'
          quit!
      elseif exists('b:NERDTree') && b:NERDTree.isTabTree()
          quit
      endif
  endif
endfunction
".............................. conceal settings ...............................
set conceallevel=2
let g:pandoc#syntax#conceal#use=0
"............................ vim-session settings .............................
let g:session_menu = 0
let g:session_autoload = 'no'
let g:session_autosave = 'no'
let g:session_autosave_periodic = 0
let g:session_verbose_messages = 0
" let g:session_autosave_silent = 1
" let g:session_default_to_last = 1
set sessionoptions-=help    " Don't restore help windows
set sessionoptions-=buffers " Don't save hidden and unloaded buffers in sessions
" Session mappings:
noremap <F3> :packadd vim-misc<CR>:packadd vim-session<CR>:OpenSession<CR>
imap <F3> <Esc>:packadd vim-misc<CR>:packadd vim-session<CR>:w<CR>:OpenSession<CR>
noremap AA :packadd vim-misc<CR>:packadd vim-session<CR>:OpenSession default<CR>
noremap SS :ccl<CR>:lcl<CR>:packadd vim-misc<CR>:packadd vim-session<CR>:SaveSession<CR>
noremap ZZ :ccl<CR>:lcl<CR>:packadd vim-misc<CR>:packadd vim-session<CR>:SaveSession<CR>:wqa<CR>
"............................. Ultisnips settings ..............................
let g:UltiSnipsSnippetDirectories=[expand($VIMHOME.'/mysnippets')] "Snippets dir
" Trigger config. Avoid <tab> if using https://github.com/Valloric/YouCompleteMe
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'
let g:UltiSnipsEditSplit='horizontal' " :UltiSnipsEdit split window direction.
inoremap <silent> <tab> <C-r>=LoadUltiSnips()<cr>
command! USE :packadd ultisnips|:UltiSnipsEdit
" This function only runs when UltiSnips is not loaded
function! LoadUltiSnips()
  let l:curpos = getcurpos()
  execute "packadd ultisnips"
  call cursor(l:curpos[1], l:curpos[2])
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
      " call feedkeys('    ')
      call feedkeys("\<tab>")
  endif
  return ""
endfunction
"................................ ALE Settings .................................
let g:ale_enabled=0        " Disabled at startup
let g:ale_set_highlights=0 " Do not highlight problems in text
" Shortcuts to enable/disable
nmap <silent> <leader>g :packadd ale<CR>:packadd vim-gitgutter<CR>:GitGutterDisable<CR>:ALEToggle<CR>
" Shortcuts to navigate errors
nmap <silent> [g <Plug>(ale_previous_wrap)
nmap <silent> ]g <Plug>(ale_next_wrap)
" let g:ale_lint_on_text_change='never' " Refresh on text change
" Use quickfix list:
" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1
" Fixers to use:
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['autopep8'],
\   'matlab': ['mlint'],
\   'vim': ['vint'],
\   'r': ['lintr'],
\   'tex': ['chktex'],
\   'julia': ['languageserver'],
\}
" Function that displays ' linting...' if ALE is running
function! ALErunning()
    if g:ale_enabled==0
        return ''
    else
        return 'linting'
    end
endfunction
"............................ simpleterm settings ..............................
if exists('g:simpleterm')
    " nnoremap <silent> <leader>t :Stoggle<CR> " Use <leader>ss
    let g:simpleterm.row=8
    nmap <silent> <leader><tab> :normal <leader>slj<CR>
    nmap <leader>sk :Skill<CR>
endif
"............................. NERDTree settings: ..............................
" Open split and then toggle nerdtree (more precse than the other way around)
nnoremap <silent> <leader>i :split \| :NERDTreeToggle<CR>
nnoremap <silent> <leader>v :vsplit \| :NERDTreeToggle<CR>
" Shortcuts to toggle NERDTree:
map <silent> <F1> :call NERDTreeToggleInCurDir()<CR>
imap <silent> <F1> <Esc>:call NERDTreeToggleInCurDir()<CR>
cmap <F1> <Esc><Esc>:call NERDTreeToggleInCurDir()<CR>
let NERDTreeShowHidden=1    " Show hidden files (eg. dotfiles)
let NERDTreeShowBookmarks=1 " Shows bookmarks
" if exists("loaded_nerd_tree")
"     augroup vimrc_nerdtree      " Open if vim is started without a file - SLOW
"         autocmd!
"         autocmd StdinReadPre * let s:std_in=1
"         autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"     augroup END
" endif
let NERDTreeQuitOnOpen = 1  " Closes NERDTree when opening a file
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore=['\c^ntuser\..*']
let g:NERDTreeUpdateOnWrite=1
" Open NERDTree in the directory of the current file (or /home if no file is open)
nmap <silent> <C-i> :call NERDTreeToggleInCurDir()<cr>
function! NERDTreeToggleInCurDir()
  " If NERDTree is open in the current buffer
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeClose"
  elseif &filetype!="help" " Try to open at current file directory, otherwise at current vim directory
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
nmap <silent> <leader>hh :packadd ale<CR>:packadd vim-gitgutter<CR>:ALEDisable<CR>:GitGutterToggle<CR>
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
" elseif has('unix') && system('uname -a')=~"Microsoft" "Checks if we are in wsl
"     let g:vimtex_view_general_viewer = 'TBD'
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
nnoremap <leader>as :AsyncStop<CR>
let $PYTHONUNBUFFERED=1    " See python realtime output
augroup vimrc_asyncrun     " Filetype specific mappings
    autocmd!
    if has('win32')
        autocmd FileType python nnoremap <silent> <buffer> <leader>aa :w<CR>:AsyncRun python "%"  <CR>
    else "
        autocmd FileType python nnoremap <silent> <buffer> <leader>aa :w<CR>:AsyncRun python3 "%"  <CR>
    endif
    autocmd FileType markdown nnoremap <silent> <buffer> <leader>al :w<CR>:AsyncRun pandoc --pdf-engine=xelatex "%" -o "%:r.pdf" --filter pandoc-fignos <CR>
    autocmd FileType markdown nnoremap <silent> <buffer> <leader>ll :w<CR>:AsyncRun pandoc --pdf-engine=xelatex "%" -o "%:r.pdf" --filter pandoc-fignos <CR>
    autocmd FileType markdown nnoremap <silent> <buffer> <leader>aa :w<CR>:AsyncRun pandoc -t html5 --css  "$(VIM_HOME)/otherstuff/mypdfstyle.css" "%" -o "%:r.pdf" <CR>
    autocmd FileType dosbatch nnoremap <silent> <buffer> <leader>aa :w<CR>:AsyncRun "%"  <CR>
    autocmd FileType julia    nnoremap <silent> <buffer> <leader>aa :w<CR>:AsyncRun julia "%"  <CR>
    autocmd FileType matlab   nnoremap <silent> <buffer> <leader>aa :w<CR>:AsyncRun matlab -nodesktop -nosplash -minimize -wait -log -r "try, run('%'); while ~isempty(get(0,'Children')); pause(0.5); end; catch ME; disp(ME.message); exit(1); end; exit(0);"<CR>
    autocmd FileType r        nnoremap <silent> <buffer> <leader>aa :w<CR>:AsyncRun Rscript "%" <CR>
    autocmd FileType stata    nnoremap <silent> <buffer> <leader>aa :w<CR>:AsyncRun "Stata-64.exe" -b do "%" &<CR>
    autocmd FileType tex      nnoremap <silent> <buffer> <leader>aa :w<CR>:VimtexCompile <CR>
augroup END
" Run and show output:
map <silent> <leader>aq <leader>aa:copen<CR>
"........................... Section line shortcuts ............................
" Defaults for section line and section title
nnoremap <silent> <leader>ts o<esc>80i#<Esc>
nnoremap <silent> <leader>tt :center 80<cr>hhv0r#A<space><esc>40A#<esc>"_d80\|
augroup vimrc_sections "Filetype dependent (only when different)
    autocmd!
    " Section line
    autocmd FileType markdown nnoremap <silent> <buffer> <leader>ts o<!--<esc>73a.<esc>a--><Esc>
    autocmd FileType matlab   nnoremap <silent> <buffer> <leader>ts o<esc>80i%<Esc>
    autocmd FileType stata    nnoremap <silent> <buffer> <leader>ts o<esc>80i*<Esc>
    autocmd FileType tex      nnoremap <silent> <buffer> <leader>ts o<esc>80i%<Esc>
    autocmd FileType vim      nnoremap <silent> <buffer> <leader>ts o"<esc>79a.<Esc>
    " Section title
    autocmd FileType markdown nnoremap <silent> <buffer> <leader>tt :center 80<cr>hhv0r.A<space><esc>40A.<esc>"_d80\|0R<!--<esc>$hhR--><esc>
    autocmd FileType matlab   nnoremap <silent> <buffer> <leader>tt :center 80<cr>hhv0r%A<space><esc>40A%<esc>"_d80\|
    autocmd FileType stata    nnoremap <silent> <buffer> <leader>tt :center 80<cr>hhv0r*A<space><esc>40A*<esc>"_d80\|
    autocmd FileType tex      nnoremap <silent> <buffer> <leader>tt :center 80<cr>hhv0r%A<space><esc>40A%<esc>"_d80\|
    autocmd FileType vim      nnoremap <silent> <buffer> <leader>tt :center 80<cr>hhv0r.A<space><esc>40A.<esc>"_d80\|0r"
augroup END
"............................. Quickfix shortcuts ..............................
nmap <script> <silent> <leader>cc :call ToggleQuickfixList()<CR>
" nnoremap <silent> <leader>cc :ccl<CR>
" nnoremap <silent> <leader>co :copen<CR>
nnoremap <silent> <leader>cn :cn<CR>
nnoremap <silent> <leader>cp :cp<CR>
"......................... Global syntax highlighting ..........................
" Check sintax highlighting group under cursor using HiLinkTrace
map <F10> :packadd vim-HiLinkTrace<CR>:HLT<CR>
augroup vimrc_syntax " Highlight Keywords uniformly
    autocmd!
    autocmd filetype matlab syntax match Comment "//.*$"
    au Syntax * syn match MyTodo /\v<(FIXME:|TODO:|OPTIMIZE:|FIXME|TODO|OPTIMIZE|XXX)/ containedin=.*Comment,vimCommentTitle
    au Syntax * syn match MyNote /\v<(NOTE:|NOTE |NB:|NB )/ containedin=.*Comment,vimCommentTitle
augroup END
hi! def link MyTodo Todo
hi! def link MyNote Constant
command! KWF execute "/\\v\TODO|\FIXME|\NOTE|\OPTIMIZE|\XXX"
command! KWD execute "vimgrep /\\v\TODO\|\FIXME\|\NOTE\|\OPTIMIZE\|\XXX/gj **/*" <Bar>
"................................. Word Count ..................................
function! WordCount()
   " Based on stackoverflow.com/questions/114431/fast-word-count-function-in-vim
   let s:old_status = v:statusmsg
   let position = getpos('.')
   exe ":silent normal g\<c-g>"
   let stat = v:statusmsg
   let s:word_count = 0
   let s:wordc_pos = 0
   if stat !=# '--No lines in buffer--'
     let s:wordc_pos = index(split(v:statusmsg),'Word')
     if s:wordc_pos != -1 " Not in visual mode
         let s:word_count = str2nr(split(v:statusmsg)[s:wordc_pos+3])
     else                 " In visual mode
         let s:wordc_pos = index(split(v:statusmsg),'Words;')
         let s:word_count = str2nr(split(v:statusmsg)[s:wordc_pos-3])
     let v:statusmsg = s:old_status
     end
       call setpos('.', position)
       return s:word_count
   else
       call setpos('.', position)
       return 'NA'
   end
endfunction
function! TexWordCount()
  if &filetype ==? 'tex'
    let s:TEXcount = split(system('TEXcount -nc -0 -sum -inc ' . expand('%')),'\n')[1]
    return s:TEXcount
  else
    return WordCount()
  end
endfunction
command! WC echom TexWordCount()
"................................ Toggle Note ..................................
" Toggle a markdown notes file in a fixed window on the right with F12
" The note.md file is created in the same directory as the current file
" Based on https://github.com/scrooloose/vimfiles
nnoremap <F12> :NotesToggle<cr>
command! -nargs=0 NotesToggle call <sid>toggleNotes()
function! s:toggleNotes() abort
    let winnr = bufwinnr('notes.md')
    if winnr > 0
        exec winnr . 'wincmd c'
        return
    endif
    if winwidth(0) > 160 " Open size 80 if window large, half window otherwise
        botright 80vs %:p:h/notes.md
    else
        botright  vs %:p:h/notes.md
    endif
    setl winfixwidth
    setl nonumber
    setl previewwindow   " hack to make nerdtree et al not split the window
endfunction
