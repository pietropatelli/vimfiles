if has('win32')
    nnoremap <buffer> <Plug>MyAsyncRun :w<CR>:AsyncRun python "$(VIM_FILEPATH)"<CR>
else "
    nnoremap <buffer> <Plug>MyAsyncRun :w<CR>:AsyncRun python3 "$(VIM_FILEPATH)"<CR>
endif
