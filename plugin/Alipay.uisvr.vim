" File: Alipay.uisvr.vim
" Desption: uisvr 1.5 support for alipay sofaMVC.
" @usage :Uisvr
"        :Uisvr css
"        :Uisvr js split
" TODO:  :Uisvr vm
" TODO:  :Uisvr xml -> config.xml
" FIXME: 远程挂载的目录，打开 uisvr 时有问题。
" TODO: 已经打开的文件，不再新建窗口。
" TODO: screen 下目录还是子目录时，对应的 uisvr 目录结构。
" TODO: 老版 uisvr 支持(maybe)。
" Author: 闲耘™(hotoo.cn[AT]gmail.com)
" Last Change: 2011/04/29

if exists('loaded_alipay_uisvr')
    finish
endif
let loaded_alipay_uisvr=1

" default alipay uisvr path.
if !exists('g:alipay_uisvr_path')
    let g:alipay_uisvr_path = ''
endif

let s:sp = "/"
if g:OS#win && exists("+shellslash") && !(&shellslash)
    let s:sp = "\\\\"
endif

" @param {String} filetype in [js, css, vm, xml]
" @param {String} open buffer type, like [new, vsp, sp, tabnew, ...]
function! s:uisvr(...)
    let ft = expand("%:e")
    let fname = expand("%:r")
    let fpath = expand("%:p")
    let fdir = expand("%:p:h")

    if a:0 == 0
        let uisvrType = "js"
        let win = "new"
    elseif a:0 == 1
        let uisvrType = a:1
        let win = "new"
    else
        let uisvrType = a:1
        let win = a:2
    endif

    if ft=="css" || ft=="js"
        let path = s:uisvr#cssjs(fpath, uisvrType)
    elseif ft=="xml"
        let path = s:uisvr#xml(fpath, uisvrType)
    elseif ft=="vm"
        let path = s:uisvr_vm(fpath, uisvrType)
    else
        return
    endif

    exec win . " " . path
    "if filereadable(uisvr)
    "endif
endfunction

function! s:uisvr#root(path)
    return uisvrDir
endfunction

" Get velocity file path.
function! s:uisvr_vm(fpath, uisvrType)
    let src_filename = expand("%:r")
    let src_dir = expand("%:p:h")
    let src_path = expand("%:p")
    let uisvrDir = finddir('uisvr', expand('%:p:h').';')
    let car = substitute(src_dir, '^.*'.s:sp.'htdocs'.s:sp.'templates'.s:sp.'\([a-zA-Z0-9]\+\)'.s:sp.'screen', '\1', "")
    let uisvrDir = fnamemodify(uisvrDir, ":p")
    let path = uisvrDir . s:sp . car . s:sp . src_filename . "." . a:uisvrType
    return path
endfunction

" Get css/javascript file path.
function! s:uisvr#cssjs(path, ft)
    let src_filename = expand("%:r")
    let src_dir = expand("%:p:h")
    let src_path = expand("%:p")
    let uisvrDir = finddir('uisvr', expand('%:p:h').';')
    let car = substitute(src_dir, '^.*'.s:sp.'htdocs'.s:sp.'templates'.s:sp.'\([a-zA-Z0-9]\+\)'.s:sp.'screen', '\1', "")
    let uisvrDir = fnamemodify(uisvrDir, ":p")
    let path = uisvrDir . s:sp . car . s:sp . src_filename . "." . uisvrType
    return path
endfunction

" Get config.xml file path.
function! s:uisvr#xml()
endfunction

command -nargs=* Uisvr call <SID>uisvr(<f-args>)
command -nargs=* UISvr call <SID>uisvr(<f-args>)
command -nargs=* UISVR call <SID>uisvr(<f-args>)

" htdocs
"   +-- htdocs
"   +-- templates
"   |    +-- car0
"   |    |    +-- layout
"   |    |    +-- message
"   |    |    +-- screen
"   |    |    |    `-- index.vm
"   |    |    `-- tile
"   |    `-- car1
"   |         +-- layout
"   |         +-- message
"   |         +-- screen
"   |         |    `-- index.vm
"   |         `-- tile
"   `-- uisvr
"        +-- config
"        |    +-- config.xml
"        |    +-- css.vm
"        |    `-- js.vm
"        +-- car0
"        |    +-- index.css
"        |    `-- index.js
"        +-- car1
"        |    +-- index.css
"        |    `-- index.js
"        `-- theme
"             +-- car0
"             |    +-- foot.vm
"             |    `-- head.vm
"             `-- car1
"                  +-- foot.vm
"                  `-- head.vm
