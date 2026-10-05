"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> PLUGINS/VIM-TMUX-NAVIGATOR
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tmux_navigator_no_mappings = 1
" write current buffer, if changed, when navigating back to tmux
let g:tmux_navigator_save_on_switch = 1
" If the tmux window is zoomed, keep it zoomed when moving from vim to another pane
let g:tmux_navigator_preserve_zoom = 1

noremap <silent> <Esc>[1;3D :<C-U>TmuxNavigateLeft<cr>
noremap <silent> <Esc>[1;3B :<C-U>TmuxNavigateDown<cr>
noremap <silent> <Esc>[1;3A :<C-U>TmuxNavigateUp<cr>
noremap <silent> <Esc>[1;3C :<C-U>TmuxNavigateRight<cr>
