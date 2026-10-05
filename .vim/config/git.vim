"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> PLUGINS/GIT-TRACKING (FUGITIVE & GITGUTTER)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" follow symlinks to preserve git tracking (fugitive/gitgutter)
function! s:FollowSymlink()
    " full path of current buffer as opened (e.g. ~/.vimrc)
    let l:path = expand('%:p')
    if getftype(l:path) ==# 'link'
        " rename buffer to symlink's real path (e.g. ~/dotfiles/.vimrc)
        " so plugins see git repo
        execute 'silent! file ' . fnameescape(resolve(l:path))
        edit
        " gitgutter disables a buffer when it's renamed (:file above)
        " unless it was already enabled. rename happens on BufReadPost,
        " before gitgutter's first BufEnter has enabled it, so re-enable it here
        if exists(':GitGutterBufferEnable')
            GitGutterBufferEnable
        endif
    endif
endfunction
autocmd BufReadPost * ++nested call s:FollowSymlink()

" less delay for gitgutter to appear
set updatetime=100

" gitgutter: no colorscheme is loaded, so vim's defaults give the sign column a light grey
" background (ctermbg=248) and leave the + sign with no color. use the terminal background
" and embark green/yellow/red. gitgutter keeps these since they set a foreground color
hi SignColumn ctermbg=NONE
hi GitGutterAdd ctermfg=2 ctermbg=NONE
hi GitGutterChange ctermfg=3 ctermbg=NONE
hi GitGutterDelete ctermfg=1 ctermbg=NONE
