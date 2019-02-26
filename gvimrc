set guifont=consolas:h9
set ghr=-100
if &lines < 50
    set lines=60 columns=100
endif
if has('win64')
    map <F11> <Esc>:call libcallnr($VIMHOME.
                \"/otherstuff/gvimfullscreen_win32/gvimfullscreen_64.dll",
                \"ToggleFullScreen", 0)<CR><esc>
elseif has('win32')
    map <F11> <Esc>:call libcallnr($VIMHOME.
                \"/otherstuff/gvimfullscreen_win32/gvimfullscreen.dll",
                \"ToggleFullScreen", 0)<CR><esc>
endif
set guioptions -=m " Menu
set guioptions -=T " Toolbar
set guioptions -=r " Right scrollbar
set guioptions -=L " Left scrollbar
