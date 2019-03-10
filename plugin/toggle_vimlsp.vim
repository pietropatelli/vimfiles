" Enable and Disable vim-lsp
if !exists("g:lsp_auto_enable")
    finish
elseif g:lsp_auto_enable == 0
    let g:vimlsp_enabled=0
else
    let g:vimlsp_enabled=1
endif
function! s:ToggleVimLsp() abort
   if g:vimlsp_enabled==0
       call lsp#enable()
       let g:vimlsp_enabled=1
   else
       let s:buf = bufnr('')
       call lsp#disable()
       call sign_undefine()
       augroup lsp
           autocmd!
       augroup END
       call sign_unplace('*', {'buffer' : s:buf})
       let g:vimlsp_enabled=0
   endif
endfunction
command! ToggleVimLsp call <sid>ToggleVimLsp()
" call lsp#stop_server('servername') " FIXME (Also need to be able to turn it back on)
