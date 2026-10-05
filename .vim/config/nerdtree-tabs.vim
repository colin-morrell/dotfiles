"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> PLUGINS/NERDTREE/VIM-NERDTREE-TABS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" enabled by default:
" g:nerdtree_tabs_no_startup_for_diff               --> do not start nerdtree in diff mode
" g:nerdtree_tabs_smart_startup_focus               --> focus file if opening file, nerdtree if dir
" g:nerdtree_tabs_open_on_new_tab                   --> open nerdtree in new tab if nerdtre was globally opened
" g:nerdtree_tabs_meaningful_tab_names              --> unfocus nerdtree when leaving a tab
" g:nerdtree_tabs_autoclose                         --> close tab if only remaining window is nerdtree
" g:nerdtree_tabs_synchronize_view                  --> sync all nerdtree windows (scroll, cursor position)
" g:nerdtree_tabs_synchronize_focus                 --> sync focus when switching windows
" g:nerdtree_tabs_startup_cd                        --> cd into dir if called as cmd argument for vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" open nerdtree upon vim startup
let g:nerdtree_tabs_open_on_console_startup = 0 

" always focus on file when switching tabs
let g:nerdtree_tabs_focus_on_files = 1

" auto find+select currently opened file in nerdtree
let g:nerdtree_tabs_autofind = 1 
