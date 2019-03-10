" Functions that return a string if a plugin is running
" ALE:
function! ALErunning()
    if g:ale_enabled==0
        return ''
    else
        return 'ALE'
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
" Vim_LSP:
let g:vimlsp_enabled=0
function! VimLspRunning()
    if g:vimlsp_enabled==0
        return ''
    else
        return 'vim-lsp'
    end
endfunction
