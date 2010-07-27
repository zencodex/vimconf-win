" File:         ClosureCompiler.vim
" Author:       闲耘™(hotoo.cn[AT]gmail.com)
" Link:         https://dl.dropbox.com/u/1151037/index.html
" Version:      2010/05/15
" Description:  调用 Google Closure Compiler 压缩 Javascript 代码。
" See:          http://code.google.com/closure/compiler/

if exists("loaded_closure_compiler")
    finish
endif
let loaded_closure_compiler = 1

if !exists("closure_compiler_command")
    let closure_compiler_command = 'java -jar compiler.jar'
endif

" set up auto commands
au FileType javascript nnoremap <silent> <leader>gcc :call ClosureCompiler()<cr>

function ClosureCompiler()
    let current_file = shellescape(expand('%:p'))
    let current_file_withoutEx = shellescape(expand('%:r'))
    let current_file_Ex = shellescape(expand('%:e'))
    let gcc = g:closure_compiler_command . ' ' . ' --js ' . current_file . ' --js_output_file ' . current_file_withoutEx . '.min.' . current_file_Ex
    if has("win32") && v:lang == 'zh_CN.utf-8'
        let gcc = iconv(gcc, 'utf-8', 'gbk')
    endif
    let cmd_output = system(gcc)
    if has("win32") && v:lang == 'zh_CN.utf-8'
        let cmd_output = iconv(cmd_output, 'gbk', 'utf-8')
    endif

    " if some result were found, we echo them
    if strlen(cmd_output) > 0
        echo cmd_output
    else
        echo 'Comporessed.'
        "echoerr current_file . 'NOT Comporessed'
    endif
endfunction
