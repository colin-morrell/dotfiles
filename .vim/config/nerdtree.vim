"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> PLUGINS/NERDTREE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "right"
let g:NERDTreeShowHidden = 1
let g:NERDTreeIgnore = [
    \ '\.pyc$', 
    \ '__pycache__', 
    \ '.DS_Store', 
    \ '.CFUserTextEncoding', 
    \ '.localized', 
    \ 'wget-hsts', 
    \ '.swp', 
    \ '.zip', 
    \ '.pkg',
    \ '.autoenv_authorized',
    \ '.lesshst',
    \ '.rediscli_history',
    \ '.viminfo',
    \ '.vimrc.bak',
    \ '.zcompdump*',
    \ '.zprofile',
    \ '\.stl$',
\]
let g:NERDTreeWinSize = 40
let g:NERDTreeMinimalUI = 1

" bookmarks
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeBookmarksSort = 0
let g:NERDTreeMarkBookmarks = 0

nnoremap n :NERDTreeToggle<cr>
