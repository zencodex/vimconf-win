if exists("b:current_syntax")
  finish
endif

syn match   taskPrefix	display "^\s*[*#-][! ~]\[.\]"
syn match   taskPrefix	display "^\s*\* \[ \]"
syn match   taskTime	display "|T:\(\d\{4}\-\d\{2}\-\d\{2}.*\)|"
syn match   taskID	    conceal "#ID:[a-zA-Z0-9+]\{22}==#"
syn match   taskTags	display "#[a-zA-Z0-9_-]\+" contains=taskID
syn region  taskItem	start="\* \[.\]" end="$" contains=taskTodo,taskPrefix,taskTime,taskID,taskTags,@Spell
"syn region  taskImportant	start="^\s*[\*#-]!\[.\]" skip="\n^\s*[^*#-].*" end="$" contains=taskTodo,taskPrefix,@Spell
syn region  taskImportant	start="^\s*[\*#-]!\[.\]" end="$" contains=taskTodo,taskPrefix,taskTime,taskID,taskTags,@Spell
syn region  taskLower	start="^\s*\*\~\[.\]" end="$" contains=taskTodo,taskPrefix,taskTime,taskID,taskTags,@Spell
syntax region taskDone start="^\s*\*.\[X\]" end="$" contains=taskTodo,taskTime,taskID,taskTags,@Spell

hi def link taskPrefix		Special

hi def link taskDone		Comment
"hi taskDone		guifg=#555555

hi def link taskTime		Comment
"hi def link taskTime		Structure

hi def link taskID		    Ignore
hi def link taskTags		Underlined

"hi def link taskItem		Statement

"hi taskLower	guifg=gray
hi def link taskLower		Statement

"hi def link taskImportant	Identifier
"hi def link taskImportant	Directory
hi def link taskImportant	Todo

let b:current_syntax = "task"
