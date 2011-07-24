" Current System Settings.
" Thinkpad T60 @Home.
" @author 闲耘™(@hotoo)

" Vimwiki.
let g:vimwiki_list = [{'path': '~/Dropbox/VimPrivateWiki'},
        \ {
            \ 'path'        : '~/Dropbox/vimwiki',
            \ 'path_html'   : '~/wiki.hotoo.me',
            \ 'html_header' : '~/Dropbox\vimwiki\template\header.tpl',
            \ 'html_footer' : '~/Dropbox\vimwiki\template\footer.tpl'
        \ },
        \ {
            \ 'path'        : '~/vim-script-cn/trunk/intro-wiki',
            \ 'path_html'   : '~/vim-script-cn/trunk/intro',
            \ 'html_header' : '~/vim-script-cn/trunk/intro-wiki/template/header.tpl',
            \ 'html_footer' : '~/vim-script-cn/trunk/intro-wiki/template/footer.tpl'
        \ },
        \ {
            \ 'path'        : '~/Dropbox/blog',
            \ 'path_html'   : '~/blog.hotoo.me',
            \ 'nested_syntaxes' : {'javascript': 'javascript', 'python': 'python', 'c++': 'cpp'},
            \ 'html_header' : '~/Dropbox/blog/template/header.tpl',
            \ 'html_footer' : '~/Dropbox/blog/template/footer.tpl'
        \ }
        \ ]


" Calendar.vim
"let g:calendar_diary=$VIM.'\vimfiles\calendar_data\'
let g:calendar_diary='~/Dropbox/diary'
let g:calendar_list = [
    \   {'name': 'Works', 'path': '~/Dropbox/works', 'ext': 'task'},
    \   {'name': 'Tasks', 'path': '~/Dropbox/tasks', 'ext': 'task'},
    \   {'name': 'Diary', 'path': '~/Dropbox/diary', 'ext': 'diary'},
    \ ]
let g:calendar_current_idx = 2

" Twitter
" @see http://www.vim.org/scripts/script.php?script_id=2204
let twitvim_login = "user:pass"
let g:twitvim_api_root = "api.host.name"
