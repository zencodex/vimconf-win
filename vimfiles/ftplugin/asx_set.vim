"===========================================================================
" Vim setting file for ASX files
"
" File          : asx.set
" Author        : Luc Hermitte <hermitte at free.fr>
"                 <URL:http://hermitte.free.fr/vim/>
" Last update   : 21st jul 2002
"
" Purpose       : Help the creation of ASX files. An ASX file lists a set
"                 of multmedia files (musics, movies). Then, it can be
"                 used by Windows Media Player to play the whole list.
"
"                 This settings file defines then 2 mappings useful to
"                 construct automatically ASX Files.
"
" How To use it : 0- If you want to group a list of files named foo(.*)
"                 1- create the ASX file named after "foo" :- gvim foo.asx
"                 2- within VIM, call the first macro      :- =dir
"                 3- then the second one                   :- =fin
"                (4-) Optional : if you want to delete some lines... do
"                    it and then save the result.
" 
"===========================================================================
"
if !exists("g:loaded_asx_set_vim")
  let g:loaded_asx_set_vim = 1

  if has("dos16") || has("dos32") || has("win32")
    :map =dir 1G"%P:s/.asx//<CR>0"ay$i<ASX version = "3.0"><Title><end></Title><esc>:r !dir /b %<*.*<cr>
    "":map =dir 1G"%P:s/.asx//<CR>0"ay$i<ASX version = "3.0"><Title><end></Title><esc>O:r !dir /b <esc>"apa*.*<esc>"bdd:@ "b<cr>
  elseif has("unix")
    :noremap =dir 1G"%P:s/.asx//<CR>0"ay$i<ASX version = "3.0"><Title><end></Title><esc>O:r !ls -1 <esc>"apa*.*<esc>"bdd:@ "b<cr>
  endif

  :map =fin :2,$s/^\(.*\)$/<Entry><Ref href = "\1" \/><\/Entry><cr>Go</ASX><esc>:w<CR>
  "":map =fin O:%s/\(<esc>"apa.*\.[a-zA-Z]*\)/<Entry><Ref href = "\1" \/><\/Entry><esc>"cdd:@ "c<cr>Go</ASX><esc>:w<CR>
  
endif
