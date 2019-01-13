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

" Delete hidden, unmodified buffers
function! DeleteHiddenBuffers()
    let tpbl = []
    let closed = 0
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        if getbufvar(buf, '&mod') == 0
            silent execute 'bwipeout' buf
            let closed += 1
        endif
    endfor
    echo "Closed ".closed." hidden buffers"
endfunction
command! DHB :call DeleteHiddenBuffers()

" Command to delete current file
command! -bang Remove :call delete(expand('%')) | :let &modified=1
