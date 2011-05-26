" File:         ClosureCompiler.vim
" Author:       闲耘™(hotoo.cn[AT]gmail.com)
" Link:         http://hotoo.me/
" Version:      2.0, 2011/05/26
" Description:  Google Closure Compiler for Vim.
" See:          http://code.google.com/closure/compiler/

if exists("loaded_closure_compiler")
    finish
endif
let loaded_closure_compiler = 1

if !exists("g:closure_compiler_command")
    let g:closure_compiler_command = 'java -jar compiler.jar'
endif

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
        if has("win32")
            let re = '\(\w:[^:]\+\):\(\d\+\):\s\+\(ERROR\|WARNING\|INFO\)\s\+-\s\+\(.*\)'
        else
            let re = '\([^:]\+\):\(\d\+\):\s\+\(ERROR\|WARNING\|INFO\)\s\+-\s\+\(.*\)'
        endif
        let caret = '^\(\s*\^\)$'
        let lines = split(cmd_output, '\n')
        echo len(lines)
        if len(lines) <= 1
            echo cmd_output
        else
            call setqflist([], 'r')
            for line in lines
                let m = matchlist(line, re)
                let c = matchlist(line, caret)
                if len(m) > 0
                    let file = m[1]
                    let ln = m[2]
                    if m[3] == "ERROR"
                        let type = "E"
                    elseif m[3] == "WARNING"
                        let type = "W"
                    endif
                    let text = m[4]
                elseif len(c) > 0
                    let cl = strlen(c[1])
                    call setqflist([{"filename":file, "lnum":ln, "col":cl, "type":type, "text":text}], "a")
                endif
            endfor
            cw
        endif
    else
        echo 'Comporessed.'
    endif
endfunction

" set up auto commands
"au FileType javascript nnoremap <silent> <leader>gcc :call ClosureCompiler()<cr>
au FileType javascript command -nargs=0 Compiler :call ClosureCompiler()
