    map <silent> <Plug>SourceVimrc   :w<CR>:so $MYVIMRC<CR>
    map <silent> <Plug>SourceCurrent :w<CR>:so %<CR>
if has('win32')                                 " WINDOWS (32 or 64 bit)
    map <silent> <Plug>SourceTheme :w<CR>:call system ('powershell -command "COPY
                \~/github/vim-nightsea/colors/nightsea.vim
                \~/vimfiles/colors/nightsea_dev.vim"')<CR>
                \:colorscheme nightsea_dev<CR>
elseif system('uname -a')=~#'Microsoft'         " WSL
        map <silent> <leader>nn :w<CR>:call system
                    \('dos2unix -n $WINHOME"/vimfiles/vimrc" ~/.vim/vimrc')<CR>
                    \:so $MYVIMRC<CR>
        map <silent> <Plug>SourceTheme :w<CR>:call system ('dos2unix -n
                    \$WINHOME"/github/vim-nightsea/colors/nightsea.vim"
                    \~/.vim/colors/nightsea_dev.vim')<CR>
                    \:colorscheme nightsea_dev<CR>
endif
