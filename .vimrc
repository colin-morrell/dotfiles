set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'tmhedberg/SimpylFold'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Basic stuff
syntax on
set nu
colorscheme zenburn

" Press F4 to toggle highlighting on/off, and show current value.
:noremap <F4> :set hlsearch! hlsearch?<CR>

" Shift key is hard
:command Q q
:command W w
:command WQ wq
:command Wq wq

" Tabs? Spaces? Porque no los dos
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set expandtab

" Enable folding with the spacebar
nnoremap <space> za

au BufNewFile,BufRead *.py
    \ set textwidth=99 |
    \ set fileformat=unix
