" NOTE: the .vimrc file in the home directory simply points here.
let mapleader = "\\"
let maplocalleader = "\\"
filetype plugin on
"Save current file and reload vimrc:
if has('unix') && system('uname -a')=~"Microsoft" "This checks if we are in wsl
    map <silent> <leader>rr :w<CR>:call system('dos2unix -n $(cmd.exe /C "cd /D %USERPROFILE% && bash.exe -c pwd")"/vimfiles/vimrc" ~/.vim/vimrc')<CR>:so $MYVIMRC<CR>
else
    map <silent> <leader>rr :w<CR>:so $MYVIMRC<CR>
endif
"................................... minpac ...................................
packadd minpac
call minpac#init()
" minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
" NOTE: I have added minpac as a submodule in my vimfiles repository.
" call minpac#add('k-takata/minpac', {'type': 'opt'})

" Add other plugins here.
call minpac#add('JuliaEditorSupport/julia-vim')
call minpac#add('lervag/vimtex')
call minpac#add('flazz/vim-colorschemes')
call minpac#add('rafi/awesome-vim-colorschemes')
call minpac#add('scrooloose/nerdtree')
call minpac#add('tomtom/tcomment_vim')
call minpac#add('farmergreg/vim-lastplace')
call minpac#add('tmhedberg/SimpylFold')
call minpac#add('itchyny/lightline.vim')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-dispatch')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('guns/vim-sexp')
call minpac#add('gu-fan/simpleterm.vim') "NOTE: change default shortcuts
call minpac#add('skywind3000/asyncrun.vim')
call minpac#add('zizhongyan/stata-vim-syntax')
call minpac#add('christoomey/vim-tmux-navigator') "Navigate vim and tmux
call minpac#add('benmills/vimux') "Send commands to tmux pane
""""""""""""""
" Interesting packages:
" call minpac#add('yssl/QFEnter')
" call minpac#add('milkypostman/vim-togglelist')
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
" call minpac#add('vim-pandoc/vim-pandoc') "NOTE: Requires python3
" call minpac#add('')
" Load the plugins right now. (optional)
packloadall
" Commands for easier package management
command! PUpdate call minpac#update()
command! PClean  call minpac#clean()
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
".......................... Lightline, airline etc.  ..........................
set laststatus=2
set noshowmode
" Lightline settings - NOTE: This must be before the colorscheme
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
"............................ Basic configuration: ............................
set encoding=utf-8 "unicode compatibility
set fileencoding=utf-8 "unicode compatibility
set fileencodings=ucs-bom,utf8,prc "unicode compatibility
set noeb vb t_vb= "Disable beeping
syntax on " Enables syntax highlighting
set background=dark
set t_Co=256 "Enables 256 color terminal; necessary for colorscheme to function
colorscheme hemisu  "GOOD ONES: meta5, iceberg, cobalt2, gruvbox, minimalist,
					"badwolf, zenburn, apprentice, hemisu, vividchalk,
					"distinguished, calmar256-dark, dracula, void, lucius,
                    "greenvision
