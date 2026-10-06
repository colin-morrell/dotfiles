" sourced after vim's built-in syntax/json.vim every time it loads, so everything
" here survives the syntax file's syn clear. palette: see ~/.vim/after/syntax/python.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> GROUPINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" key quotes -> jsonKeywordQuote, so they can match key color (built-in shares jsonQuote with values)
" conceal condition copied from built-in
syn clear jsonKeyword
if has('conceal') && (!exists('g:vim_json_conceal') || g:vim_json_conceal == 1)
    syn region jsonKeyword matchgroup=jsonKeywordQuote start=/"/ end=/"\ze[[:blank:]\r\n]*\:/ concealends contained
else
    syn region jsonKeyword matchgroup=jsonKeywordQuote start=/"/ end=/"\ze[[:blank:]\r\n]*\:/ contained
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> HIGHLIGHTING
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

hi jsonBraces ctermfg=7

hi jsonKeyword ctermfg=1

hi jsonKeywordQuote ctermfg=1

hi jsonNumber ctermfg=12

hi jsonQuote ctermfg=4

hi jsonString ctermfg=4
