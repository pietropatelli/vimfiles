function s:exec_to_term(lnum1, lnum2, trimYN, addnlYN)
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
  if a:trimYN " remove leading whitespace
      let s:tosend = substitute(s:tosend, '^\s*', '\1', 'g')
      let s:tosend = substitute(s:tosend, '\r\s*', '\n\1', 'g')
  endif
  if a:addnlYN && a:lnum1 != a:lnum2 " add extra newline
      let s:tosend = s:tosend . "\<cr>"
  endif
  " send to terminal
  call term_sendkeys(g:terminal_buffer, s:tosend)
endfunction

command! -range ExecToTerm call s:exec_to_term(<line1>, <line2>, 0, 1)
nnoremap <leader>ex :ExecOnTerm<cr>
vnoremap <leader>ex :ExecOnTerm<cr>

command! -range ExecTrimToTerm call s:exec_to_term(<line1>, <line2>, 1, 1)
nnoremap <leader>et :TrimOnTerm<cr>
vnoremap <leader>et :TrimOnTerm<cr>
