" 快速格式化c代码的脚本
" @install 拷贝到vim目录的ftplugin/c目录下
" @usage 按下F1即可,为防止万一格式化以后没有保存,应该自己手动保存格式化结果
" @see http://www.gnu.org/software/indent/indent.html
" @see http://gnuwin32.sourceforge.net/packages/indent.htm
" @author :LJB
" let maplead='\'
function! Extindent()
	if !executable("indent")
		echo "indent no find!"
		return
	endif
	if &filetype != "c" && &filetype != "cpp"
		echo "the buffer seem no c file or c++ file!"
		return
	endif
	"let s:bmode=mode()
	"if s:bmode=='r' || s:bmode=='i'
	"	exec ":update"
	"endif
	exec ":mark t"
	"	if has("MSWIN")
	silent exe ":%!indent"
	"	else
	"		silent exe ":%!indent 2> ".s:C_IndentErrorLog
	"	endif
	exec ":'t"
	echo "current buffer executed indent."
endfunction

nmap <F1> :call Extindent()<CR>
