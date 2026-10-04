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
" initialize plugin system
""""""""""""""""""""""""""""""""

call vundle#end()            " required
filetype plugin indent on    " required


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> PLUGINS/AIRLINE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_theme='embark'

let g:airline_powerline_fonts = 1
let g:airline_section_c = '%F'

" hide empty sections (e.g. b outside git) instead of drawing bare separators
let g:airline_skip_empty_sections = 1 
"let g:airline_section_z = airline#section#create('%4l/%L,%3v')

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" line number section: drop default file percentage ('%p%%')
" show the column as '16℅' instead of '℅:16'
" parts only exist after airline initializes, so build the section then
function! AirlineSectionZ()
    call airline#parts#define('colnr_suffix', {'raw': '%v' . "\u2105", 'accent': 'bold'})
    let g:airline_section_z = airline#section#create(['windowswap', 'obsession', 'linenr', 'maxlinenr', 'colnr_suffix'])
endfunction
autocmd User AirlineAfterInit call AirlineSectionZ()

" sections b and y background: 2/embark green (same as tmux cpu/ram section)
" applies to all active modes; inactive windows keep the theme's colors
function! AirlineThemePatch(palette)
    if g:airline_theme !=# 'embark'
        return
    endif
    for mode in ['normal', 'insert', 'visual', 'replace']
        for section in ['airline_b', 'airline_y']
            if has_key(a:palette, mode) && has_key(a:palette[mode], section)
                let a:palette[mode][section][1] = '#A1EFD3'
                let a:palette[mode][section][3] = 2
            endif
        endfor
    endfor
endfunction
let g:airline_theme_patch_func = 'AirlineThemePatch'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> PLUGINS/JEDI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let jedi#show_call_signatures = 0


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
\]
let g:NERDTreeWinSize = 40
let g:NERDTreeMinimalUI = 1

" bookmarks
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeBookmarksSort = 0
let g:NERDTreeMarkBookmarks = 0

nnoremap n :NERDTreeToggle<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> PLUGINS/NERDTREE/VIM-DEVICONS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:webdevicons_conceal_nerdtree_brackets = 1


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
let g:nerdtree_tabs_open_on_console_startup = 0 "   --> open nerdtree upon vim startup
let g:nerdtree_tabs_focus_on_files = 1 "            --> always focus on file when switching tabs
let g:nerdtree_tabs_autofind = 1 "                  --> auto find+select currently opened file in nerdtree


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
" --> DISPLAY/COLORS-FONTS
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
hi Visual ctermbg=7 ctermfg=Black
hi Comment ctermfg=8

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


""""""""""""""""""""""""""""""
" --> LANGUAGES/PYTHON
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self
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

nnoremap <space> za " enable folding with the spacebar
let g:SimpylFold_docstring_preview=1

" Press F4 to toggle highlighting on/off, and show current value.
":noremap <F4> :set hlsearch! hlsearch?<CR>
