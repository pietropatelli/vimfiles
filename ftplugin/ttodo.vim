setlocal noswapfile
setlocal nrformats+=alpha
augroup todoautoc
    au BufWritePre,FileWritePre * if &ft ==# 'ttodo' | execute "silent g/^\s*$/d" | Ttodoarchive | Ttodosort | endif
augroup END
exec 'nnoremap <silent><buffer>' g:ttodo#mapleader .'j :normal! 0f)h <cr>'
exec 'nnoremap <silent><buffer>' g:ttodo#mapleader .'k :normal! 0f)h <cr>'
