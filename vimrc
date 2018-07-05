"NOTE: the .vimrc file in the home directory consists of a single line: 'source ~/vimfiles/vimrc
""""""""""""""""""" VUNDLE STUFF
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/vimfiles/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"" My Plugins
Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/nerdtree'
" All of your Plugins must be added before the following line
call vundle#end()            " required
"filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on


"""""""""""""""""""""""""""""""""
"""Basic configuration:
"execute pathogen#infect()
syntax on " Enables syntax highlighting
set t_Co=256 "Enables 256 color terminal; necessary for colorscheme to function properly
colorscheme iceberg "default is ron, good ones include meta5, iceberg and cobalt2
set number "Adds line numbers

set noeb vb t_vb= "Disable beeping 
set guifont=consolas:h10 "Font settings for gvim.
set showmatch "bracket matching
"Key mappings:
map <C-1> :NERDTreeToggle<CR> 
imap <a-�> ~
cmap <a-�> ~
imap <a-�> � 
cmap <a-�> � 

"Habit breaking:
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
imap <Up> <NOP>
imap <Down> <NOP>
imap <Left> <NOP>
imap <Right> <NOP>

"store lots of :cmdline history
set history=100

"Show current mode at bottom:
set showmode	

"code folding settings:
set foldmethod=indent


