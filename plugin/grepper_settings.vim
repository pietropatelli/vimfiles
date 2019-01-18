function! Grepper_setup() abort
    if !exists('g:loaded_grepper')
        exe ':packadd vim-grepper'
        exe "let g:grepper.git.grepprg .= 'i'"
        exe "let g:grepper.findstr.grepprg = 'findstr -rspinc:$* *'"
    endif
endfunction
command! -nargs=? GrepG call Grepper_setup() | GrepperGit <q-args>
command! Grep call Grepper_setup() | Grepper
