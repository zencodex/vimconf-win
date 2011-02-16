" textile.vim
"
" Tim Harper (tim.theenchanter.com)

command! -nargs=0 TextileRenderFile call TextileRenderBufferToFile()
command! -nargs=0 TextileRenderTab call TextileRenderBufferToTab()
command! -nargs=0 TextilePreview call TextileRenderBufferToPreview()
noremap <buffer> <Leader>rp :TextilePreview<CR>
noremap <buffer> <Leader>rf :TextileRenderFile<CR>
noremap <buffer> <Leader>rt :TextileRenderTab<CR>
setlocal ignorecase
setlocal wrap
setlocal lbr
inoremap <buffer> <expr> <cr> <SID>TextileNewLine()
nnoremap <buffer> o :call <SID>TextileOo('o')<CR>a
nnoremap <buffer> O :call <SID>TextileOo('O')<CR>a

let s:re_list = '^\s*\(\*\|#\|[ivxdIVXD]\+\.\|>\)\s\+'
let s:re_order_number_list = '^\s*\(\d\+\.\)\s\+'

function! s:TextileNewLine()
    let cr = "\<cr>"
    if 0 == pumvisible()
        let line = getline(".")
        if(line =~ s:re_order_number_list)
            let m = matchstr(line, s:re_order_number_list)
            let n = str2nr(m) + 1
            let cr .= substitute(m, '\d\+', n, "")

            "let lineNum = line(".") + 1
            "let line = getline(lineNum)
            "let n = n+1
            "while line =~ s:re_order_number_list
                " 不允许在此处使用。
                "call setline(lineNum, substitute(line, '\d\+', n, ""))
                "let lineNum = lineNum + 1
                "let line = getline(lineNum)
                "let n = n+1
            "endw
        else
            let cr .= matchstr(getline("."), s:re_list)
        endif
    endif
    return cr
endfunction
function! s:TextileOo(cmd) "{{{
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

  let res = ''
  if line =~ s:re_order_number_list
    let m = matchstr(line, s:re_order_number_list)
    let res = substitute(m, '\s*$', ' ', '')
  elseif line =~ s:re_list
    let m = matchstr(line, s:re_list)
    let res = substitute(m, '\s*$', ' ', '')
  elseif &autoindent || &smartindent
    let res = matchstr(line, '^\s*')
  endif
  if a:cmd ==# 'o'
    if(line =~ s:re_order_number_list)
      let m = matchstr(line, s:re_order_number_list)
      let n = str2nr(m) + 1
      let res = substitute(m, '\d\+', n, "")

      let lineNum = line(".") + 1
      let line = getline(lineNum)
      let n = n+1
      while line =~ s:re_order_number_list
        call setline(lineNum, substitute(line, '\d\+', n, ""))
        let lineNum = lineNum + 1
        let line = getline(lineNum)
        let n = n+1
      endw
    endif
    call append(lnum, res)
    call cursor(lnum + 1, col('$'))
  else
    if(line =~ s:re_order_number_list)
      let m = matchstr(line, s:re_order_number_list)
      let n = str2nr(m) + 1
      let lineNum = line(".")
      let line = getline(lineNum)
      while line =~ s:re_order_number_list
        call setline(lineNum, substitute(line, '\d\+', n, ""))
        let lineNum = lineNum + 1
        let line = getline(lineNum)
        let n = n+1
      endw
    endif
    call append(lnum - 1, res)
    call cursor(lnum, col('$'))
  endif
endfunction "}}}


function! TextileRender(lines)
  if (system('which ruby') == "")
    throw "Could not find ruby!"
  end

  let text = join(a:lines, "\n")
  let html = system("ruby -e \"def e(msg); puts msg; exit 1; end; begin; require 'rubygems'; rescue LoadError; e('rubygems not found'); end; begin; require 'redcloth'; rescue LoadError; e('RedCloth gem not installed.  Run this from the terminal: sudo gem install RedCloth'); end; puts(RedCloth.new(\\$stdin.read).to_html(:textile))\"", text)
  return html
endfunction

function! TextileRenderFile(lines, filename)
  let html = TextileRender(getbufline(bufname("%"), 1, '$'))
  let html = "<html><head><title>" . bufname("%") . "</title><body>\n" . html . "\n</body></html>"
  return writefile(split(html, "\n"), a:filename)
endfunction

function! TextileRenderBufferToPreview()
  let filename = "/tmp/textile-preview.html"
  call TextileRenderFile(getbufline(bufname("%"), 1, '$'), filename)

  " Modify this line to make it compatible on other platforms
  call system("open -a Safari ". filename)
endfunction

function! TextileRenderBufferToFile()
  let filename = input("Filename:", substitute(bufname("%"), "textile$", "html", ""), "file")
  call TextileRenderFile(getbufline(bufname("%"), 1, '$'), filename)
  echo "Rendered to '" . filename . "'"
endfunction

function! TextileRenderBufferToTab()
  let html = TextileRender(getbufline(bufname("%"), 1, '$'))
  tabnew
  call append("^", split(html, "\n"))
  set syntax=html
endfunction
