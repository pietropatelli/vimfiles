" Remove trailing whitespace and trailing empty lines automatically on write
" if the file did not contain any when opened/created, or with STW command.
function! s:StripTrailingWhitespace()
    if !&binary && &filetype != 'diff'
        let l = line(".")
        let c = col(".")
        :silent! %s@\s\+$@@e
        :silent! %s@\($\n\s*\)\+\%$@@e
        call cursor(l, c)
    endif
endfun
command! STW call <sid>StripTrailingWhitespace()

autocmd BufNewFile,BufRead * call <sid>DetectWhitespace()
function! s:DetectWhitespace()
    let l = line(".")
    let c = col(".")
    if search("\\s\\+$")==0 && search("\\($\\n\\s*\\)\\+\\%$")==0
        autocmd BufWritePre <buffer> call <sid>StripTrailingWhitespace()
    endif
    call cursor(l, c)
endfunction
