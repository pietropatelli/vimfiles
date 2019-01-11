" Save file with date/time. Based on: stackoverflow.com/questions/25163347
function! s:SaveWithTS(bang,filename,timeYN) range
    let l:extension = fnamemodify( a:filename, ':e' )
    if len(l:extension)==0 && len(a:filename)==0
        let l:extension = '.md'
    elseif len(l:extension)!=0
        let l:extension = '.'.l:extension
    endif
    if a:filename!=#''
        let l:filename = expand('%:p:h').'/'.a:filename.'_'
    else
        let l:filename = ''
    endif
    if a:timeYN
        let l:filename=escape(fnamemodify(l:filename,':r').
                    \strftime('%Y-%m-%d_%H-%M').l:extension,' ')
    else
        let l:filename=escape(fnamemodify(l:filename,':r').
                    \strftime('%Y-%m-%d').l:extension,' ')
    endif
    execute 'write' .a:bang.' '.l:filename
endfunction
command! -bang -nargs=? SWT call <sid>SaveWithTS('<bang>',expand('%:t').<q-args>,1)
command! -bang -nargs=? SWD call <sid>SaveWithTS('<bang>',expand('%:t').<q-args>,0)

