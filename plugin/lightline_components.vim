" Functions that return a string if a plugin is running
" ALE:
function! ALErunning()
    if g:ale_enabled==0
        return ''
    else
        return 'linting'
    end
endfunction
" Gitgutter:
function! GitGutterRunning()
    if g:gitgutter_enabled==0
        return ''
    else
        return 'gitgutter'
    end
endfunction
