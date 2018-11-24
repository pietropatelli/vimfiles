" my filetype file
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
    au! BufRead,BufNewFile *.mod		setfiletype matlab "dynare
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END

