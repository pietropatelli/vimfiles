nmap <buffer><silent> <leader>gg :packadd vim-gitgutter<CR>:GitGutterDisable<CR>:ToggleVimLsp<CR>
nnoremap <buffer> <Plug>MyAsyncRun :w<CR>:AsyncRun julia "$(VIM_FILEPATH)"  <CR>
