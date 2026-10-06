"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> PLUGINS/AIRLINE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_theme='embark'
let g:airline_powerline_fonts = 1

" hide empty sections (e.g. b outside git) instead of drawing bare separators
let g:airline_skip_empty_sections = 1

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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> SECTION A --> MODE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" rebuild default A section unbolded (bc winterm draws bold colors 0-7 as 8-15)
function! AirlineSectionA()
    call airline#parts#define_function('mode_plain', 'airline#parts#mode')
    let g:airline_section_a = airline#section#create_left(['mode_plain', 'crypt', 'paste', 'keymap', 'spell', 'capslock', 'xkblayout', 'iminsert', 'executable'])
endfunction
autocmd User AirlineAfterInit call AirlineSectionA()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> SECTION B --> FILE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" filetype icon (vim-devicons' own airline additions are off, see devicons.vim), then
" modified flag [+] + path relative to cwd
let g:airline_section_b = "%{WebDevIconsGetFileTypeSymbol()} %m %F"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> SECTION C
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" empty: airline skips it, so the bar's fill takes B's colors
let g:airline_section_c = ''


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> SECTION X --> ENCODING
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" file encoding, only when not utf-8 (empty means 'encoding', i.e. utf-8)
function! AirlineFenc()
    return &fenc ==# 'utf-8' || empty(&fenc) ? '' : &fenc
endfunction
function! AirlineSectionX()
    call airline#parts#define_function('fenc_non_utf8', 'AirlineFenc')
    let g:airline_section_x = airline#section#create_right(['fenc_non_utf8'])
