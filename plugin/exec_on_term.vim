function s:exec_on_term(lnum1, lnum2, trimYN, addnlYN)
  " get terminal buffer
  let g:terminal_buffer = get(g:, 'terminal_buffer', -1)
  " open new terminal if it doesn't exist
  if g:terminal_buffer == -1 || !bufexists(g:terminal_buffer)
    terminal
    let g:terminal_buffer = bufnr('')
    wincmd p
  " split a new window if terminal buffer hidden
  elseif bufwinnr(g:terminal_buffer) == -1
    exec 'sbuffer ' . g:terminal_buffer
    wincmd p
  endif
  " join lines with "\<cr>", note the extra "\<cr>" for last line
  let s:tosend = join(getline(a:lnum1, a:lnum2), "\<cr>") . "\<cr>"
  if a:trimYN " remove leading and traling whitespace
      let s:tosend = substitute(s:tosend, '\v^\s*([^ ]+)\s*$', '\1', '')
  endif
  if a:addnlYN && a:lnum1 != a:lnum2 " add extra newline
      let s:tosend = s:tosend . "\<cr>"
  endif
  " send to terminal
  call term_sendkeys(g:terminal_buffer, s:tosend)
endfunction

command! -range ExecOnTerm call s:exec_on_term(<line1>, <line2>, 1, 1)
nnoremap <leader>ex :ExecOnTerm<cr>
vnoremap <leader>ex :ExecOnTerm<cr>
