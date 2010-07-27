" fold java code.
" need ftpplugin/python_fold.vim
" @see http://amix.dk/blog/viewEntry/19132
" @see http://vim.sourceforge.net/scripts/script.php?script_id=515
" @see http://amix.dk/vim/vimrc.html


function! Folding()
    setl foldmethod=syntax
"    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
    let b:Start=substitute(substitute(getline(v:foldstart),'\t','    ','g'),'{.*','{','')
    let b:End=substitute(substitute(getline(v:foldend),'\t','    ','g'),'.*}','}','')
    let b:lines=(v:foldend-v:foldstart+1)
    if &diff
        let b:Start=b:Start.' ... '
        let b:End=''
    elseif match(b:Start, "^ */\\*\\*")==0 && match(b:End, "\\*/")>=0
        if match(substitute(b:Start,'/\*\*','',''), '^ *$')>=0 && b:lines>2
            let b:Start=substitute(getline(v:foldstart),'\t',repeat(' ',&sw),'g').substitute(getline(v:foldstart+1), '^\s*\*', '', '').' ... '
            if match(substitute(getline(v:foldstart+1),'^\s*\*','',''), '^ *$')>=0 && b:lines>3
                let b:Start=substitute(getline(v:foldstart),'\t',repeat(' ',&sw),'g').substitute(getline(v:foldstart+2), '^\s*\*', '', '').' ... '
            endif
        else
            let b:Start=b:Start.' ... '
        endif
    elseif match(b:Start, "^ */\\*")==0 && match(b:End, "\\*/")>=0
        if match(substitute(b:Start,'/\*','',''), '^ *$')>=0
            let b:Start=substitute(getline(v:foldstart),'\t',repeat(' ',&sw),'g').substitute(getline(v:foldstart+1), '^\s*\*', '', '').' ... '
            if match(substitute(getline(v:foldstart+1),'^\s*\*','',''), '^ *$')>=0
                let b:Start=substitute(getline(v:foldstart),'\t',repeat(' ',&sw),'g').substitute(getline(v:foldstart+2), '^\s*\*', '', '').' ... '
            endif
        else
            let b:Start=b:Start.' ... '
        endif
    elseif match(b:Start, "^ *\\/\\/")==0 && match(b:End, "^ *\\/\\/")>=0
        if match(substitute(b:Start,'\/\/','',''), '^ *$')>=0
            let b:Start=substitute(getline(v:foldstart),'\t',repeat(' ',&sw),'g').substitute(getline(v:foldstart+1), '^\s*\/\/', '', '').' ... '
            if match(substitute(getline(v:foldstart+1),'^\s*\/\/','',''), '^ *$')>=0
                let b:Start=substitute(getline(v:foldstart),'\t',repeat(' ',&sw),'g').substitute(getline(v:foldstart+2), '^\s*\/\/', '', '').' ... '
            endif
        else
            let b:Start=b:Start.' ... '
        endif
        let b:End=''
    elseif match(b:Start, "^ *import ")==0
        let b:Start=b:Start.' ...'
        let b:End=''
    else
        let b:Start=b:Start.'...'
    endif
    return b:Start.b:End.repeat(' ',&columns-strlen(b:Start.b:End.b:lines)-16).'['.b:lines.' lines]'
    endfunction
    setl foldtext=FoldText()
endfunction

"au FileType javascript call Folding()
"au FileType javascript setl fen
au BufNewFile,BufRead,BufEnter *.java call Folding()
au BufNewFile,BufRead,BufEnter *.java setl fen
