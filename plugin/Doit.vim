" Plugin: Doit.vim
" Description: Vim plugin for Doit.im
" Author: 闲耘™(hotoo.cn[AT]gmail.com)
" Version: 2011/2/26

if exists("loaded_doit_im")
    finish
endif
let loaded_doit_im = 1

function! s:DoitGetTasks()
    if !executable("curl")
        echohl WarningMsg
        echo "Doit.vim require 'curl' command."
        echohl None
        return
    endif

    if !exists("g:doit_access_token")
        echohl WarningMsg
        echo "Doit.vim require g:doit_access_token."
        echohl None
        return
    endif

    let oldshellredir=&shellredir
    setlocal shellredir=>
    let text = system('curl https://openapi.doit.im/v1/tasks -H "Authorization: OAuth ' . g:doit_access_token . '"')
    " remove header information.

    let &shellredir=oldshellredir
    let text = iconv(text, "utf-8", &encoding)
    let text = substitute(text, '\\u\(\x\x\x\x\)', '\=s:nr2enc_char("0x".submatch(1))', 'g')
    let [null,true,false] = [0,1,0]
    let obj = eval(text)
    let tasks = obj.entries

    let bufname = '[Doit.im]'
    let winnr = bufwinnr(bufname)
    if winnr < 1
      silent execute 'below 10new '.escape(bufname, ' ')
      nmap <buffer> q :<c-g><c-u>bw!<cr>
      vmap <buffer> q :<c-g><c-u>bw!<cr>
    else
      if winnr != winnr()
	execute winnr.'wincmd w'
      endif
    endif
    setlocal buftype=nofile bufhidden=hide noswapfile wrap ft=doit
    "setlocal nomodified
    setlocal conceallevel=3
    for task in tasks
        let tags = ""
        if len(task.tags) > 0
            let tags = " #" . join(task.tags, ", #")
        endif
        call append(line('$'), "* [ ] " . task.title . tags . " |T:" . task.created . "| #ID:" . task.id . "#")
    endfor
    return
endfunction
function! s:nr2byte(nr)
  if a:nr < 0x80
    return nr2char(a:nr)
  elseif a:nr < 0x800
    return nr2char(a:nr/64+192).nr2char(a:nr%64+128)
  else
    return nr2char(a:nr/4096%16+224).nr2char(a:nr/64%64+128).nr2char(a:nr%64+128)
  endif
endfunction

function! s:nr2enc_char(charcode)
  if &encoding == 'utf-8'
    return nr2char(a:charcode)
  endif
  let char = s:nr2byte(a:charcode)
  if strlen(char) > 1
    let char = strtrans(iconv(char, 'utf-8', &encoding))
  endif
  return char
endfunction

" @see http://vim.g.hatena.ne.jp/eclipse-a/20080707/1215395816
function! s:char2hex(c)
  if a:c =~# '^[:cntrl:]$' | return '' | endif
  let r = ''
  for i in range(strlen(a:c))
    let r .= printf('%%%02X', char2nr(a:c[i]))
  endfor
  return r
endfunction
function! s:encodeURI(s)
  return substitute(a:s, '[^0-9A-Za-z-._~!''()*#$&+,/:;=?@]',
        \ '\=s:char2hex(submatch(0))', 'g')
endfunction
function! s:encodeURIComponent(s)
  return substitute(a:s, '[^0-9A-Za-z-._~!''()*]',
        \ '\=s:char2hex(submatch(0))', 'g')
endfunction

command! -nargs=0 Doit call <SID>DoitGetTasks()
