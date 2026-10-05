"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> PLUGINS (VUNDLE)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" all plugins go here
""""""""""""""""""""""""""""""""
" aesthetic stuff
Plugin 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" tmux
Plugin 'christoomey/vim-tmux-navigator'

" git (branch + hunk counts in airline section b)
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" nerdtree
Plugin 'preservim/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs.git'
Plugin 'ryanoasis/vim-devicons'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'

" numbered tabs
Plugin 'mkitt/tabline.vim'

" python stuff
Plugin 'tmhedberg/SimpylFold'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'davidhalter/jedi-vim'

" go stuff
Plugin 'fatih/vim-go'
""""""""""""""""""""""""""""""""

" initialize plugin system (both required)
call vundle#end()
filetype plugin indent on

" per-plugin settings, one file each in ~/.vim/config. sourced here rather than auto-loaded
" from ~/.vim/plugin, since some (e.g. jedi) must be set before `syntax enable` below
for s:f in sort(glob('~/.vim/config/*.vim', 0, 1))
    execute 'source' fnameescape(s:f)
endfor


""""""""""""""""""""""""""""""
" --> LANGUAGES/PYTHON
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python set colorcolumn=100

au FileType python map <buffer> F :set foldmethod=indent<cr>

au FileType python inoremap <buffer> $r return 
au FileType python inoremap <buffer> $i import 
au FileType python inoremap <buffer> $p print 
au FileType python inoremap <buffer> $f # --- <esc>a
au FileType python map <buffer> <leader>1 /class 
au FileType python map <buffer> <leader>2 /def 
au FileType python map <buffer> <leader>C ?class 
au FileType python map <buffer> <leader>D ?def 

" enable folding with the spacebar
" future me: if all your folds get closed again you're looking for zr
nnoremap <space> za 

" remember which folds are open/closed (and the cursor position) per file. saved when the
" file leaves its window, restored when it's opened again. views live in ~/.vim/view
set viewoptions=folds,cursor
augroup remember_folds
    au!
    au BufWinLeave ?* if &buftype ==# '' | silent! mkview | endif
    au BufWinEnter ?* if &buftype ==# '' | silent! loadview | endif
augroup END

" Press F4 to toggle highlighting on/off, and show current value.
":noremap <F4> :set hlsearch! hlsearch?<CR>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> GENERAL
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=500 " how many lines of history VIM has to remember
set backspace=indent,eol,start

" enable filetype plugins
filetype plugin on
filetype indent on

" shift key is hard
:command Q q
:command W w
:command WQ wq
:command Wq wq

" when splitting, keep the current file in place
set splitbelow
set splitright


" show highlighting group (if any) of the cell under the cursor
:command Hi echo synIDattr(synID(line('.'), col('.'), 1), 'name')


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> DISPLAY/UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nu
set wildmenu " turn on wild menu

" ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

set ruler " always show current position
set cmdheight=1 " height of cmd bar
set scrolloff=999 " keep window centered on cursor position

set hlsearch " highlight search results
set incsearch " makes search act like modern browsers

set showtabline=2 " always show tab menu


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> DISPLAY/COLORS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256
"set termguicolors
syntax enable

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

hi Comment ctermfg=8
hi Error ctermfg=Black ctermbg=1
hi ErrorMsg ctermfg=Black
hi Visual ctermbg=5 
hi LineNr ctermfg=8

" closed folds (all filetypes). currently vim's defaults: 1/red text on 7/white
hi Folded ctermfg=Black ctermbg=8

" fun fact: when painting the cell under a block cursor, winterminal draws the
" foreground (i.e. the character itself) using the cell's *background* color.
"
" then, when it detects foreground and background are the same, it darkens the
" cursor background.
"
" this means the only way to get matching paren highlighting is to modify vim
" to not highlight the paren under the cursor, and to set MatchParen to match
" your cursor color.
"
" because that's some bullshit --> set it to a green that's a closeish match
" to my cursor green (they will match when you switch panes in tmux)
hi MatchParen ctermbg=10 ctermfg=Black " match cursorColor (#A1EFD3) in winterminal settings.json

set encoding=utf8 " set utf8 as standard encoding and en_US as the standard language


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> DISPLAY/TEXT
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tabs --> spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set expandtab
set smarttab


au BufNewFile,BufRead *.py
    \ set textwidth=100 |
    \ set fileformat=unix


""""""""""""""""""""""""""""""
" --> DISPLAY/STATUS-LINE
""""""""""""""""""""""""""""""
set laststatus=2 " always show the status line


