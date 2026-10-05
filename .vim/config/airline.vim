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
