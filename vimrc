"                     {/ ． ．\}
"                     ( (oo)   )
" +-------------oOOo---︶︶︶︶---oOOo-------------+
"                                      _  ___
"                                       \/ _/
"                                      _/ /ian__
"                                     /__/\ \/ /
"                                          \  /
"                                          /_/un
"
"
"                                   闲耘™ (@hotoo)
"                             hotoo.cn[AT]gmail.com
"
" +---------------------------------Oooo-----------+
"
" @see http://vim.wikia.com/wiki/Version_Control_for_Vimfiles
" vim:fdm=marker

set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

" MyDiff {{{
set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" @see http://vim.wikia.com/wiki/Selecting_changes_in_diff_mode
if &diff
    nmap <F7> [c
    nmap <F8> ]c
else
    map <F7> :cp<cr>
    map <F8> :cn<cr>
endif

" }}}

" -------------------------------- Settings ----------------------------- {{{
" quick startup mode.
set shortmess=atI

" encoding
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
"set fileencodings=ucs-bom,utf-8,chinese,latin-1
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set langmenu=zh_CN.utf-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
language messages zh_cn.utf-8


filetype plugin on
filetype indent on
syntax on
filetype on


" FencView.vim
" 自动识别文件编码
" @see http://www.vim.org/scripts/script.php?script_id=1708
let g:fencview_autodetect=1
let g:fencview_auto_patterns='*.txt,*.js,*.css,*.c,*.cpp,*.h,*.java,*.cs,*.htm{l\=}'
let g:fencview_checklines=20
let $FENCVIEW_TELLENC='tellenc'


" 文件格式，默认 ffs=dos,unix
set fileformat=unix
set fileformats=unix,dos,mac


if has('win32')
    " max open window
    au GUIEnter * simalt ~x

    au! bufwritepost hosts !start cmd /C ipconfig /flushdns<cr>
    command -nargs=0 Vimrc :tabnew $VIM/vimrc
    " @see http://practice.chatserve.com/hosts.html
    command -nargs=0 Hosts :tabnew c:\windows\system32\drivers\etc\hosts
else
    command -nargs=0 Vimrc :tabnew ~/.vim/vimrc
    command -nargs=0 Hosts :tabnew /etc/hosts
endif

" set default(normal) window size.
set columns=90
set lines=30

" theme, skin, color
"colo desert
"colo hotoo
"colo ir_desert
"colo manuscript
"colo colorzone
"colo fu
colo hotoo_manuscript
"colo wombat



" @see :help mbyte-IME
if has('multi_byte_ime')
    highlight Cursor guibg=#F0E68C guifg=#708090
    highlight CursorIM guibg=Purple guifg=NONE
endif


" fonts
" @see http://support.microsoft.com/kb/306527/zh-cn
" @see http://www.gracecode.com/archives/1545/
" @see http://blog.xianyun.org/2009/09/14/vim-fonts.html
if has("win32")
    set guifont=Courier_New:h11:cANSI
    "set guifont=Lucida\ Console:h10:cANSI
    "set guifontwide=YouYuan:h11:cGB2312
endif

" auto mkview and loadview.
au BufWinLeave *.js mkview
au BufWinEnter *.js silent loadview
au BufWinLeave *.css mkview
au BufWinEnter *.css silent loadview


" swrap file, auto backup.
set nobackup
set directory=$VIM\tmp

let MRU_File = $VIM.'\_vim_mru_files'


set undofile
set undolevels=1000
set undodir=$VIM\undodir
au BufWritePre undodir/* setlocal noundofile

" 加速光标闪烁。
" @see http://c9s.blogspot.com/2007/12/gvim.html
"set guicursor+=n-v-c:block-cursor-blinkwait300-blinkon90-blinkoff90
"set guicursor+=i:block-cursor-blinkwait200-blinkon110-blinkoff110
"set guicursor+=v:ver90-cursor-blinkwait200-blinkon150-blinkoff150

" Tabs
set softtabstop=4
set expandtab       " replace tab to whitespace.
set tabstop=4       " show tab indent word space.
set shiftwidth=4    " tab length


set linebreak       " break full word.
set autoindent      " new line indent same this line.
set smartindent



" Folds.
set foldmethod=syntax
set foldlevel=6
set foldcolumn=0

set ignorecase
set smartcase
set number
set colorcolumn=80

" 设置宽度不明的文字(如 “”①②→ )为双宽度文本。
" @see http://blog.sina.com.cn/s/blog_46dac66f010006db.html
set ambiwidth=double


" 高亮当前行
" highlight CurrentLine guibg=darkgrey guifg=white
" au! Cursorhold * exe 'match CurrentLine /\%' . line('.') . 'l.*/'
" set ut=100
"
" set cursorcolumn
set cursorline
hi cursorline gui=underline guibg=NONE cterm=underline

