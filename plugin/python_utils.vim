" Useful functions calling python

function! Strftime(format) range
pyx << EOF
import vim
import time
s = time.strftime(vim.eval("a:format"))
vim.command("let stime = '%s'"% s)
EOF
    return stime
endfunction
