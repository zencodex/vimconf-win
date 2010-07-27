" cmdhere plugin for NERDTree.
" put this in $VIM/vimfiles/nerdtree_plugin/cmdhere.vim
" @author 闲耘™ (hotoo.cn[AT]gmail.com)
" @version 1.0 2010/07/20

if exists("g:loaded_nerdtree_cmdhere")
    finish
endif
let g:loaded_nerdtree_cmdhere = 1

function! NERDTreeCmdhere()
    let node = g:NERDTreeFileNode.GetSelected()

    if executable("chcp")
        let code_page = 'cp' . matchstr(system("chcp"), "\\d\\+")
    else
        " If chcp doesn't work, set its value manually here.
        let code_page = 'cp936'
    endif
    if has('win32') && !has('win32unix') && (&enc!=code_page)
        let path = iconv(node.path.str({'escape':1}), &enc, code_page)
    endif

    if has('win32')
        if node.path.isDirectory
            exec ":!start cmd /c cmd /k pushd " . path
        else
            exec ":!start cmd /c cmd /k pushd " . path . "\\.."
        endif
    endif
endfunction

autocmd filetype nerdtree command! -nargs=0 -buffer Cmd :call NERDTreeCmdhere()
autocmd filetype nerdtree command! -nargs=0 -buffer Cmdhere :call NERDTreeCmdhere()
