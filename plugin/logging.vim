function! Mylog(message, file)
    if !filereadable(a:file)
        echo("ERROR: log file does not exist")
    else
        new
        setlocal buftype=nofile bufhidden=hide noswapfile nobuflisted
        put=a:message
        execute 'w >>' a:file
        q
    endif
endfun
