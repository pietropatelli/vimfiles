" Toggle NERDTree in current file directory (or /home if no file is open)
function! s:NERDTreeToggleInFileDir()
  if (exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1)
    exe ':NERDTreeClose'
  elseif &filetype!=?'help' " Try to open at current file dir, otherwise at pwd
    exe ':silent! NERDTree %:p:h'
      if !(exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1)
        exe ':NERDTreeCWD'
      endif
  else
    exe ':NERDTreeCWD'
  endif
endfunction
nnoremap <Plug>NERDTreeToggleInFileDir :call <sid>NERDTreeToggleInFileDir()<CR>
