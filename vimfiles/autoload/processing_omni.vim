
if exists("g:loaded_processing_omnicomplete")
    finish
endif
let g:loaded_processing_omnicomplete = 1

let s:KEY_WORD = split("catch delay exit extends false final implements import loop new noLoop null popStyle provate public pushStyle redraw return static super this true  try cursor focused frameCount frameRate height noCursor online screen width boolean byte char color double float int long Array ArrayList HashMap Object String XMLElement binary unbinary hex unhex void setup draw background stroke noStroke size line ellipse")

function! OmniProcessing(start,base)
    if a:start
        " locate the start of the word
        let line = getline('.')
        let st = col('.') - 1
        " 直到找到非字母字符或行首
        while st > 0 && line[st-1] =~ '\a'
            let st -= 1
        endwhile
        return st
    else
        let res=[]
        for m in s:KEY_WORD
            if m=~ '^'.a:base
                call add(res, m)
            endif
        endfor
        return res
    endif
endfunction
