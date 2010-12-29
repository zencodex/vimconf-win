
function! TidyHTML()
    setlocal makeprg=tidy\ -quiet\ -errors\ %
    setlocal errorformat=line\ %l\ column\ %v\ -\ %m

    make
    cw
endfunction


nmap <buffer> <F10> :call TidyHTML()<cr>
"nmap <buffer> <F1> :!tidy -mi -xml -utf8 %:p<cr><cr><cr>


function! Save2Temp()
    if &ft!="xhtml" && &ft!="html"
        echoerr "Not support filetype:".&ft
        return
    endif
    if(expand("%")=="")
        if(has("gui_win32"))
            let b:sp="\\"
            let b:fn=strftime("%y%m%d%H%M%S")
            let b:ft=(&ft=="xhtml" ? ".html" : ".htm")
            exe "write ".$tmp.b:sp."non".b:fn.b:ft
        endif
    else
        write
    endif
endfunction

" preview current page in default browser or firefix.
nmap <buffer> <F5> :call Save2Temp()<cr><cr>:!start RunDll32.exe shell32.dll,ShellExec_RunDLL %:p<cr>
nmap <buffer> <C-F5> :call Save2Temp()<cr><cr>:!start "C:\Program Files\Mozilla Firefox\firefox.exe" -P debug %<cr>
