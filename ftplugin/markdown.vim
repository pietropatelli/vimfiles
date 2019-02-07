nnoremap <buffer> <Plug>MyAsyncRunBis :w<CR>:AsyncRun pandoc --pdf-engine=xelatex "$(VIM_FILEPATH)" -o "$(VIM_PATHNOEXT).pdf" --filter pandoc-fignos <CR>
nmap <silent> <leader>ll <Plug>MyAsyncRunBis:echo("Running...")<CR>
nnoremap <buffer> <Plug>MyAsyncRun :w<CR>:AsyncRun pandoc -t html5 --css  "$(VIM_HOME)/otherstuff/mypdfstyle.css" "$(VIM_FILEPATH)" -o "$($VIM_PATHNOEXT).pdf" <CR>
