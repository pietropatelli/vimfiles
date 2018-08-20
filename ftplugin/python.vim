if has('win32')
    autocmd FileType python   nnoremap <silent> <buffer> <leader>aa :AsyncRun python %  <CR>
else
    autocmd FileType python   nnoremap <silent> <buffer> <leader>aa :AsyncRun python3 %  <CR>
endif
