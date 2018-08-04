" Bind F5 to save file if modified and execute python script in a buffer.
nnoremap <silent> <F5> :call ftplugin#python#SaveAndExecutePython()<CR>
vnoremap <silent> <F5> :<C-u>call ftplugin#python#SaveAndExecutePython()<CR>

nnoremap <silent> <F6> :call ftplugin#python#SEPython()<CR>
vnoremap <silent> <F6> :<C-u>call ftplugin#python#SEPython()<CR>
