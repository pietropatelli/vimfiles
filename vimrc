" NOTE: the .vimrc file in the home directory simply points here.
let mapleader = "\\"
let maplocalleader = "\\"
filetype plugin on
"................................... minpac ...................................
packadd minpac
call minpac#init() " NOTE: I have added minpac as a git submodule
" Essential plugins:
call minpac#add('scrooloose/nerdtree') " file tree browser
call minpac#add('skywind3000/asyncrun.vim') " Run commands asynchronously
call minpac#add('tomtom/tcomment_vim') " toggle comments
call minpac#add('farmergreg/vim-lastplace') " reopen files at last edit
call minpac#add('itchyny/lightline.vim') " statusline
call minpac#add('tpope/vim-fugitive') " Git integration
call minpac#add('airblade/vim-gitgutter') " Shows git diff in sign column
call minpac#add('godlygeek/tabular') " Align text
" call minpac#add('wellle/targets.vim') "Working inside pair of ([{,'
call minpac#add('milkypostman/vim-togglelist') "Toggle quickfix
call minpac#add('gu-fan/simpleterm.vim') "TODO: change default shortcuts
call minpac#add('christoomey/vim-tmux-navigator') "Navigate vim and tmux
call minpac#add('benmills/vimux') "Send commands to tmux pane TODO: figure out how
" colorscheme plugins:
" call minpac#add('PietroPate/vim-nightsea')
call minpac#add('flazz/vim-colorschemes')
call minpac#add('rafi/awesome-vim-colorschemes')
" language-specific plugins
call minpac#add('tmhedberg/SimpylFold') " smart python code folding
call minpac#add('JuliaEditorSupport/julia-vim') "julia support
call minpac#add('lervag/vimtex') " Simple latex integration
call minpac#add('zizhongyan/stata-vim-syntax') " stata grammar
""""" Interesting packages:
" call minpac#add('SirVer/ultisnips') " need python
" call minpac#add('w0rp/ale') " need the engine 
" call minpac#add('Valloric/YouCompleteMe') " need the engine
" call minpac#add('garbas/vim-snipmate') " weird behaviour
" call minpac#add('honza/vim-snippets') " need working engine
" call minpac#add('Xuyuanp/nerdtree-git-plugin') " doesn't work
" call minpac#add('ryanoasis/vim-devicons') " requires appropriate font
" call minpac#add('guns/vim-sexp') " not working for me
" call minpac#add('')
" Load the plugins right now:
packloadall
" Commands for easier package management
command! PUpdate packadd minpac | source $MYVIMRC | call minpac#update()
command! PClean  packadd minpac | source $MYVIMRC | call minpac#clean()
".......................... Lightline, airline etc.  ..........................
set laststatus=2
set noshowmode
" Lightline settings - Note: This must be before the colorscheme
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified',] ],
      \ 'right': [ [ 'lineinfo' ],
      \            [ 'percent' ],
      \            [ 'fileformat', 'fileencoding', 'filetype'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \ },
      \ }
"...................... General system-dependent options ......................
if has('win32') "WINDOWS (32 or 64 bit)
    set dir=~/vimfiles/tmp/.vim-swapfiles " directory for swap files
    map <silent> <leader>rr :w<CR>:so $MYVIMRC<CR>
else "UNIX OR WSL
    set dir=~/.vim/tmp/.vim-swapfiles " directory for swap files
    if system('uname -a')=~"Microsoft" " WSL
        map <silent> <leader>rr :w<CR>:call system('dos2unix -n $(cmd.exe /C "cd /D %USERPROFILE% && bash.exe -c pwd")"/vimfiles/vimrc" ~/.vim/vimrc')<CR>:so $MYVIMRC<CR>
        map <silent> <leader>ee :w<CR>:call system('dos2unix -n $(cmd.exe /C "cd /D %USERPROFILE% && bash.exe -c pwd")"/github/vim-nightsea/colors/nightsea.vim" ~/.vim/colors/nightsea.vim')<CR>:colorscheme nightsea<CR>
    else " UNIX ONLY
        map <silent> <leader>rr :w<CR>:so $MYVIMRC<CR>
    endif
endif
"............................ Basic configuration: ............................
syntax on " Enables syntax highlighting
set background=dark
set t_Co=256 "Enables 256 color terminal; necessary for colorscheme to function
try " If missing colorscheme simply use default
colorscheme nightsea  "GOOD ONES: meta5, iceberg, cobalt2, gruvbox, minimalist, badwolf, zenburn, apprentice, hemisu, vividchalk, distinguished, calmar256-dark, dracula, void, lucius, greenvision
catch
endtry
set swapfile "use swapfiles
if has('win32')
    set dir=~/vimfiles/tmp/.vim-swapfiles

else
    set dir=~/.vim/tmp/.vim-swapfiles
endif
set encoding=utf-8 "unicode compatibility
set fileencoding=utf-8 "unicode compatibility
set fileencodings=ucs-bom,utf8,prc "unicode compatibility
set noeb vb t_vb= "Disable beeping
set number "Adds line numbers
set cursorline " Highlight cursor line:
set hidden "Allows hidden edited bufferd
set wrap "wrap dynamically to window width
call matchadd('ColorColumn', '\%81v', 100) " Make 81srt column stand out
set scrolloff=3 "keep at least 3 lines above-below cursor
set sidescrolloff=5 "keep at least 5 columns to left-right of cursor
set splitbelow "default horizontal split
set splitright "default vertical split
set guifont=consolas:h10 "Font settings for gvim.
" TODO set font options when consolas is not available
set showmatch "bracket matching
set autoread "listen for external changes to file
set history=500 "store long :cmdline history
" Search settings:
set ignorecase "Ignore case if search is all smallcase
set smartcase "Use case if search contains any uppercase letter
" set hlsearch "highlight search results
nnoremap <silent> <leader>cs :let @/ = ""<CR>
nnoremap <silent> <leader>noh :noh<CR>
nnoremap <silent> <leader>hls :set hlsearch!<CR>
" Indentation settings:
filetype indent on "better indenting - substitutes auto,smart and c indent
set breakindent "wrapped line continue visually indented
" set foldmethod=indent "code folding using indent
set foldlevelstart=1 "Open level x-level folds on start
set tabstop=4 "Tab length
set expandtab "Use the appropriate number of spaces to insert a <Tab>
set shiftwidth=4 "Indentation length
set lazyredraw " Don't redraw while executing macros (good performance config)
" Disable comment continuation on <Enter>:
set formatoptions-=c formatoptions-=r formatoptions-=o
runtime macros/matchit.vim "Enables matchit plugin (included in base vim)
" Making Y work like C or D:
map Y y$
" Making H work like J but putting the current line after the next one
map H ddpkJ
" Allow j and k to move in autocomplete list
inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))
".............................. Paste settings: ...............................
" set clipboard=unnamed " Always use system clipboard
"Pasting from system clipboard in command and insert mode with Ctrl-vò
cmap <C-v> <C-r>*
imap <C-v> <C-r>*
" Easy toggle paste mode:
" set pastetoggle=Ά "This is <F12> on my laptop
" set pastetoggle=<F12> "This is <F12> on my laptop
" Alternative shortcut to paste correctly from system clipboard in normal mode
" map <Leader>p :set paste<CR>o<esc>"*p:set nopaste<cr>
noremap <Leader>p :set paste <CR>o<esc>"*p :set nopaste<CR>
noremap <Leader>P :set paste <CR>O<esc>"*p :set nopaste<CR>
noremap <Leader>y "*y
"............................ Better paste in WSL .............................
if has('unix') && system('uname -a')=~"Microsoft" "This checks if we are in wsl
    let s:clip = '/mnt/c/Windows/System32/clip.exe' 
    if executable(s:clip)
        augroup WSLYank
            autocmd!
            autocmd TextYankPost * call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' | '.s:clip)
        augroup END
    end
    map <silent> <leader>lp :r !powershell.exe -Command Get-Clipboard<CR>
    map <silent> <leader>lP k:r !powershell.exe -Command Get-Clipboard<CR>
    cmap <silent> <c-v> :r !powershell.exe -Command Get-Clipboard<CR>
    imap <silent> <c-v> :r !powershell.exe -Command Get-Clipboard<CR>
endif
".................................. Mappings ..................................
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
" Easy search for current word in current directory "Note: <F11> on my keyboard 
" TODO: Figure out what cw<CR> is there for 
map ΅ :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR> 
map <F11> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR> 
"Easier quoting/unquoting:
:nnoremap <Leader>q" ciw""<Esc>P
:nnoremap <Leader>q' ciw''<Esc>P
:nnoremap <Leader>q` ciw``<Esc>P
"
" Easy switching between splits:
" NOTE: With windows <c-h> affects backspace as well.
" nmap <c-j> <c-w>j
" nmap <c-k> <c-w>k
" nmap <c-h> <c-w>h
" nmap <c-l> <c-w>l
"
tmap <c-j> <c-w>j
tmap <c-k> <c-w>k
tmap <c-l> <c-w>l
"
" Easy reload file:
nnoremap <leader>e :edit!<CR>
" Enable folding with the spacebar
nnoremap <space> /
nnoremap <leader>f zR
"............................... :term settings ...............................
" Alt-t to start terminal at 10 size
nnoremap <silent> <a-t> :term ++rows=8 <CR>
nnoremap <silent> <leader>t :term ++rows=8 <CR>
" Terminal settings using simpleterm:
let g:simpleterm.row=8
" nmap <silent> <a-t> :Stoggle<CR>
nmap <silent> <a-e> :Sline<CR>
vmap <silent> <a-e> :Sline<CR>
"............................. NERDTree settings: .............................
" Open split and then toggle nerdtree (more precse than the other way around)
:nnoremap <leader>i :split \| :NERDTreeToggle<CR>
:nnoremap <leader>v :vsplit \| :NERDTreeToggle<CR>
" shortcuts to toggle NERDTree:
map <silent> <F1> :NERDTreeToggle<CR>
imap <silent> <F1> <Esc>:NERDTreeToggle<CR>
cmap <F1> <Esc><Esc>:NERDTreeToggle<CR>
let NERDTreeShowHidden=1 "Show hidden files (eg. dotfiles)
let NERDTreeShowBookmarks=1 "Shows bookmarks
"open if vim is started without a file selcted:
augroup vimrc_nerdtree
    autocmd!
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
augroup END
let NERDTreeQuitOnOpen = 1 "Closes NERDTree when opening a file
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore=['\c^ntuser\..*']
let g:NERDTreeUpdateOnWrite=1
" Close Vim if NERDTree is the only window open:
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" NERDtree git plugin settings: " FIXME -  NERDTree-git-plugin doesn't work
" let g:NERDTreeUseSimpleIndicator = 1
" let g:NERDTreeShowGitStatus=1
"........................... Auto close last window ...........................
" Auto close last window if it is NERDTree or Quickfix
au BufEnter * call CloseLastWindow()
function! CloseLastWindow()
  " Check if window is the last window
  if winnr('$')==1  
      " if the window is quickfix
      if &buftype=="quickfix"
          quit
      " if the window is terminal
      elseif &buftype=="terminal"
          quit!
      " if the window is a NERDTree window
      elseif exists("b:NERDTree") && b:NERDTree.isTabTree()
          quit
      endif
  endif
endfunction
"............................ Git gutter settings: ............................
let g:gitgutter_enabled = 0
nmap <a-g> :GitGutterEnable<CR>
nmap <a-G> :GitGutterDisable<CR>
nmap <leader>g :GitGutterEnable<CR>
nmap <leader>G :GitGutterDisable<CR>
".............................. Vimtex settings: ..............................
let g:tex_flavor='latex'
if has('win32')
    let g:vimtex_view_general_viewer = 'sumatrapdf'
" elseif has('unix') && system('uname -a')=~"Microsoft" "Checks if we are in wsl
"     let g:vimtex_view_general_viewer = 'sumatrapdf.exe'
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
let g:vimtex_latexmk_background       = 1
let g:vimtex_quickfix_mode=0
"............................. AsyncRun Settings ..............................
" let g:asyncrun_open = 8 "opens quickfix by default
let g:asyncrun_last = 1 "scroll only if cursor is on last line 
nnoremap <leader>as :AsyncStop<CR>
" See python realtime output
let $PYTHONUNBUFFERED=1
" Filetype specific mappings:
augroup vimrc_asyncrun
    au!
    if has('win32')
        autocmd FileType python   nnoremap <silent> <buffer> <leader>aa :w<CR>:AsyncRun python %  <CR>
        " FIXME - The relative path (using $HOME) does not work:
        autocmd FileType markdown nnoremap <silent> <buffer> <leader>aa :w<CR>:AsyncRun pandoc -t html5 --css  "C:/Users/Pietr/vimfiles/otherstuff/mypdfstyle.css" % -o %:r.pdf \| sumatrapdf %:r.pdf <CR> 
        autocmd FileType markdown nnoremap <silent> <buffer> <leader>al :w<CR>:AsyncRun pandoc --pdf-engine=xelatex % -o %:r.pdf \| sumatrapdf %:r.pdf <CR> 
    else
        autocmd FileType python   nnoremap <silent> <buffer> <leader>aa :w<CR>:AsyncRun python3 %  <CR>
        autocmd FileType markdown nnoremap <silent> <buffer> <leader>aa :w<CR>:AsyncRun pandoc -t html5 --css  ''$HOME"/.vim/otherstuff/mypdfstyle.css"'' % -o %:r.pdf <CR>
        autocmd FileType markdown nnoremap <silent> <buffer> <leader>al :w<CR>:AsyncRun pandoc --pdf-engine=xelatex % -o %:r.pdf <CR> 
    endif
    autocmd FileType dosbatch nnoremap <silent> <buffer> <leader>aa :w<CR>:AsyncRun %  <CR>
    autocmd FileType julia    nnoremap <silent> <buffer> <leader>aa :w<CR>:AsyncRun julia %  <CR>
    autocmd FileType matlab   nnoremap <silent> <buffer> <leader>aa :w<CR>:AsyncRun matlab -nodesktop -nosplash -minimize -wait -log -r "try, run('%'); while ~isempty(get(0,'Children')); pause(0.5); end; catch ME; disp(ME.message); exit(1); end; exit(0);"<CR>
    autocmd FileType r        nnoremap <silent> <buffer> <leader>aa :w<CR>:AsyncRun Rscript % <CR>
    autocmd FileType stata    nnoremap <silent> <buffer> <leader>aa :w<CR>:AsyncRun "Stata-64.exe" -b do % &<CR>
    autocmd FileType tex      nnoremap <silent> <buffer> <leader>aa :w<CR>:VimtexCompile <CR>
augroup END
" Run and show output:
map <silent> <leader>aq <leader>aa:copen<CR>
"........................... Section line shortcuts ...........................
augroup vimrc_sections
    au!
    " Section line
    autocmd FileType python   nnoremap <silent> <buffer> <leader>ss o<esc>79i#<Esc>
    autocmd FileType sh       nnoremap <silent> <buffer> <leader>ss o<esc>79i#<Esc>
    autocmd FileType julia    nnoremap <silent> <buffer> <leader>ss o<esc>79i#<Esc>
    autocmd FileType markdown nnoremap <silent> <buffer> <leader>ss o<!--<esc>72a.<esc>a--><Esc>
    autocmd FileType matlab   nnoremap <silent> <buffer> <leader>ss o<esc>79i%<Esc>
    autocmd FileType r        nnoremap <silent> <buffer> <leader>ss o<esc>79i#<Esc>
    autocmd FileType stata    nnoremap <silent> <buffer> <leader>ss o<esc>79i*<Esc>
    autocmd FileType tex      nnoremap <silent> <buffer> <leader>ss o<esc>79i%<Esc>
    autocmd FileType vim      nnoremap <silent> <buffer> <leader>ss o"<esc>78a.<Esc>
    " Transform line to section title l<silent> ine
    autocmd FileType python   nnoremap <silent> <buffer> <leader>st :center 80<cr>hhv0r#A<space><esc>40A#<esc>"_d79\|
    autocmd FileType sh       nnoremap <silent> <buffer> <leader>st :center 80<cr>hhv0r#A<space><esc>40A#<esc>"_d79\|
    autocmd FileType julia    nnoremap <silent> <buffer> <leader>st :center 80<cr>hhv0r#A<space><esc>40A#<esc>"_d79\|
    autocmd FileType markdown nnoremap <silent> <buffer> <leader>st :center 80<cr>hhv0r.A<space><esc>40A.<esc>"_d79\|0R<!--<esc>$hhR--><esc>
    autocmd FileType matlab   nnoremap <silent> <buffer> <leader>st :center 80<cr>hhv0r%A<space><esc>40A%<esc>"_d79\|
    autocmd FileType r        nnoremap <silent> <buffer> <leader>st :center 80<cr>hhv0r#A<space><esc>40A#<esc>"_d79\|
    autocmd FileType stata    nnoremap <silent> <buffer> <leader>st :center 80<cr>hhv0r*A<space><esc>40A*<esc>"_d79\|
    autocmd FileType tex      nnoremap <silent> <buffer> <leader>st :center 80<cr>hhv0r%A<space><esc>40A%<esc>"_d79\|
    autocmd FileType vim      nnoremap <silent> <buffer> <leader>st :center 80<cr>hhv0r.A<space><esc>40A.<esc>"_d79\|0r"
augroup END
"............................. Quickfix shortcuts  ............................
nmap <script> <silent> <leader>cc :call ToggleQuickfixList()<CR>
" nnoremap <silent> <leader>cc :ccl<CR>
" nnoremap <silent> <leader>co :copen<CR>
" nnoremap <silent> <leader>cv :copen<CR>
nnoremap <silent> <leader>cn :cn<CR>
nnoremap <silent> <leader>cp :cp<CR>
"......................... Global syntax highlighting .........................
" Check sintax highlighting group under cursor 
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
augroup vimrc_syntax
    au!
    au Syntax * syn match MyTodo /\v<(FIXME:|TODO:|OPTIMIZE:|FIXME|TODO|OPTIMIZE|XXX)/ containedin=.*Comment,vimCommentTitle
    au Syntax * syn match MyNote /\v<(NOTE:|NOTE|NB:|NB)/ containedin=.*Comment,vimCommentTitle
augroup END
hi! def link MyTodo Todo
hi! def link MyNote Constant
command! KWF execute "/\\v\TODO|\FIXME|\NOTE|\OPTIMIZE|\XXX"
command! KWD execute "vimgrep /\\v\TODO\|\FIXME\|\NOTE\|\OPTIMIZE\|\XXX/gj **/*" <Bar>
"................................. Word Count .................................
function! WordCount()
    " Based on: https://stackoverflow.com/questions/114431/fast-word-count-function-in-vim
   let s:old_status = v:statusmsg
   let position = getpos(".")
   exe ":silent normal g\<c-g>"
   let stat = v:statusmsg
   let s:word_count = 0
   let s:wordc_pos = 0
   if stat != '--No lines in buffer--'
     let s:wordc_pos = index(split(v:statusmsg),'Word')
     if s:wordc_pos != -1 "Not in visual mode
         let s:word_count = str2nr(split(v:statusmsg)[s:wordc_pos+3])
     else "In visual mode
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
  if &filetype == 'tex'
    let s:TEXcount = split(system('TEXcount -nc -0 -sum -inc ' . expand('%')),'\n')[1]
    return s:TEXcount
  else
    return WordCount()
  end
endfunction
command! WC echom TexWordCount()
