if exists("b:current_syntax")
  finish
endif

syn match   taskTime	display "\(\d\{4}-\d\{2}-\d\{2}\)"
syn region  taskItem	start="\* \[ \]" end="$" contains=taskTodo,@Spell
syn region  taskImportant	start="\*!\[.\]" end="$" contains=taskTodo,@Spell
syn region  taskDone	start="\*.\[X\]" end="$" contains=taskTodo,@Spell


hi def link taskDone		Comment
hi def link taskTime		String
hi def link taskImportant	Error

let b:current_syntax = "task"
