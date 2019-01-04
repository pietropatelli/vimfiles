function! s:StripTrailingWhitespaces()
    if !&binary && &filetype != 'diff'
        let l = line(".")
        let c = col(".")
        :silent! %s@\s\+$@@e
        :silent! %s@\($\n\s*\)\+\%$@@e
        call cursor(l, c)
    endif
endfun
command! RTW call <sid>StripTrailingWhitespaces()
" autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

autocmd BufNewFile,BufRead * call <sid>DetectWhitespace()
function! s:DetectWhitespace()
    let l = line(".")
    let c = col(".")
    if search("\\s\\+$")==0 && search("\\($\\n\\s*\\)\\+\\%$")==0
        autocmd BufWritePre <buffer> call <sid>StripTrailingWhitespaces()
    endif
    call cursor(l, c)
endfunction
