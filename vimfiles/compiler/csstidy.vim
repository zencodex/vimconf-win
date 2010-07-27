" Vim compiler file
" Compiler:	HTML Tidy
" Maintainer:	Doug Kearns <djkea2@gus.gscit.monash.edu.au>
" URL:		http://gus.gscit.monash.edu.au/~djkea2/vim/compiler/tidy.vim
" Last Change:	2004 Nov 27

" NOTE: set 'tidy_compiler_040800' if you are using the 4th August 2000 release
"       of HTML Tidy.

if exists("current_compiler")
  finish
endif
let current_compiler = "csstidy"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=csstidy\ %:p\ --preserve_css=false\ --remove_bslash=false\ --compress_color=true\ --lowercase_s=false\ --timestamp=false\ --optimise_shorthands=0\ --remove_last_;=true\ --sort_selectors=false\ --merge_selectors=0\ --compress_font-weight=false\ --allow_html_in_template=false\ --silent=true\ --case_properties=0\ --template=highest\ %:p:r.min.%:p:e


" sample warning: foo.html:8:1: Warning: inserting missing 'foobar' element
" sample error:   foo.html:9:2: Error: <foobar> is not recognized!
CompilerSet errorformat=%f:%l:%c:\ Error:%m,%f:%l:%c:\ Warning:%m,%-G%.%#
