" Create a section title line from the text currently in the line or, if called
" from an empty line, create a separating line.
nnoremap <Plug>SectionTitle :call <sid>LineTitle()<CR>
function! s:LineTitle()
    if &filetype==#'vim'
        exe ':s@"@@ge'
        call <sid>LineC('.') | call feedkeys('0r"')
    elseif &filetype=~#'pandoc' || &filetype=~#'markdown' || &filetype=~#'vimwiki'
        exe ':s@<!--@@ge' | exe ':s@-->@@ge'
        call <sid>LineC('.') | call feedkeys("0R<!--\<esc>$hhR-->\<esc>")
    elseif &filetype==#'tex' || &filetype==#'matlab'
        call <sid>LineC('%')
    elseif &filetype==#'stata'
        call <sid>LineC('*')
    else
        call <sid>LineC('#')
    endif
endfunction
function! s:LineC(C)
    if a:C==#'.'
        exe ':s@\'.a:C.'@@ge'
    else
        exe ':s@'.a:C.'@@ge'
    endif
    exe ':s@^\s*@@ge'
    exe ':s@\s\+$@@ge'
    if getline('.') !~? '\S'
        call feedkeys('80i'.a:C."\<esc>")
    else
        let s:L = float2nr(floor((81 - col('$'))/2))
        call feedkeys('0'.s:L.'i'.a:C."\<esc>r A \<esc>".s:L.'a'.a:C."\<esc>")
        call feedkeys('$"_d80|')
    endif
endfunction