set number "Adds line numbers
set cursorline " Highlight cursor line:
set hidden "Allows hidden edited bufferd
set wrap "wrap dynamically to window width
call matchadd('ColorColumn', '\%81v', 100) " Make 81srt column stand out
set scrolloff=3 "keep at least 3 lines above-below cursor
set sidescrolloff=5 "keep at least 5 columns to left-right of cursor
set splitbelow "default horizontal split
set splitright "default vertical split
:nnoremap <leader>i :split \| :NERDTreeToggle<CR>
:nnoremap <leader>v :vsplit \| :NERDTreeToggle<CR>
set guifont=consolas:h10 "Font settings for gvim.
set showmatch "bracket matching
set autoread "listen for external changes to file
set history=1000 "store long :cmdline history
" Search settings:
set ignorecase "Ignore case if search is all smallcase
set smartcase "Use case if search contains any uppercase letter
set hlsearch "highlight search results
nnoremap <silent> <leader>noh :noh<CR>
" Indentation settings:
set autoindent "apply current indent to next line
set smartindent "smart indenting, use in addition to `autoindent`
set breakindent "wrapped line continue visually indented
set foldmethod=indent "code folding using indent
set tabstop=4 "Tab length
set expandtab "Use the appropriate number of spaces to insert a <Tab>
set shiftwidth=4 "Indentation length
" Disable comment continuation on <Enter>:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
runtime macros/matchit.vim "Enables matchit plugin (included in base vim)
" Making Y work like C or D:
map Y y$
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
" Enable folding with the spacebar
nnoremap <space> zA
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
" shortcuts to toggle NERDTree:
map <silent> <F1> :NERDTreeToggle<CR>
imap <silent> <F1> <Esc>:NERDTreeToggle<CR>
cmap <F1> <Esc><Esc>:NERDTreeToggle<CR>
let NERDTreeShowHidden=1 "Show hidden files (eg. dotfiles)
let NERDTreeShowBookmarks=1 "Shows bookmarks
"open if vim is started without a file selcted:
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeQuitOnOpen = 1 "Closes NERDTree when opening a file
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore=['\c^ntuser\..*']
let g:NERDTreeUpdateOnWrite=1
" Close Vim if NERDTree is the only window open:
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" NERDtree git plugin settings: " FIXME: NERDTree-git-plugin doesn't work
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
let g:vimtex_view_general_viewer = 'sumatrapdf' 
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
if has('win32')
    autocmd FileType python   nnoremap <silent> <buffer> <leader>aa :w<CR>:AsyncRun python %  <CR>
    autocmd FileType markdown nnoremap <silent> <buffer> <leader>aa :w<CR>:AsyncRun pandoc -t html5 --css  ''$HOME."/vimfiles/otherstuff/mypdfstyle.css"'' % -o %:r.pdf <CR>
else
    autocmd FileType python   nnoremap <silent> <buffer> <leader>aa :w<CR>:AsyncRun python3 %  <CR>
    autocmd FileType markdown nnoremap <silent> <buffer> <leader>aa :w<CR>:AsyncRun pandoc -t html5 --css  ''$HOME."/.vim/otherstuff/mypdfstyle.css"'' % -o %:r.pdf <CR>
endif
autocmd FileType dosbatch nnoremap <silent> <buffer> <leader>aa :w<CR>:AsyncRun %  <CR>
autocmd FileType julia    nnoremap <silent> <buffer> <leader>aa :w<CR>:AsyncRun julia %  <CR>
autocmd FileType markdown nnoremap <silent> <buffer> <leader>al :w<CR>:AsyncRun pandoc % -o %:r.pdf <CR> 
autocmd FileType matlab   nnoremap <silent> <buffer> <leader>aa :w<CR>:AsyncRun matlab -nodesktop -nosplash -minimize -wait -log -r "try, run('%'); while ~isempty(get(0,'Children')); pause(0.5); end; catch ME; disp(ME.message); exit(1); end; exit(0);"<CR>
autocmd FileType r        nnoremap <silent> <buffer> <leader>aa :w<CR>:AsyncRun Rscript % <CR>
autocmd FileType stata    nnoremap <silent> <buffer> <leader>aa :w<CR>:AsyncRun "Stata-64.exe" -b do % &<CR>
autocmd FileType tex      nnoremap <silent> <buffer> <leader>aa :w<CR>:VimtexCompile <CR>
" Run and show output:
map <silent> <leader>aq <leader>aa:copen<CR>
"........................... Section line shortcuts ...........................
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
"............................. Quickfix shortcuts  ............................
nnoremap <silent> <leader>cc :ccl<CR>
nnoremap <silent> <leader>co :copen<CR>
nnoremap <silent> <leader>cv :copen<CR>
nnoremap <silent> <leader>cn :cn<CR>
nnoremap <silent> <leader>cp :cp<CR>
