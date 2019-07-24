" Create a vertical right split window and then executes command
function! s:ToggleWin(check,command) abort
    if bufwinnr(a:check) > 0  " close window if already open
        while bufwinnr(a:check) > 0
            if winnr('$') == 1 " if the window is the only one open
                enew
            else
                exec bufwinnr(a:check).'wincmd c'
            endif
        endwhile
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
    setl noswapfile
    setl winfixwidth
    setl nonumber
    setl previewwindow " define window as preview
endfunction
" Toggle note:
command! ToggleNote call <sid>ToggleWin('notes.md',' e %:p:h/.notes.md')
" Toggle todo:
command! ToggleTodo call <sid>ToggleWin('todo.txt',' e ~/Dropbox/.todo/todo.txt')
" Toggle journal:
command! ToggleDiary call <sid>ToggleWin('diary/','VimwikiMakeDiaryNote')
" Toggle wiki:
command! ToggleWiki call <sid>ToggleWin('index.md','VimwikiIndex')