endfunction
autocmd User AirlineAfterInit call AirlineSectionX()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> SECTION Y --> GIT
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gitgutter hunks + branch (airline's default section B)
function! AirlineSectionY()
    let g:airline_section_y = airline#section#create_right(['hunks', 'branch'])
endfunction
autocmd User AirlineAfterInit call AirlineSectionY()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> SECTION Z --> POSITION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" line/total/column (no file %) unbolded like section A (e.g. 5/6≡ 16℅)

function! AirlineSectionZ()
    call airline#parts#define_raw('linenr_plain', '%{g:airline_symbols.linenr}%2l')
    call airline#parts#define_raw('maxlinenr_plain', '/%L%{g:airline_symbols.maxlinenr}')
    call airline#parts#define_raw('colnr_suffix', '%v' . "\u2105")
    let g:airline_section_z = airline#section#create(['windowswap', 'obsession', 'linenr_plain', 'maxlinenr_plain', 'colnr_suffix'])
endfunction
autocmd User AirlineAfterInit call AirlineSectionZ()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> SECTION W --> WHITESPACE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" no icon or leading space, shortened labels
" --> padding space removed in patched ~/.vim/autoload/airline/extensions/default.vim
"   --> delete it to revert
" --> MIXED*: first line breaking file's indent style
"   --> default: [tabs:spaces] next tab/space-indented lines after cursor

let g:airline#extensions#whitespace#symbol = ''
let g:airline#extensions#whitespace#trailing_format = '[%s]TRAIL'
let g:airline#extensions#whitespace#mixed_indent_format = '[%s]MIXED'
let g:airline#extensions#whitespace#mixed_indent_file_format = '[%s]MIXED*'

function! AirlineWhitespace()
    let l:check = airline#extensions#whitespace#check()
    " strip icon here too: airline reads symbol setting only on first load
    let l:icon = '\V' . escape(g:airline_symbols.whitespace, '\') . '\m'
    let l:check = substitute(l:check, '^' . l:icon . '\%(\s\|\%u00a0\)*', '', '')
    if l:check !~# '\]MIXED\*'
        return l:check
    endif
    if get(b:, 'mixed_first_tick', -1) != b:changedtick
        let l:lines = getline(1, '$')
        let b:mixed_first = max([match(l:lines, '^\t') + 1, match(l:lines, '^ ') + 1])
        let b:mixed_first_tick = b:changedtick
    endif
    return substitute(l:check, '\[\d\+:\d\+\]MIXED\*', '[' . b:mixed_first . ']MIXED*', '')
endfunction

" use wrapper above in place of airline's check
function! AirlineSectionWarning()
    let g:airline_section_warning = '%{airline#util#wrap(AirlineWhitespace(),0)}'
endfunction
autocmd User AirlineAfterInit call AirlineSectionWarning()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> COLORS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" embark palette: hex per color index 0-15 (same list as ~/.vim/after/syntax/python.vim)
let s:hex = [
    \ '#1E1C31', '#F48FB1', '#A1EFD3', '#FFE6B3', '#91DDFF', '#D4BFFF', '#87DFEB', '#CBE3E7',
    \ '#585273', '#F02E6E', '#62D196', '#F2B482', '#65B2FF', '#A37ACC', '#63F2F1', '#D4BFFF',
\]

" applies section A/Z mode colors (below), B/Y green and C text color
function! AirlineThemePatch(palette)
    if g:airline_theme !=# 'embark'
        return
    endif

    " embark has no commandline palette --> airline falls back to normal
    if !has_key(a:palette, 'commandline')
        let a:palette.commandline = deepcopy(a:palette.normal)
    endif

    " no VISUAL LINE palette in airline either --> AirlineVisualLine() below switches to it
    let a:palette.visual_line = deepcopy(a:palette.visual)
    if has_key(a:palette, 'visual_modified')
        let a:palette.visual_line_modified = deepcopy(a:palette.visual_modified)
    endif

    for [mode, color] in items(s:mode_colors)
        for section in ['airline_a', 'airline_z']
            if has_key(a:palette, mode) && has_key(a:palette[mode], section)
                " copy first: the theme shares section lists between modes
                let a:palette[mode][section] = copy(a:palette[mode][section])
                let a:palette[mode][section][0] = s:hex[color.fg]
                let a:palette[mode][section][1] = s:hex[color.bg]
                let a:palette[mode][section][2] = color.fg
                let a:palette[mode][section][3] = color.bg
            endif
        endfor
    endfor

    " section B: 5/purple text on 8/brightBlack, in every palette entry
    for mode in keys(a:palette)
        if has_key(a:palette[mode], 'airline_b')
            let a:palette[mode].airline_b = copy(a:palette[mode].airline_b)
            let a:palette[mode].airline_b[0] = s:hex[5]
            let a:palette[mode].airline_b[1] = s:hex[8]
            let a:palette[mode].airline_b[2] = 5
            let a:palette[mode].airline_b[3] = 8
        endif
    endfor

    " section C: 5/purple text on 0/black, in every palette entry
    for mode in keys(a:palette)
        if has_key(a:palette[mode], 'airline_c')
            let a:palette[mode].airline_c = copy(a:palette[mode].airline_c)
            let a:palette[mode].airline_c[0] = s:hex[5]
            let a:palette[mode].airline_c[1] = s:hex[0]
            let a:palette[mode].airline_c[2] = 5
            let a:palette[mode].airline_c[3] = 0
        endif
    endfor

    " section X: 0/black background, in every palette entry
    for mode in keys(a:palette)
        if has_key(a:palette[mode], 'airline_x')
            let a:palette[mode].airline_x = copy(a:palette[mode].airline_x)
            let a:palette[mode].airline_x[1] = s:hex[0]
            let a:palette[mode].airline_x[3] = 0
        endif
    endfor

    " section Y: 0/black text on 2/green, in active modes
    for mode in ['normal', 'insert', 'visual', 'visual_line', 'replace', 'commandline']
        if has_key(a:palette, mode) && has_key(a:palette[mode], 'airline_y')
            let a:palette[mode].airline_y = copy(a:palette[mode].airline_y)
            let a:palette[mode].airline_y[0] = s:hex[0]
            let a:palette[mode].airline_y[1] = s:hex[2]
            let a:palette[mode].airline_y[2] = 0
            let a:palette[mode].airline_y[3] = 2
        endif
    endfor
endfunction
let g:airline_theme_patch_func = 'AirlineThemePatch'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --> VIM MODE COLORS (SECTIONS A/Z)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" sections A and Z text (fg) and background (bg) per mode, as palette index 0-15
" visual = VISUAL + VISUAL BLOCK. inactive windows keep the theme's colors
let s:mode_colors = {
    \ 'normal':      {'fg': 0, 'bg': 10},
    \ 'insert':      {'fg': 0, 'bg': 4},
    \ 'visual':      {'fg': 0, 'bg': 5},
    \ 'visual_line': {'fg': 0, 'bg': 13},
    \ 'replace':     {'fg': 0, 'bg': 12},
    \ 'commandline': {'fg': 0, 'bg': 7},
\}

" airline colors v, V and ctrl-v all as 'visual'; re-color after it on visual mode changes
function! AirlineVisualLine()
    if !exists('g:loaded_airline') || mode() !~# '^[vV\x16]'
        return
    endif
    call airline#check_mode(winnr())
    " airline's group list for this window, e.g. ['visual', 'modified']
    let l:groups = split(get(w:, 'airline_lastmode', 'visual'))
    let l:groups[0] = mode() ==# 'V' ? 'visual_line' : 'visual'
    call airline#highlighter#highlight(l:groups, string(bufnr('%')))
endfunction
augroup airline_visual_line
    au!
    au ModeChanged * call AirlineVisualLine()
augroup END