set history=500

" Show tab number in your tab line
" @see http://vim.wikia.com/wiki/Show_tab_number_in_your_tab_line
set guitablabel=%N.%t

" auto wrap text.
" NOTE: this setting will change text source.
" set textwidth=80
" set fo+=m
syn match out80 /\%80v./ containedin=ALL
hi out80 guifg=#333333 guibg=#ffffff


" share system clipboard.
"set clipboard+=unnamed

" User Defined Status Line.
" @see http://www.vim.org/scripts/script.php?script_id=8 for VimBuddy.
set laststatus=2
set statusline=%t\ %1*%m%*\ %1*%r%*\ %2*%h%*%w%=\ [%l%3*/%L(%p%%)%*,%v]\ [%b:%B]\ [%{&ft==''?'TEXT':toupper(&ft)},%{toupper(&ff)},%{toupper(&fenc!=''?&fenc:&enc)}%{&bomb?',BOM':''}]
"set statusline=%t\ %1*%m%*\ %1*%r%*\ %2*%h%*%w%=[%{VimBuddy()}]\ [%l%3*/%L(%p%%)%*,%v]\ [%b:%B]\ [%{&ft==''?'TEXT':toupper(&ft)},%{toupper(&ff)},%{toupper(&fenc!=''?&fenc:&enc)}%{&bomb?',BOM':''}]
"let &statusline=' %t %{&mod?(&ro?"*":"+"):(&ro?"=":" ")} %1*|%* %{&ft==""?"any":&ft} %1*|%* %{&ff} %1*|%* %{(&fenc=="")?&enc:&fenc}%{(&bomb?",BOM":"")} %1*|%* %=%1*|%* 0x%B %1*|%* (%l,%c%V) %1*|%* %L %1*|%* %P'
hi User1 guibg=red guifg=yellow
hi User2 guibg=#008000 guifg=white
hi User3 guibg=#C2BFA5 guifg=#999999
"hi User1 cterm=italic ctermfg=blue
"hi User2 cterm=bold


" Set default mode:insert.
"exe "startinsert"

" }}}

" ------------------------------- Mappings ------------------------------ {{{
" Normal Mode, Visual Mode, and Select Mode,
" use <Tab> and <Shift-Tab> to indent
" @see http://c9s.blogspot.com/2007/10/vim-tips.html
"nmap <tab> v>                  " :h ctrl-i :h <tab>
"nmap <s-tab> v<
vmap <tab> >gv
vmap <s-tab> <gv


" 选中一段文字并全文搜索这段文字
vnoremap  *  y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
vnoremap  #  y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

