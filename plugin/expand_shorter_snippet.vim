function! s:ExpandPossibleShorterSnippet()
  if len(UltiSnips#SnippetsInCurrentScope()) == 1 "only one candidate...
    let curr_key = keys(UltiSnips#SnippetsInCurrentScope())[0]
    if curr_key !~ ')?' "Avoid regular expression snippets
        exe "normal  i \<esc>".'vb"_c'.curr_key." \<esc>"
    endif
        return 1
  endif
  return 0
endfunction
inoremap <Plug>ExpandPossibleSnippetOrTab <C-R>=(<sid>ExpandPossibleShorterSnippet() == 0? '<tab>': UltiSnips#ExpandSnippet())<CR>
