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

" open -> pythonFunction instead of pythonBuiltin. keywords defined later win
syn keyword pythonFunction open

" class names -> pythonClass (built-in sends both def and class names to pythonFunction).
" redefine `class` without nextgroup=pythonFunction, then match class names. not
" `contained`, since several built-in regions use contains=ALLBUT and would pick it up
syn keyword pythonStatement class

" CapWords names anywhere (Shape, Enum), like github: capitalized with at least one lowercase
" letter, so ALL_CAPS constants are skipped. keywords (True, ValueError) still win over this
syn match pythonClass "\<\u\w*\l\w*\>" display

" any name after `class`, even lowercase. defined last so it wins at the same position
syn match pythonClass "\%(\<class\s\+\)\@<=\h\w*" display

" ALL_CAPS constants (CONFIG_PATH, Shape.ROUND): 2+ chars of uppercase/digits/underscores
syn match pythonConstant "\<\u[A-Z0-9_]\+\>" display

" symbol operators without = -> pythonMathOperator (builtin leaves them unhighlighted)
" anything with = (=, ==, +=, :=...) and -> stays regular text, @ stays a decorator
" only matches when not touching another operator char, so the + in += stays plain
syn match pythonMathOperator "[-+*/%&|^~<>!=]\@<!\%(\*\*\|//\|<<\|>>\|[-+*/%&|^~<>]\)[-+*/%&|^~<>!=:]\@!" display

" attribute access + method calls -> pythonAttribute (self.depth, os.path.join())
" builtin pythonAttribute is transparent/can't be colored --> redefine it
" match starts at dot (hs=s+1 leaves the dot plain) to beats keywords like x.type
" dotted module paths on import lines --> skipped
" ALL_CAPS names --> skipped (pythonConstant)
syn clear pythonAttribute
syn match pythonAttribute "\%(^\s*\%(from\s\+\%(\w\|\.\)*\|import\s\+\%(\w\|[., \t]\)*\)\)\@<!\.\%(\u[A-Z0-9_]\+\>\)\@!\h\w*\>"hs=s+1 display

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

" + - * / // % ** < > << >> & | ^ ~ (not =, ==, +=, ->, etc.)
hi pythonMathOperator ctermfg=12

" names after a dot: self.depth, os.path.join(), json.load() (not definitions)
hi pythonAttribute ctermfg=12

" ALL_CAPS constants: CONFIG_PATH, Shape.ROUND
hi pythonConstant ctermfg=12

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
hi pythonBuiltin ctermfg=13

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
