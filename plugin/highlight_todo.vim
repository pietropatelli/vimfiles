augroup vimrc_syntax " Highlight Keywords uniformly
    autocmd!
    " autocmd filetype matlab syn match Comment "//.*$" contains=matlabTodo,matlabTab
    au Syntax * syn match MyTodo /\v<(FIXME:|TODO:|OPTIMIZE:|FIXME|TODO|OPTIMIZE|XXX)/ containedin=.*Comment,vimCommentTitle
    au Syntax * syn match MyNote /\v<(NOTE:|NOTE |NB:|NB )/ containedin=.*Comment,vimCommentTitle
augroup END
hi! def link MyTodo Todo
hi! def link MyNote Constant
command! KWF execute "/\\v\TODO|\FIXME|\NOTE|\OPTIMIZE|\XXX"
command! KWD execute "vimgrep /\\v\TODO\|\FIXME\|\NOTE\|\OPTIMIZE\|\XXX/gj **/*" <Bar>

