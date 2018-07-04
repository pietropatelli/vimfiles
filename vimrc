"Note: the .vimrc file in the home directory consists of a single line: 'source vimfiles/vimrc

"""Basic configuration:
execute pathogen#infect()
syntax on " Enables syntax highlighting
set t_Co=256 "256 color terminal, necessary for proper functioning colorschemes
colorscheme cobalt2 "default is ron, good ones include meta5, iceberg and cobalt2
set number




"Key mappings:
map <C-1> :NERDTreeToggle<CR>
imap <a-ù> ~
cmap <a-ù> ~
imap <a-ì> ï 
cmap <a-ì> ï 


