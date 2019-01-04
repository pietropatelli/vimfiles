autocmd BufEnter * call CloseLastWindow() " Close last window if quickfix etc
function! CloseLastWindow()
  if winnr('$')==1 " If window is the last window
      if &buftype==?'quickfix'
          quit
      elseif &buftype==?'terminal'
          quit!
      elseif exists('b:NERDTree') && b:NERDTree.isTabTree()
          quit
      endif
  endif
endfunction

