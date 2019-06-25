" Create a vertical right split window and then executes command
function! s:ToggleWin(check,command) abort
    let winnr = bufwinnr(a:check)
    if winnr > 0  " close window if already open
        exec winnr.'wincmd c'
        return
    else
        pclose " close any other preview window
    endif
    if winwidth(0) > 160 " Open size 80 if window large, half window otherwise
        botright 80vsplit
    else
        botright vsplit
    endif
    exec a:command
    setl winfixwidth
    setl nonumber
    setl previewwindow " define window as preview
endfunction
" Toggle note:
command! ToggleNote call <sid>ToggleWin('notes.md',' e %:p:h/.notes.md')
" Toggle todo:
command! ToggleTodo call <sid>ToggleWin('todo.txt',' e ~/Dropbox/todo/todo.txt')
" Toggle journal:
command! ToggleDiary call <sid>ToggleWin('diary/','VimwikiMakeDiaryNote')
" Toggle wiki:
command! ToggleWiki call <sid>ToggleWin('index.md','VimwikiIndex')
