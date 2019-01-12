" Yank the path of the current file or the file highlighted in NERDTree
function! s:GetFilePath()
    if &filetype==?'nerdtree'
        let n = g:NERDTreeFileNode.GetSelected()
        if n != {}
            call setreg('*', substitute(n.path.str(),'\\','/','g'))
        endif
    else
        call setreg('*', substitute(expand('%:p'),'\\','/','g'))
    endif
    echo 'Yanked file path to clipboard'
endfunction
nnoremap <Plug>GetFilePath :call <sid>GetFilePath()<CR>
command! GFP :call <sid>GetFilePath()

" Command to delete current file
command! -bang Remove :call delete(expand('%')) | :let &modified=1
