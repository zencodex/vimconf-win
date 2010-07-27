" open fiel in system file explorer plugin for NERDTree.
" put this in $VIM/vimfiles/nerdtree_plugin/explorer.vim
" @author 闲耘™ (hotoo.cn[AT]gmail.com)
" @version 1.0 2010/07/20

if exists("g:loaded_nerdtree_fileexplorer")
    finish
endif
let g:loaded_nerdtree_fileexplorer = 1

"function! NERDTreeExplorer()
    "let node = g:NERDTreeFileNode.GetSelected()

    "if executable("chcp")
        "let code_page = 'cp' . matchstr(system("chcp"), "\\d\\+")
    "else
        "" If chcp doesn't work, set its value manually here.
        "let code_page = 'cp936'
    "endif
    "if has('win32') && !has('win32unix') && (&enc!=code_page)
        "let path = iconv(node.path.str({'escape':1}), &enc, code_page)
    "endif

    "if has('win32')
        "exec ":!start explorer /select, " . path
        "" Open Explorer Tree.
        ""exec ":!start explorer /e,/select, " . node.path.str({'escape':1})
    "endif
"endfunction

"autocmd filetype nerdtree nmap <buffer> <F6> :call NERDTreeExplorer()<cr>
"autocmd filetype nerdtree command! -nargs=0 -buffer Explor :call NERDTreeExplorer()
"autocmd filetype nerdtree command! -nargs=0 -buffer Explorer :call NERDTreeExplorer()

autocmd filetype nerdtree nmap <buffer> <F6> :call FileExplorer(g:NERDTreeFileNode.GetSelected().path.str({'escape':1}))<cr>
autocmd filetype nerdtree command! -nargs=0 -buffer Explor :call FileExplorer(g:NERDTreeFileNode.GetSelected().path.str({'escape':1}))
autocmd filetype nerdtree command! -nargs=0 -buffer Explorer :call FileExplorer(g:NERDTreeFileNode.GetSelected().path.str({'escape':1}))
