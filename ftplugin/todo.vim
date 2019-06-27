setlocal noswapfile
augroup todoautoc
    au BufWritePre,FileWritePre * if &ft ==# 'todo' | call todo#txt#remove_completed() | execute "silent g/^\s*$/d" | %call todo#txt#sort_by_project() | %sort | endif
augroup END
