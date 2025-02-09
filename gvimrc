set guifont=Source\ Code\ Pro\ for\ Powerline:h11,DejaVu_Sans_Mono_for_Powerline:h8,consolas:h9
set background=dark

set ghr=-100
if &lines < 50
    set lines=60 columns=100
endif
if has('win64')
    map <F11> <Esc>:call libcallnr("gvimfullscreen_64.dll",
                \"ToggleFullScreen", 0)<CR><esc>
elseif has('win32')
    map <F11> <Esc>:call libcallnr("gvimfullscreen.dll",
                \"ToggleFullScreen", 0)<CR><esc>
endif
set guioptions -=m " Menu
set guioptions -=T " Toolbar
set guioptions -=r " Right scrollbar
set guioptions -=L " Left scrollbar
