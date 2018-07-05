"NOTE: the .vimrc file in the home directory consists of a single line: 'source ~/vimfiles/vimrc
""""""""""""""""""" VIM-PLUG:
call plug#begin('~/vimfiles/plugged')
Plug 'flazz/vim-colorschemes'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree'
"Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
"Plug 'terryma/vim-multiple-cursors'
"""" FIXME (for some reason Vim-Plug does not install it):""" Plug 'vim-ctrlspace/vim-ctrlspace'
call plug#end()
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
map <silent> <C-1> :NERDTreeToggle<CR> 
imap <a-ù> ~
cmap <a-ù> ~
imap <a-ì> ï 
cmap <a-ì> ï 

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

