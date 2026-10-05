"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> PLUGINS/NERDTREE/VIM-NERDTREE-SYNTAX-HIGHLIGHT
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

" disable defaults to start
let g:NERDTreeSyntaxDisableDefaultExtensions = 1
let g:NERDTreeSyntaxDisableDefaultExactMatches = 1
let g:NERDTreeSyntaxDisableDefaultPatternMatches = 1

" enabled defaults
let g:NERDTreeSyntaxEnabledExtensions = [
    \ 'htm', 
    \ 'html', 
    \ 'js', 
    \ 'json', 
    \ 'markdown', 
    \ 'md', 
    \ 'py', 
    \ 'sh',
    \ 'vim',
\]
let g:NERDTreeSyntaxEnabledExactMatches = ['dockerfile', 'docker-compose.yml'] " enabled exact matches with default colors

" these are the default colors for the embark theme
let s:bg_dark = '100E23'
let s:red = 'F48FB1'
let s:green = 'A1EFD3'
let s:yellow = 'FFE6B3'
let s:blue = '91DDFF'
let s:purple = 'D4BFFF'
let s:cyan = '87DFEB'
let s:norm = 'CBE3E7'
let s:bg_bright = '585273'
let s:dark_red = 'F02E6E'
let s:dark_green = '62D196'
let s:dark_yellow = 'F2B482'
let s:dark_blue = '65B2FF'
let s:dark_purple = 'A37ACC'
let s:dark_cyan = '63F2F1'
let s:norm_subtle = '8A889D'


" these are general nerdtree settings but they make sense here
"highlight NERDTreeHelp ctermfg=0
"highlight NERDTreeBookmarksHeader ctermfg=16 ctermbg=4
highlight NerdTreeBookmarkName ctermfg=4
highlight NerdTreeBookmark ctermfg=0
"highlight NERDTreeUp ctermfg=0
highlight NERDTreeCWD ctermfg=0 ctermbg=2
highlight NERDTreeDir ctermfg=2
highlight NERDTreeDirSlash ctermfg=2

" needed to avoid error
let g:NERDTreeExtensionHighlightColor = {}
let g:NERDTreeExactMatchHighlightColor = {}
let g:NERDTreePatternMatchHighlightColor = {}

" special config files
let s:special_config = s:dark_cyan
let g:NERDTreeExactMatchHighlightColor['.tmux.conf'] = s:special_config
let g:NERDTreeExactMatchHighlightColor['.zshrc'] = s:special_config
let g:NERDTreePatternMatchHighlightColor['.*vimrc.*'] = s:special_config
let g:NERDTreeExtensionHighlightColor['conf'] = s:special_config

" other config files
let s:config = s:norm_subtle
let g:NERDTreeExactMatchHighlightColor['.gitconfig'] = s:config
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:config
let g:NERDTreeExactMatchHighlightColor['.zsh_history'] = s:config
let g:NERDTreeExactMatchHighlightColor['.NERDTreeBookmarks'] = s:config
let g:NERDTreeExtensionHighlightColor['cfg'] = s:config
let g:NERDTreeExtensionHighlightColor['zsh'] = s:config

" python
let s:py_yellow = s:dark_yellow
let g:NERDTreeExtensionHighlightColor['py'] = s:py_yellow
let g:NERDTreeExactMatchHighlightColor['python'] = s:py_yellow
"let g:NERDTreePatternMatchHighlightColor['*python/*'] = s:py_yellow

" csv, json
let g:NERDTreeExtensionHighlightColor['json'] = s:purple
let g:NERDTreeExtensionHighlightColor['csv'] = s:cyan

" defaults
let s:default_folder = s:green
let g:WebDevIconsDefaultFolderSymbolColor = s:default_folder

let s:default_file = s:norm
let g:WebDevIconsDefaultFileSymbolColor = s:default_file
