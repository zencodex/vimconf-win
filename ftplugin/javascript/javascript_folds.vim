" fold javascript function code.
" need ftpplugin/python_fold.vim
" @see http://amix.dk/blog/viewEntry/19132
" @see http://vim.sourceforge.net/scripts/script.php?script_id=515
" @see http://amix.dk/vim/vimrc.html

"if exists('g:javascript_folding')
    "finish
"endif
"let g:javascript_folding=1

function! JavaScriptFolding()
    setl foldmethod=syntax
"    setl foldlevelstart=1

    function! FoldText()
    if &diff
        let b:Start=getline(v:foldstart).' ... '
        let b:End=getline(v:foldend)
    else
        let b:Start=substitute(substitute(getline(v:foldstart),'\t','    ','g'),'{.*','{...','')
        let b:End=substitute(substitute(getline(v:foldend),'\t','    ','g'),'.*}','}','')
    endif
    let b:lines='['.(v:foldend-v:foldstart).' lines]'
    return b:Start . b:End . repeat(' ',&columns-strlen(b:Start.b:End.b:lines)-8) . b:lines
    endfunction
    setl foldtext=FoldText()
endfunction

"call JavaScriptFolding()
"setl fen
au BufNewFile,BufRead,BufEnter *.js call JavaScriptFolding()
au BufNewFile,BufRead,BufEnter *.js setl fen
