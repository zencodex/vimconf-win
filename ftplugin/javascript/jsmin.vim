if exists('g:jsmin_loaded')
    finish
endif
let g:jsmin_loaded=1


nmap <buffer> <silent> <F10> :!start jsmin.bat %:p %:p:r.min.%:p:e<cr><cr>
