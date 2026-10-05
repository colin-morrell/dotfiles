" sourced after vim's built-in syntax/python.vim every time it loads (including
" reloads from :so ~/.vimrc), so everything here survives the syntax file's syn clear.
" python_highlight_all stays in ~/.vimrc since it has to be set before the syntax file loads

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> PALETTE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" embark theme colors
"  0  #1E1C31  black
"  1  #F48FB1  red
"  2  #A1EFD3  green
"  3  #FFE6B3  yellow
"  4  #91DDFF  blue
"  5  #D4BFFF  purple
"  6  #87DFEB  cyan
"  7  #CBE3E7  white
"  8  #585273  brightBlack
"  9  #F02E6E  brightRed
" 10  #62D196  brightGreen
" 11  #F2B482  brightYellow
" 12  #65B2FF  brightBlue
" 13  #A37ACC  brightPurple
" 14  #63F2F1  brightCyan
" 15  #D4BFFF  brightWhite (actually purple, original #8A889D; changed in winterminal settings.json)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> GROUPINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" True/None/False/self -> pythonDecorator
syn keyword pythonDecorator True None False

" class names -> pythonClass (built-in sends both def and class names to pythonFunction).
" redefine `class` without nextgroup=pythonFunction, then match class names. not
" `contained`, since several built-in regions use contains=ALLBUT and would pick it up
syn keyword pythonStatement class

" CapWords names anywhere (Shape, Enum), like github: capitalized with at least one lowercase
" letter, so ALL_CAPS constants are skipped. keywords (True, ValueError) still win over this
syn match pythonClass "\<\u\w*\l\w*\>" display

" any name after `class`, even lowercase. defined last so it wins at the same position
syn match pythonClass "\%(\<class\s\+\)\@<=\h\w*" display

" symbol operators -> pythonMathOperator (built-in leaves them unhighlighted). longest first,
" since vim takes the first alternative that matches. @ is left out so decorators keep
" pythonDecoratorName; a lone : is left out so slices/dict colons stay plain
syn match pythonMathOperator "->\|\*\*=\=\|//=\=\|<<=\=\|>>=\=\|[-+*/%&|^<>!=:]=\|[-+*/%&|^~<>=]" display

" attribute access -> pythonAttribute (self.depth, Align.CENTER). built-in pythonAttribute is
" transparent, so it can't be colored; redefine it. the match starts at the dot (hs=s+1 leaves
" the dot plain) so it beats keywords like x.type. names followed by ( are method calls, skipped
syn clear pythonAttribute
syn match pythonAttribute "\.\h\w*\>\%(\s*(\)\@!"hs=s+1 display

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> HIGHLIGHTING
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" def, class, return, pass, lambda, with, global, yield...
hi pythonStatement ctermfg=1

" if, elif, else, match, case
hi pythonConditional ctermfg=1

" for, while
hi pythonRepeat ctermfg=5

" and, or, not, in, is
hi pythonOperator ctermfg=12

" + - * / // % ** = == != < > <= >= & | ^ ~ << >> += := -> ...
hi pythonMathOperator ctermfg=12

" attribute access after a dot: self.depth, Align.CENTER (not definitions or method calls)
hi pythonAttribute ctermfg=12

" try, except, finally, raise
hi pythonException ctermfg=1

" import, from, as
hi pythonInclude ctermfg=1

" async, await
"hi pythonAsync ctermfg=4

" @
hi pythonDecorator ctermfg=5

" dataclass, property
hi pythonDecoratorName ctermfg=5

" class names
hi pythonClass ctermfg=11

" function names
hi pythonFunction ctermfg=13

" str, int, len, print, range, dict...
hi pythonBuiltin ctermfg=7

" ValueError, KeyError, Exception...
hi pythonExceptions ctermfg=13

" strings
hi pythonString ctermfg=4

" r'...' strings
"hi pythonRawString ctermfg=2

" quote chars + f/r/b prefixes
hi pythonQuotes ctermfg=4

" docstrings
hi pythonTripleQuotes ctermfg=4

" \n, \t, \x1f, \N{...} inside strings
"hi pythonEscape ctermfg=11

" 1, 0x1f, 1.5e3...
hi pythonNumber ctermfg=12

" # comments, set globally in ~/.vimrc (hi Comment)
"hi pythonComment ctermfg=8

" TODO, FIXME, XXX inside comments
hi pythonTodo ctermfg=0 ctermbg=13

" trailing whitespace / mixed tabs
"hi pythonSpaceError ctermbg=1

" >>> lines in docstrings
"hi pythonDoctest ctermfg=5

" expected output in doctests
"hi pythonDoctestValue ctermfg=13
