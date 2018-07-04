"NOTE: the .vimrc file in the home directory consists of a single line: 'source ~/vimfiles/vimrc

"""Basic configuration:
execute pathogen#infect()
syntax on " Enables syntax highlighting
set t_Co=256 
colorscheme cobalt2 "default is ron, good ones include meta5, iceberg and cobalt2
set number

set noeb vb t_vb= "Disable beeping 


"Key mappings:
map <C-1> :NERDTreeToggle<CR>
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
