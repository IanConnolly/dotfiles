" Color palette
let s:cterm_white = 255

let s:gui_dark_gray = '#303030'
let s:cterm_dark_gray = 236
let s:gui_med_gray_hi = '#444444'
let s:cterm_med_gray_hi = 238
let s:gui_med_gray_lo = '#3a3a3a'
let s:cterm_med_gray_lo = 237
let s:gui_light_gray = '#b2b2b2'
let s:cterm_light_gray = 249
let s:gui_green = '#afd787'
let s:cterm_green = 150
let s:gui_blue = '#87afd7'
let s:cterm_blue = 110
let s:gui_purple = '#afafd7'
let s:cterm_purple = 213
let s:gui_orange = '#d7af5f'
let s:cterm_orange = 179
let s:gui_red = '#d78787'
let s:cterm_red = 203
let s:gui_pink = '#d7afd7'
let s:cterm_pink = 182

let g:airline#themes#ianline#palette = {}

" Normal mode
let s:N1 = [s:gui_dark_gray, s:gui_blue, s:cterm_dark_gray, s:cterm_blue]
let s:N2 = [s:gui_light_gray, s:gui_med_gray_lo, s:cterm_white, s:cterm_med_gray_lo]
let s:N3 = [s:gui_blue, s:gui_med_gray_hi, s:cterm_blue, s:cterm_med_gray_hi]
let g:airline#themes#ianline#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#ianline#palette.normal_modified = {
      \ 'airline_c': [s:gui_orange, s:gui_med_gray_hi, s:cterm_orange, s:cterm_med_gray_hi, ''],
      \ }

" Insert mode
let s:I1 = [s:gui_med_gray_hi, s:gui_red, s:cterm_dark_gray, s:cterm_red]
let s:I3 = [s:gui_red, s:gui_med_gray_hi, s:cterm_red, s:cterm_med_gray_hi]
let g:airline#themes#ianline#palette.insert = airline#themes#generate_color_map(s:I1, s:N2, s:I3)
let g:airline#themes#ianline#palette.insert_modified = copy(g:airline#themes#ianline#palette.normal_modified)
let g:airline#themes#ianline#palette.insert_paste = {
      \ 'airline_a': [s:gui_dark_gray, s:gui_orange, s:cterm_dark_gray, s:cterm_orange, ''],
      \ }

" Replace mode
let g:airline#themes#ianline#palette.replace = {
      \ 'airline_a': [s:gui_dark_gray, s:gui_green, s:cterm_dark_gray, s:cterm_green, ''],
      \ 'airline_c': [s:gui_green, s:gui_med_gray_hi, s:cterm_green, s:cterm_med_gray_hi, ''],
      \ }
let g:airline#themes#ianline#palette.replace_modified = copy(g:airline#themes#ianline#palette.insert_modified)

" Visual mode
let s:V1 = [s:gui_dark_gray, s:gui_purple, s:cterm_dark_gray, s:cterm_purple]
let s:V3 = [s:gui_purple, s:gui_med_gray_hi, s:cterm_purple, s:cterm_med_gray_hi]
let g:airline#themes#ianline#palette.visual = airline#themes#generate_color_map(s:V1, s:N2, s:V3)
let g:airline#themes#ianline#palette.visual_modified = copy(g:airline#themes#ianline#palette.insert_modified)

" Inactive window
let s:IA = [s:gui_light_gray, s:gui_med_gray_hi, s:cterm_light_gray, s:cterm_med_gray_hi, '']
let g:airline#themes#ianline#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)
let g:airline#themes#ianline#palette.inactive_modified = {
      \ 'airline_c': [s:gui_orange, '', s:cterm_orange, '', ''],
      \ }

