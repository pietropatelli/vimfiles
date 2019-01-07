inoremap <buffer><silent> <tab> <C-R>=(ExpandPossibleShorterSnippet() == 0? '<tab>': UltiSnips#ExpandSnippet())<CR>