inoremap ( <c-r>=OpenPair('(')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap { <c-r>=OpenPair('{')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
inoremap [ <c-r>=OpenPair('[')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
" just for xml document, but need not for now.
"inoremap < <c-r>=OpenPair('<')<CR>
"inoremap > <c-r>=ClosePair('>')<CR>
function! OpenPair(char)
    let PAIRs = {
                \ '{' : '}',
                \ '[' : ']',
                \ '(' : ')',
                \ '<' : '>'
                \}
    let line = getline('.')
    let oL = len(split(line, a:char, 1))-1
    let cL = len(split(line, PAIRs[a:char], 1))-1

    let txt = strpart(line, col('.')-1)
    let ol = len(split(txt, a:char, 1))-1
    let cl = len(split(txt, PAIRs[a:char], 1))-1

    if oL>=cL || (oL<cL && ol>=cl)
        return a:char . PAIRs[a:char] . "\<Left>"
    else
        return a:char
    endif
endfunction
function! ClosePair(char)
    if getline('.')[col('.')-1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

inoremap ' <c-r>=CompleteQuote("'")<CR>
inoremap " <c-r>=CompleteQuote('"')<CR>
function! CompleteQuote(quote)
    let ql = len(split(getline('.'), a:quote, 1))-1
    " a:quote length is odd.
    if (ql%2)==1
        return a:quote
    elseif getline('.')[col('.') - 1] == a:quote
        return "\<Right>"
    elseif '"'==a:quote && "vim"==&ft && 0==match(strpart(getline('.'), 0, col('.')-1), "^[\t ]*$")
        " for vim comment.
        return a:quote
    elseif "'"==a:quote && 0==match(getline('.')[col('.')-2], "[a-zA-Z0-9]")
        " for Name's Blog.
        return a:quote
    else
        return a:quote . a:quote . "\<Left>"
    endif
endfunction

" <Space> key in normal model.
nmap <Space> i <Esc>l


" Change Assignment(=) Expression.
" @see http://c9s.blogspot.com/2007/09/vim-tip.html
nmap c=r $F=lcf;
nmap c=l $F=c^


" use Meta key(Windows:Alt) to move cursor in insert mode.
" Note: if system install "Lingoes Translator",
"   you will need change/disabled hot key.
noremap! <M-j> <Down>
noremap! <M-k> <Up>
noremap! <M-h> <left>
noremap! <M-l> <Right>

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l
map <C-h> <C-W>h

map <C-kPlus> <C-w>+
map <C-kMinus> <C-w>-
map <C-S-kPlus> <C-w>_
map <C-S-kMinus> <C-w>_


" Windows: Explorer.exe
" Linux:   nautilus $PWD
"          nautilus .
" Mac:     open .
" @see http://www.zhuoqun.net/html/y2010/1516.html
function! FileExplorer(path)
    if a:path == ""
        let p = expand("%:p")
    else
        let p = a:path
    endif
    if has("win32") && exists("+shellslash") && &shellslash
        let p = substitute(p, "/", "\\", "g")
    endif

    if executable("chcp")
        let code_page = 'cp' . matchstr(system("chcp"), "\\d\\+")
    else
        " If chcp doesn't work, set its value manually here.
        let code_page = 'cp936'
    endif
    if has('win32') && !has('win32unix') && (&enc!=code_page)
        let p = iconv(p, &enc, code_page)
    endif

    exec ":!start explorer /select, " . p
    " Open Explorer Tree.
    "exec ":!start explorer /e,/select, " . p
endfunction

if has("win32")
    " Open Windows Explorer and Fouse current file.
    "                                      %:p:h     " Just Fold Name.
    nmap <F6> :call FileExplorer("")<cr>
    imap <F6> <C-o><F6>
    command -nargs=0 Explor :call FileExplorer("")
    command -nargs=0 Explorer :call FileExplorer("")

    " Open command(cmd) window.
    command -nargs=0 Cmd :!start cmd
    command -nargs=0 Cmdhere :!start cmd
endif


" tab navigation & operation like tabs browser
" @see http://vimcdoc.sourceforge.net/doc/tabpage.html
" Note: cannot map <C-number> for gvim on window 7.
imap <C-t> <Esc>:tabnew<cr>
nmap <C-t> :tabnew<cr>
"imap <C-w> <Esc>:tabclose<cr> " window shortcut key.
"nmap <C-w> :tableclose<cr>
"imap <C-S-w> <Esc>:tabonly<cr>
"nmap <C-S-w> :tabonly<cr>
imap <C-tab> :tabnext<cr>
nmap <C-tab> :tabnext<cr>
imap <C-S-tab> :tabprevious<cr>
nmap <C-S-tab> :tabprevious<cr>
imap <M-1> <Esc>:tabfirst<cr>
nmap <M-1> :tabfirst<cr>
imap <M-2> <Esc>2gt
nmap <M-2> 2gt
imap <M-3> <Esc>3gt
nmap <M-3> 3gt
imap <M-4> <Esc>4gt
nmap <M-4> 4gt
imap <M-5> <Esc>5gt
nmap <M-5> 5gt
imap <M-6> <Esc>6gt
nmap <M-6> 6gt
imap <M-7> <Esc>7gt
nmap <M-7> 7gt
imap <M-8> <Esc>8gt
nmap <M-8> 8gt
imap <M-9> <Esc>9gt
nmap <M-9> 9gt
imap <M-0> <Esc>:tablast<cr>
nmap <M-0> :tablast<cr>

" @see http://blog.chinaunix.net/u/8681/showart_1226043.html
" @usage 50g| jump to 50% of the lines columns.
nnoremap <expr> g<Bar> '<Esc>' . float2nr( round( (col('$')-1) * min([100, v:count]) / 100.0)) . '<Bar>'

function QFixState()
    return len(getqflist())
endfunction

" QUICKFIX WINDOW
" @see http://c9s.blogspot.com/2007/10/vim-quickfix-windows.html
command -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced == 0
        cclose
        unlet g:qfix_win
    else
        copen 10
        let g:qfix_win = bufnr("$")
    endif
endfunction
"nnoremap <leader>q :QFix<CR>

" close quickfix window.
"nmap <F4> :cclose<CR>
nmap <F4> :cw<CR>
" compile c/cpp code.
autocmd FileType cpp,c nmap <F9> :setlocal makeprg=make<cr>:make<cr> :copen<cr> <C-W>10_
"autocmd FileType cpp,c nmap <F10> :exe "!gcc -o ".expand("%:r").".exe ".expand("%")<cr>
"autocmd FileType cpp,c nmape <F10> :!gcc -o %:r.exe %<cr>
" @see http://easwy.com/blog/archives/advanced-vim-skills-quickfix-mode/
"      http://blog.zdnet.com.cn/html/30/422230-2881199.html
autocmd FileType cpp nmap <F10> :w<cr>:setlocal makeprg=g++\ -Wall\ -o\ %:r.exe\ %<cr>:make<cr><cr>:cw<cr>
autocmd FileType c nmap <F10> :w<cr>:setlocal makeprg=gcc\ -Wall\ -o\ %:r.exe\ %<cr>:make<cr><cr>:cw<cr>
" run current code.
autocmd FileType cpp,c nmap <F5> :!%:r.exe
autocmd FileType dosbatch nmap <F5> :!%<cr><cr>

autocmd FileType css syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

" Javascript & CSS Compress.
function JS_CSS_Compress()
    let cwd = expand('<afile>:p:h')
    let nam = expand('<afile>:t:r')
    let ext = expand('<afile>:e')
    if -1 == match(nam, "[\._]src$")
        let minfname = nam.".min.".ext
    else
        let minfname = substitute(nam, "[\._]src$", "", "g").".".ext
    endif
"    if ext == 'less'
"        if executable('lessc')
"            cal system( 'lessc '.cwd.'/'.nam.'.'.ext.' &')
"        endif
"    else
        if filewritable(cwd.'/'.minfname)
            if ext == 'js' && executable('closure-compiler')
                cal system( 'closure-compiler --js '.cwd.'/'.nam.'.'.ext.' > '.cwd.'/'.minfname.' &')
            elseif executable('yuicompressor')
                cal system( 'yuicompressor '.cwd.'/'.nam.'.'.ext.' > '.cwd.'/'.minfname.' &')
            endif
        endif
"    endif
endfunction
"autocmd FileWritePost,BufWritePost *.js :call Js_css_compress()
"autocmd FileWritePost,BufWritePost *.css :call Js_css_compress()
"autocmd FileWritePost,BufWritePost *.less :call Js_css_compress()


" Processing
function! RunP5()
    let processing_path="C:\\Program Files\\processing-1.0.9"
    let java_home=processing_path.'\\java'
    let class_path=java_home."\\lib\\rt.jar;".java_home."\\lib\\tools.jar;".processing_path."\\lib\\antlr.jar;".processing_path."\\lib\\core.jar;".processing_path."lib\\ecj.jar;".processing_path."\\lib\\jna.jar;".processing_path."\\lib\\pde.jar"
    silent execute '!start '.java_home.'\\bin\\java -classpath "'.class_path.'" processing.app.Commander --sketch="'.expand("%:h").'" --output="output" --run'
endfunction
autocmd FileType processing nnoremap <silent> <F9> :up<CR>:call RunP5()<CR>
autocmd FileType processing so $VIM/vimfiles/autoload/processing_omni.vim
autocmd FileType processing set ofu=OmniProcessing

" auto complete drop list.
set completeopt=longest,menu
imap <C-L> <C-x><C-o>


" Toggle Menu and Toolbar
" @see http://liyanrui.is-programmer.com/articles/1791/gvim-menu-and-toolbar-toggle.html
set guioptions-=m
set guioptions-=T
map <silent> <F2> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>


" Dynamic bind <HOME> key
" if caret/cursor not at the frist non-white-space character
"   move caret/cursor to there
" else
"   move to beginning
function HomeBind(offset)
    let cursor=getpos('.')
    let s0=getline(line('.'))
    let s1=substitute(s0, "^\\s\\+", "", "")
    let x=len(s0)-len(s1)+1
    if col('.') == x-a:offset
        let x=1
    endif
    call setpos('.', [cursor[0], cursor[1], x, cursor[3]])
endfunction
imap <silent> <Home> <Esc>:call HomeBind(1)<cr>i
nmap <silent> <Home> :call HomeBind(0)<cr>
vmap <silent> <Home> <Esc>:call HomeBind(1)<cr>


" Dynamic bind <END> key
" if caret/cursor not at the end
"   move caret/cursor to there
" else
"   move to last non-white-space character.
function EndBind(offset)
    let cursor=getpos('.')
    let s0=getline(line('.'))
    let s1=substitute(s0, "\\s*$", "", "")
    let x=len(s0)+a:offset
    if col('.') == x
        let x=len(s1)+a:offset
    endif
    call setpos('.', [cursor[0], cursor[1], x, cursor[3]])
endfunction
imap <silent> <End> <Esc>:call EndBind(0)<cr>a
nmap <silent> <End> :call EndBind(0)<cr>
vmap <silent> <End> :call EndBind(0)<cr>
":nmap <End> /\S\s*$<CR>:nohl<CR>


" place in vimrc
"nmap <silent><Home> :call SmartHome("n")<CR>
"nmap <silent><End> :call SmartEnd("n")<CR>
"imap <silent><Home> <C-r>=SmartHome("i")<CR>
"imap <silent><End> <C-r>=SmartEnd("i")<CR>
"vmap <silent><Home> <Esc>:call SmartHome("v")<CR>
"vmap <silent><End> <Esc>:call SmartEnd("v")<CR>

function SmartHome(mode)
  let curcol = col(".")
  "gravitate towards beginning for wrapped lines
  if curcol > indent(".") + 2
    call cursor(0, curcol - 1)
  endif
  if curcol == 1 || curcol > indent(".") + 1
    if &wrap
      normal g^
    else
      normal ^
    endif
  else
    if &wrap
      normal g0
    else
      normal 0
    endif
  endif
  if a:mode == "v"
    normal msgv`s
  endif
  return ""
endfunction

function SmartEnd(mode)
  let curcol = col(".")
  let lastcol = a:mode == "i" ? col("$") : col("$") - 1
  "gravitate towards ending for wrapped lines
  if curcol < lastcol - 1
    call cursor(0, curcol + 1)
  endif
  if curcol < lastcol
    if &wrap
      normal g$
    else
      normal $
    endif
  else
    normal g_
  endif
  "correct edit mode cursor position, put after current character
  if a:mode == "i"
    call cursor(0, col(".") + 1)
  endif
  if a:mode == "v"
    normal msgv`s
  endif
  return ""
endfunction

" }}}

" ------------------------------- Commands ------------------------------ {{{
" @see http://www.vim.org/scripts/script.php?script_id=687
" @see http://code.google.com/p/easy-vim/downloads/detail?name=vimtweak.dll
command -nargs=1 Alpha :call libcallnr("vimtweak.dll", "SetAlpha", <args>)
command -nargs=0 MaxWin :call libcallnr("vimtweak.dll", "EnableMaximize", 1)
command -nargs=0 MinWin :call libcallnr("vimtweak.dll", "EnableMaximize", 0)
command -nargs=0 TopWin :call libcallnr("vimtweak.dll", "EnableTopMost", 1)
command -nargs=0 UnTopWin :call libcallnr("vimtweak.dll", "EnableTopMost", 0)


"autocmd FileType xhtml,html command! -nargs=0 IE :call Save2Temp()<cr><cr>:!start RunDll32.exe shell32.dll,ShellExec_RunDLL %:p<cr>
autocmd FileType xhtml,html command! -nargs=0 FF :call Save2Temp()<cr><cr>:!start "E:\Mozilla Firefox\firefox.exe" -P debug %<cr>
autocmd FileType xhtml,html command! -nargs=0 IE6 :call Save2Temp()<cr><cr>:!start "E:\Mozilla Firefox\firefox.exe" -P debug %<cr>
autocmd FileType xhtml,html command! -nargs=0 IE7 :call Save2Temp()<cr><cr>:!start "E:\Mozilla Firefox\firefox.exe" -P debug %<cr>
autocmd FileType xhtml,html command! -nargs=0 IE8 :call Save2Temp()<cr><cr>:!start "E:\Mozilla Firefox\firefox.exe" -P debug %<cr>
autocmd FileType xhtml,html command! -nargs=0 SA :call Save2Temp()<cr><cr>:!start "E:\Mozilla Firefox\firefox.exe" -P debug %<cr>
autocmd FileType xhtml,html command! -nargs=0 OP :call Save2Temp()<cr><cr>:!start "E:\Mozilla Firefox\firefox.exe" -P debug %<cr>
autocmd FileType xhtml,html command! -nargs=0 CH :call Save2Temp()<cr><cr>:!start "E:\Mozilla Firefox\firefox.exe" -P debug %<cr>
" }}}

" -------------------------------- Plugins ------------------------------ {{{
" vimwiki
let g:vimwiki_use_mouse = 1
let g:vimwiki_camel_case = 0
let g:vimwiki_CJK_length = 1
let g:vimwiki_use_calendar = 0

" Auto Complete Pop Menu
" autocomplpop.vim
" @see http://www.vim.org/scripts/script.php?script_id=1879
" @see http://hi.baidu.com/timeless/blog/item/cb4478f09a1563ca7931aa5d.html
" Note: functions and key maps invalid.
"
let g:acp_behaviorSnipmateLength = 1        " AutoComplete snippets for snipMate.
let g:AutoComplPop_MappingDriven = 1        " Don't popup when move cursor.
let g:AutoComplPop_IgnoreCaseOption = 1
" @see http://d.hatena.ne.jp/cooldaemon/20071114/1195029893
autocmd FileType * let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i'
"autocmd FileType perl let g:AutoComplPop_CompleteOption = '.,w,b,u,t,k~/.vim/dict/perl.dict'
"autocmd FileType ruby let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/ruby.dict'
autocmd FileType javascript let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k$VIM/vimfiles/dict/javascript.dict'
"autocmd FileType erlang let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/erlang.dict'


" Just for AutoComplPop css url.
" but more bugs in other place.
"if exists('+shellslash')
    "set shellslash                          " FileNameComplete by slash(/)
"endif


autocmd FileType javascript set dictionary=$VIM/vimfiles/dict/javascript.dict,$VIM/vimfiles/dict/jQuery.dict,$VIM/vimfiles/dict/jQuery.dict
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS



" Doxygen
" @see http://www.vim.org/scripts/script.php?script_id=5
" @see http://www.vim.org/scripts/script.php?script_id=987
" @see http://www.jeffhung.net/blog/articles/jeffhung/447/
" @see http://blog.csdn.net/AD_LI/archive/2009/08/24/4474878.aspx
let g:DoxygenToolkit_authorName="闲耘™ (@hotoo, mail@xianyun.org)"
let s:licenseTag = "Copyleft(C)\<enter>"
let s:licenseTag = s:licenseTag . "For 闲耘™\<enter>"
let s:licenseTag = s:licenseTag . "Some right reserved\<enter>"
let g:DoxygenToolkit_licenseTag = s:licenseTag
let g:DoxygenToolkit_briefTag_funcName="yes"
let g:doxygen_enhanced_color=1


" gvim full screen plugin
" @see http://www.vim.org/scripts/script.php?script_id=2596
" @see http://www.gracecode.com/archives/2946/
nmap <F11> :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<cr>
imap <F11> <C-o><F11>


" jsLint
" @see http://www.gracecode.com/category/496/
" @see http://www.vim.org/scripts/script.php?script_id=2578
let g:jslint_command = $VIM.'\vimfiles\jslint\jsl.exe'
"map <C-s><C-j> :call JsonLint()<cr>


" css color
" @see http://www.gracecode.com/archives/977/
" @see http://www.vim.org/scripts/script.php?script_id=2150


" Calendar
" @see http://www.gracecode.com/archives/674/
let g:calendar_smnd = 1
let g:calendar_monday = 1                   " week start with monday.
let g:calendar_weeknm = 1                   " don't work with g:calendar_diary
let g:calendar_mark = 'left-fit'            " let plus(+) near the date, like +8.
"let g:calendar_mruler = '一月,二月,三月,四月,五月,六月,七月,八月,九月,十月,十一月,十二月'
"let g:calendar_wruler = '日 一 二 三 四 五 六'
"let g:calendar_navi_label = '上月,本月,下月'

" NERDTree
" @see http://www.vim.org/scripts/script.php?script_id=1658
" @see http://www.gracecode.com/archives/1339/
"imap <F3> <Esc>:NERDTreeToggle<cr>
"nmap <F3> :NERDTreeToggle<cr>
" For NERD_tree Project
" @see http://www.vim.org/scripts/script.php?script_id=2801
let g:NERDTreeWinPos="left"
let g:NERDTreeWinSize=20
imap <F3> <Esc>:ToggleNERDTree<cr>
nmap <F3> :ToggleNERDTree<cr>


" for javascript.vim
" enable javascript fold
"let javascript_fold=1
" enable support dom, html and css for javascript
"let javascript_enable_domhtmlcss=1


" ctags
let g:ctags_path=$VIM.'\vimfiles\plugin\ctags.exe'
let g:ctags_statusline=1
let g:ctags_args=1


" TagList
" @see http://easwy.com/blog/archives/advanced-vim-skills-taglist-plugin/
if has('win32')
    let Tlist_Ctags_Cmd=$VIM.'\vimfiles\plugin\ctags.exe'
else
    let Tlist_Ctags_Cmd= '/usr/bin/ctags'
endif
let g:Tlist_Use_Right_Window=1
let g:Tlist_Show_One_File = 1
let g:Tlist_Exit_OnlyWindow = 1
let g:Tlist_WinWidth=25
nnoremap <F12> :TlistToggle<CR>

let tlist_vimwiki_settings = 'wiki;h:Headers'
let tlist_html_settings = 'html;h:Headers;o:Objects(ID);c:Classes'
let tlist_xhtml_settings = 'html;h:Headers;o:Objects(ID);c:Classes'
let tlist_velocity_settings = 'html;h:Headers;o:Objects(ID);c:Classes'
let tlist_css_settings = 'css;c:Classes;o:Objects(ID);t:Tags(Elements)'
let tlist_javascript_settings = 'javascript;f:Functions;c:Classes;o:Objects'


" snipMate
" text+<TAB> to Auto Complete Code Fragments.
" @see http://www.vim.org/scripts/script.php?script_id=2540
" @see http://code.google.com/p/snipmate/
" @see http://vimeo.com/3535418
let snips_author="闲耘 (mail[AT]xianyun.org)"

" }}}

" ------------------------------- Folding ---------------------------- {{{
":au BufNewFile,BufRead *.xml,*.htm,*.html so ~/.vim/plugin/XMLFolding.vim
au BufNewFile,BufRead *.xml,*.htm,*.html,*.vm,*.php,*.jsp so $VIM/vimfiles/ftplugin/xml/xml_fold.vim

" }}}

" --------------------------- Macros & Functions ------------------------ {{{
" Remove trailing whitespace when writing a buffer, but not for diff files.
" From: Vigil
" @see http://blog.bs2.to/post/EdwardLee/17961
function! RemoveTrailingWhitespace()
    if &ft != "diff"
        let b:curcol = col(".")
        let b:curline = line(".")
        silent! %s/\s\+$//
        silent! %s/\(\s*\n\)\+\%$//
        call cursor(b:curline, b:curcol)
    endif
endfunction
autocmd BufWritePre * call RemoveTrailingWhitespace()


" get week day string in chinese.
function! Week_cn()
    return "星期".strpart("日一二三四五六", strftime("%w")*3, 3)
endfunction

" }}}

" Chinese Docs
"cp -R doc $VIM.'\vimfiles\doc\'
let helptags=$VIM.'\vimfiles\doc'
set helplang=cn
