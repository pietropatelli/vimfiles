" my filetype file
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
    autocmd!
    autocmd BufNewFile,BufFilePre,BufRead *.mod		setfiletype matlab "dynare
    autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END

