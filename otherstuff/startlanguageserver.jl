# Originally from:
# https://discourse.julialang.org/t/use-languageserver-jl-on-vim-8-1-with-vim-lsp-plugin/20601
import LanguageServer
import Pkg
import SymbolServer

envpath = dirname(Pkg.Types.Context().env.project_file)

const DEPOT_DIR_NAME = ".julia"
depotpath = if Sys.iswindows()
    joinpath(ENV["USERPROFILE"], DEPOT_DIR_NAME)
else
    joinpath(ENV["HOME"], DEPOT_DIR_NAME)
end

################################################################################
# Original, should work in 1.1.0
# server = LanguageServer.LanguageServerInstance(stdin, stdout, false, envpath, depotpath, Dict())

# Working in 1.0.3
server = LanguageServer.LanguageServerInstance(stdin, stdout, false)
################################################################################

server.runlinter = true
run(server)


############################# In vim, need to add: #############################
#=
let s:julia_exe = 'julia'
let s:julia_lsp_startscript = 'C:/Users/Pietr/vimfiles/otherstuff/startlanguageserver.jl'
if executable('julia')
    augroup VIM_LSP
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'julia',
    \ 'cmd': {server_info->[s:julia_exe, '--startup-file=no', '--history-file=no', s:julia_lsp_startscript]},
    \ 'whitelist': ['julia'],
    \ })
    augroup END
endif
=#
