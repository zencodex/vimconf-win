" Description:  local HTML5 file validator.nu link up
" Maintainer:   Kai Hendry <hendry@iki.fi> http://hendry.iki.fi/
" URL:          http://svn.natalian.org/projects/html5/
" Last Change:  $Id$
"
" Place this file as ~/.vim/ftplugin/html.vim
" Ensure you have filetype plugin on in your ~/.vimrc
" See mine: http://git.webconverger.org/?p=home.git;a=blob;f=.vimrc
"
" Whilst editing HTML run :make then :cope or :clist to debug
"
" References:
" http://wiki.whatwg.org/wiki/Validator.nu_GNU_Output
" http://wiki.whatwg.org/wiki/Validator.nu_Common_Input_Parameters
function! ValidateCSS()
    "let fmt=substitute(&errorformat, " \+", "\ ", "g")

    setlocal makeprg=validate-css.bat\ %
    setlocal errorformat=Line\ :\ %l\ %m

    make
    "exec "setlocal errorformat=".fmt
    cw
endfunction

" BUGS:
" http://groups.google.com/group/vim_dev/browse_thread/thread/e795711aa3c3efcb
" can errorformat can handle end line numbers et al. ? a visual selection?
"
" could be done as one line in the ~/.vimrc instead of a seperate plugin
" <!DOCTYPE html> could be detected instead of relying on the html filetype
" somehow integrate http://code.google.com/doctype/ or MDC?

command -nargs=0 -buffer Validate :call ValidateCSS()
nmap <buffer> <F9> :call ValidateCSS()<cr><cr>
