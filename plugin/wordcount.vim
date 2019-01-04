function! s:WordCount()
   " Based on stackoverflow.com/questions/114431/fast-word-count-function-in-vim
   let s:old_status = v:statusmsg
   let position = getpos('.')
   exe ":silent normal g\<c-g>"
   let stat = v:statusmsg
   let s:word_count = 0
   let s:wordc_pos = 0
   if stat !=# '--No lines in buffer--'
     let s:wordc_pos = index(split(v:statusmsg),'Word')
     if s:wordc_pos != -1 " Not in visual mode
         let s:word_count = str2nr(split(v:statusmsg)[s:wordc_pos+3])
     else                 " In visual mode
         let s:wordc_pos = index(split(v:statusmsg),'Words;')
         let s:word_count = str2nr(split(v:statusmsg)[s:wordc_pos-3])
     let v:statusmsg = s:old_status
     end
       call setpos('.', position)
       return s:word_count
   else
       call setpos('.', position)
       return 'NA'
   end
endfunction
function! s:TexWordCount()
  if &filetype ==? 'tex'
    let s:TEXcount = split(system
                \('TEXcount -nc -0 -sum -inc ' . expand('%')),'\n')[1]
    return s:TEXcount
  else
    return <sid>WordCount()
  end
endfunction
command! WC echom <sid>TexWordCount()

