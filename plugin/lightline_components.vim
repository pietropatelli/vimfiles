scriptencoding utf-8
"................... Indicator for specific plugins running ....................
function! LightlineRunningplugins()
    let s:running = ''
    let s:running = g:ale_enabled!=0 ?  s:running.'ALE ' : s:running
    let s:running = g:gitgutter_enabled!=0 ?  s:running.'GG ' : s:running
    let s:running = g:vimlsp_enabled!=0 ?  s:running.'LSP' : s:running
    return ( exists('b:NERDTree') && b:NERDTree.isTabTree() ) ? '' : s:running
endfunction

"..................... Functions for collapsible elements ......................
function! AvailableSpace(...)
    let s:name = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
    let s:filetype = &filetype !=# '' ? &filetype : 'no ft'
    if a:0 != 1
        return winwidth(0) - len(LightlineRunningplugins()) - len(s:name) -len(fugitive#head()) - len(s:filetype)
    else
        return winwidth(0) - len(LightlineRunningplugins()) - len(s:name) -len(fugitive#head())
    endif
endfunction

function! s:AvailableSpace(...)
    let s:name = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
    let s:filetype = &filetype !=# '' ? &filetype : 'no ft'
    if a:0 != 1
        return winwidth(0) - len(LightlineRunningplugins()) - len(s:name) -len(fugitive#head()) - len(s:filetype)
    else
        return winwidth(0) - len(LightlineRunningplugins()) - len(s:name) -len(fugitive#head())
    endif
endfunction

function! LightlineFileformat()
    return s:AvailableSpace() > 57? &fileformat : ''
endfunction

function! LightlineFileencoding()
    return s:AvailableSpace() > 57? &fileencoding : ''
endfunction

function! LightlineFiletype()
    return s:AvailableSpace() > 42? (&filetype !=# ''? &filetype:'no ft') : ''
endfunction

function! LightlineGitbranch()
    if s:AvailableSpace(1) > 38
        return (exists('b:NERDTree')&& b:NERDTree.isTabTree())?'': fugitive#head()
    else
        return ''
    endif
endfunction

function! LightlineReadonly()
    if s:AvailableSpace(1) > 10
        return (exists('b:NERDTree')&&b:NERDTree.isTabTree())?'': (&readonly?'RO':'')
    else
        return ''
    endif
endfunction

function! LightlineMode()
    if s:AvailableSpace() > 62
        return (exists('b:NERDTree')&& b:NERDTree.isTabTree())?'': lightline#mode()
    elseif s:AvailableSpace(1) > 22
        return (exists('b:NERDTree')&& b:NERDTree.isTabTree())?'': strcharpart(lightline#mode(),0,1)
    else
        return ''
endif
endfunction

function! LightlinePaste()
    if s:AvailableSpace() > 70
        return (exists('b:NERDTree')&& b:NERDTree.isTabTree())?'': (&paste?'PASTE':'')
    else
        return (exists('b:NERDTree')&& b:NERDTree.isTabTree())?'': (&paste?'P':'')
    endif
endfunction

function! LightlineFilename()
    if exists('b:NERDTree') && b:NERDTree.isTabTree()
        return exists('g:NERDTreeStatusline')? expand(g:NERDTreeStatusline) : 'NERDTree'
    elseif &buftype==?'quickfix'
        return '[Quickfix List]'
    else
        return expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
    endif
endfunction

function! LightlineModified()
    return (exists('b:NERDTree')&& b:NERDTree.isTabTree())?'': (&modified ? '+' : '')
endfunction

function! LightlinePercent()
    if s:AvailableSpace(1) > 40
        let byte = line2byte( line( '.' ) ) + col( '.' ) - 1
        let size = (line2byte( line( '$' ) + 1 ) - 1)
        return (exists('b:NERDTree')&& b:NERDTree.isTabTree())?'': printf('%2d%%',(byte * 100) / size)
    else
        return ''
    endif
endfunction

function! LightlineLineinfo()
    if s:AvailableSpace(1) > 15
        return (exists('b:NERDTree')&& b:NERDTree.isTabTree())?'': printf('%3d:%-2d', line('.'), col('.'))
    else
        return ''
    endif
endfunction
