syn keyword cueKey contained PERFORMER TITLE TRACK INDEX

syn match Comments /\<REM\ .*$/
syn match Perf /^\s*PERFORMER\ ".\{-}"/
syn match Title /^\s*TITLE\ ".\{-}"/
syn match File /^FILE\ ".\{-}"/
syn match Track /^\s*TRACK\ ".\{-}"/
syn match Index /^\s*INDEX\ ".\{-}"/

hi Comments guifg=#666666
hi Perf guifg=#ffffff
hi Title gui=bold guifg=#cc3300
