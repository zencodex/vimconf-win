" use csstidy minify css source.
" @author 闲耘™ (@hotoo hotoo.cn[AT]gmail.com)
" @version 2009/12/07
if exists('g:loaded_csstidy_minify')
    finish
endif
let g:loaded_csstidy_minify = 1

function MinifyCSS()
    let name = expand("%:t:r")
    let len = strlen(name)
    let ext = expand("%:e")
    if(strridx(name, ".source") == len-7)
        let target = strpart(name, 0, len-7)
    elseif(strridx(name, ".src") == len-4)
        let target = strpart(name, 0, len-4)
    else
        let target = name . ".min"
    endif
    let target = target . "." . ext
    " All file.css minify to file.min.css
    "setlocal makeprg=csstidy\ %:p\ --preserve_css=false\ --remove_bslash=false\ --compress_color=true\ --lowercase_s=false\ --timestamp=false\ --optimise_shorthands=0\ --remove_last_;=true\ --sort_selectors=false\ --merge_selectors=0\ --compress_font-weight=false\ --allow_html_in_template=false\ --silent=false\ --case_properties=0\ --template=highest\ %:p:r.min.%:p:e

    " file.source.css and file.src.css minify to file.css,
    " file.css minify to file.min.css
    "exec "setlocal makeprg=csstidy\\\ %:p\\\ --preserve_css=false\\\ --remove_bslash=false\\\ --compress_color=true\\\ --lowercase_s=false\\\ --timestamp=false\\\ --optimise_shorthands=0\\\ --remove_last_;=true\\\ --sort_selectors=false\\\ --merge_selectors=0\\\ --compress_font-weight=false\\\ --allow_html_in_template=false\\\ --silent=false\\\ --case_properties=0\\\ --template=highest\\\ " . target
    let &l:makeprg='csstidy %:p --preserve_css=false --remove_bslash=false --compress_color=true --lowercase_s=false --timestamp=false --optimise_shorthands=0 --remove_last_;=true --sort_selectors=false --merge_selectors=0 --compress_font-weight=false --allow_html_in_template=false --silent=false --case_properties=0 --template=highest "'.target.'"'
    setlocal errorformat=%l:%m

    make
    cw
endfunction

command -nargs=0 Tidy :silent! call MinifyCSS()
nmap <F10> :call MinifyCSS()<cr><cr>
