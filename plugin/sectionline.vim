nnoremap <Plug>SectionTitle :call <sid>LineTitle()<CR>
function! s:LineTitle()
    if &filetype=='vim'
        exe ':s@"@@ge'
        call <sid>LineT('.') | call feedkeys('0r"')
    elseif &filetype=~'pandoc' || &filetype=~'markdown'
        exe ':s@<!--@@ge' | exe ':s@-->@@ge'
        call <sid>LineT('.') | call feedkeys("0R<!--\<esc>$hhR-->\<esc>")
    elseif &filetype=='tex' || &filetype=='matlab'
        call <sid>LineT('%')
    elseif &filetype=='stata'
        call <sid>LineT('*')
    else
        call <sid>LineT('#')
    endif
endfunction
function! s:LineT(C)
    if a:C=='.'
        exe ':s@\'.a:C.'@@ge'
    else
        exe ':s@'.a:C.'@@ge'
    endif
    exe ':s@^\s*@@ge'
    exe ':s@\s\+$@@ge'
    if getline('.') !~ '\S'
        call feedkeys("80i".a:C."\<esc>")
    else
        let s:L = float2nr(floor((81 - col('$'))/2))
        call feedkeys("0".s:L."i".a:C."\<esc>r A \<esc>".s:L."a".a:C."\<esc>")
        call feedkeys('$"_d80|')
    endif
endfunction

