" textile.vim
"
" Tim Harper (tim.theenchanter.com)

setlocal ignorecase
setlocal wrap
setlocal lbr
inoremap <buffer> <expr> <cr> <SID>MarkdownNewLine()
nnoremap <buffer> o :call <SID>MarkdownOo('o')<CR>a
nnoremap <buffer> O :call <SID>MarkdownOo('O')<CR>a
noremap <silent><buffer> = :call <SID>AddHeaderLevel()<CR>
noremap <silent><buffer> - :call <SID>RemoveHeaderLevel()<CR>

let s:re_list = '^\s*\(\*\|\d\.\|[ivxdIVXD]\+\.\|>\)\s\+'

function! s:MarkdownNewLine()
    let cr = "\<cr>"
    if 0 == pumvisible()
        let cr .= matchstr(getline("."), s:re_list)
    endif
    return cr
endfunction
function! s:MarkdownOo(cmd) "{{{
  " cmd should be 'o' or 'O'

  let beg_lnum = foldclosed('.')
  let end_lnum = foldclosedend('.')
  if end_lnum != -1 && a:cmd ==# 'o'
    let lnum = end_lnum
    let line = getline(beg_lnum)
  else
    let line = getline('.')
    let lnum = line('.')
  endif

  let m = matchstr(line, s:re_list)
  let res = ''
  if line =~ s:re_list
    let res = substitute(m, '\s*$', ' ', '')
  elseif &autoindent || &smartindent
    let res = matchstr(line, '^\s*')
  endif
  if a:cmd ==# 'o'
    call append(lnum, res)
    call cursor(lnum + 1, col('$'))
  else
    call append(lnum - 1, res)
    call cursor(lnum, col('$'))
  endif
endfunction "}}}

" get header level.
function! s:headerLevel(line)
    return len(matchstr(a:line, '^#\+'))
endfunction
function! s:AddHeaderLevel()
  let lnum = line('.')
  let line = getline(lnum)

  if line =~ '^\s*$'
    return
  endif

    let level = s:headerLevel(line)
    if level == 0
        call setline(lnum, '# '.line)
    elseif level < 6
        call setline(lnum, '#'.line)
    endif
endfunction
function! s:RemoveHeaderLevel()
  let lnum = line('.')
  let line = getline(lnum)

  if line =~ '^\s*$'
    return
  endif

    let level = s:headerLevel(line)
    if level == 1
        let line = substitute(line, '^#\s\+', '', '')
        call setline(lnum, line)
    elseif level <= 6
        let line = substitute(line, '^#', '', '')
        call setline(lnum, line)
    endif
endfunction
