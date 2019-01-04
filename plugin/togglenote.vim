" Toggle a markdown notes file in a fixed window on the right with F12
" The note.md file is created in the same directory as the current file
" Based on github.com/scrooloose/vimfiles
nnoremap <Plug>ToggleNote :call <sid>ToggleNote()<cr>
function! s:ToggleNote() abort
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
