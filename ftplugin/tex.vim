nnoremap <buffer> <Plug>MyAsyncRun :w<CR>:VimtexCompile <CR>
nnoremap <buffer> <leader>as :VimtexStop<CR>
set textwidth=0
nnoremap <buffer><silent> <leader>tr yyP :s@sub@@ge<CR>:s@\\section{@@ge<CR>:s@}@@ge<CR>:call LineTitle()<CR>
