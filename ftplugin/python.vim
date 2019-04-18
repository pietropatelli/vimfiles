if has('win32')
    nnoremap <buffer> <Plug>MyAsyncRun :w<CR>:AsyncRun python "$(VIM_FILEPATH)"<CR>
    nnoremap <buffer> <Plug>MyAsyncRunBis :w<CR>:AsyncRun C:/Users/Pietr/Anaconda3/python "$(VIM_FILEPATH)"<CR>
else "
    nnoremap <buffer> <Plug>MyAsyncRun :w<CR>:AsyncRun python3 "$(VIM_FILEPATH)"<CR>
endif
command! Cpy :AsyncRun C:/Users/Pietr/Anaconda3/python "$(VIM_FILEPATH)"
