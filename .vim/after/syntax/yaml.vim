" sourced after vim's built-in syntax/yaml.vim every time it loads, so everything
" here survives the syntax file's syn clear. palette: see ~/.vim/after/syntax/python.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> GROUPINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" quoted keys ('key': / "key":) -> yamlQuotedKey, quotes -> yamlKeyQuote
" built-in treats them as plain yamlFlowString values. defined later so it wins at the same position
syn region yamlQuotedKey matchgroup=yamlKeyQuote start=/"/ skip=/\\"/ end=/"\ze\s*:\%(\s\|$\)/ contained oneline
syn region yamlQuotedKey matchgroup=yamlKeyQuote start=/'/ skip=/''/ end=/'\ze\s*:\%(\s\|$\)/ contained oneline
syn match yamlQuotedKeyMatch /\%("\%([^"\\]\|\\.\)*"\|'\%([^']\|''\)*'\)\ze\s*:\%(\s\|$\)/ contains=yamlQuotedKey nextgroup=yamlKeyValueDelimiter
syn cluster yamlFlow add=yamlQuotedKeyMatch


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> HIGHLIGHTING
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" { } [ ] , in flow style
hi yamlFlowIndicator ctermfg=7

" unquoted keys
hi yamlBlockMappingKey ctermfg=1
hi yamlFlowMappingKey ctermfg=1

" quoted keys
hi yamlQuotedKey ctermfg=1
hi yamlKeyQuote ctermfg=1

hi yamlInteger ctermfg=12
hi yamlFloat ctermfg=12

" quote chars around values
hi yamlFlowStringDelimiter ctermfg=4

" quoted and unquoted values
hi yamlFlowString ctermfg=4
hi yamlPlainScalar ctermfg=4
