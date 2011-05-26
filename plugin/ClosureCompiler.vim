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
    let g:closure_compiler_command = 'compiler.jar'
endif

function ClosureCompiler()
    if !executable("java") || !executable(g:closure_compiler_command)
        echohl WarningMsg
        echo "required command: java and " . g:closure_compiler_command
        echohl None
        return
    endif
    let path = expand('%:p')
    let path_noExt = expand('%:p:r')
    let ext = expand('%:e')
    let re = '[\._\-]\(src\|source\)$'
    let target = shellescape(substitute(path_noExt, re, "", "") . ".min." . ext)
    if filereadable(target) && !filewritable(target)
        echohl WarningMsg
        echo target . " is not writable."
        echohl None
        return
    endif
    let gcc = 'java -jar ' . g:closure_compiler_command . ' ' . ' --js ' . shellescape(path) . ' --js_output_file ' . target
    if has("win32") && v:lang == 'zh_CN.utf-8'
        let gcc = iconv(gcc, 'utf-8', 'gbk')
    endif
    let cmd_output = system(gcc)
    if has("win32") && v:lang == 'zh_CN.utf-8'
        let cmd_output = iconv(cmd_output, 'gbk', 'utf-8')
    endif

    " clean quickfix window.
    call setqflist([], 'r')
    cclose

    " if some result were found, we echo them
    if strlen(cmd_output) > 0
        if has("win32")
            let re = '\(\w:[^:]\+\):\(\d\+\):\s\+\(ERROR\|WARNING\|INFO\)\s\+-\s\+\(.*\)'
        else
            let re = '\([^:]\+\):\(\d\+\):\s\+\(ERROR\|WARNING\|INFO\)\s\+-\s\+\(.*\)'
        endif
        let caret = '^\(\s*\^\)$'
        let lines = split(cmd_output, '\n')
        if len(lines) <= 1
            echo cmd_output
        else
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
"autocmd FileWritePost,BufWritePost *.js :call ClosureCompiler()
au FileType javascript command! -nargs=0 Compiler :call ClosureCompiler()
