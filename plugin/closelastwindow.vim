" Close the last window automatically if it is a quickfix, terminal or nerdtree window
autocmd BufEnter * call CloseLastWindow()
function! CloseLastWindow()
  if winnr('$')==1 " If window is the last window
      if &buftype==?'quickfix'
          quit
      elseif &buftype==?'terminal'
          quit!
      elseif &buftype==?'nofile'
          quit
      elseif exists('b:NERDTree') && b:NERDTree.isTabTree()
          quit
      endif
  endif
endfunction

