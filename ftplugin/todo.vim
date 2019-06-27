command! Mysort %call todo#txt#sort_by_project()| %sort | write
Mysort
augroup todoautoc
    au BufLeave * if &ft ==# 'todo' | %call todo#txt#sort_by_project() | %sort | write | endif
augroup END
