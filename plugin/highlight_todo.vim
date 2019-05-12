" Ensure uniform highlighting of keywords and add commands to search them in
" file or directory
augroup vimrc_syntax
    autocmd!
    au Syntax * syn match MyTodo /\v<(FIXME:|TODO:|OPTIMIZE:|XXX:|FIXME|TODO|OPTIMIZE|XXX)/ containedin=.*Comment,vimCommentTitle
    au Syntax * syn match MyNote /\v<(NOTE:|NOTE |NB:|NB )/ containedin=.*Comment,vimCommentTitle
augroup END
hi! def link MyTodo Todo
hi! def link MyNote Constant
command! KWF execute "/\\v\TODO|\FIXME|\OPTIMIZE|\XXX"
command! KWD call Grepper_setup() | :Grepper -noprompt -tool git -grepprg git grep -nI "\(TODO\|FIXME\|OPTIMIZE\|XXX\)"
command! Todo :KWD
