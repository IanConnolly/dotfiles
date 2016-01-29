let g:gruvbox_contrast_dark = 'hard'
let g:qs_first_occurrence_highlight_color = '#fabd2f'

set background=dark
colorscheme gruvbox

"Gutter colours
highlight SignColumn ctermbg=black guibg=#1d2021
highlight lineNr ctermbg=black guibg=#1d2021
highlight GitGutterAdd ctermbg=black guibg=#1d2021 guifg=#b8bb26
highlight GitGutterChange ctermbg=black guibg=#1d2021 guifg=#83a598
highlight GitGutterDelete ctermbg=black guibg=#1d2021 guifg=#fb4934
highlight GitGutterChangeDelete ctermbg=black guibg=#1d2021 guifg=#fe8019
highlight ModeMsg ctermfg=213 guifg=#b8bb26

highlight StatusLine ctermfg=white ctermbg=236 guibg=#fdf4c1 guifg=#282828
highlight StatusLineNC ctermfg=white ctermbg=236 guibg=#504945 guifg=#282828
highlight VertSplit ctermfg=white ctermbg=236 guibg=#282828

highlight User1 ctermfg=110 ctermbg=236 guifg=#83a598 guibg=#282828
highlight User2 ctermfg=203 ctermbg=236 guibg=#282828 guifg=#fb4934
highlight User3 ctermfg=213 ctermbg=236 guibg=#282828 guifg=#d3869b
highlight User4 guibg=#282828 guifg=#fe8019
highlight User5 guibg=#282828 guifg=#b8bb26

let g:terminal_background = "#1d2021"
let g:terminal_foreground = "#f9f5d7"
let g:terminal_color_0 = "#7c6f64"
let g:terminal_color_1 = "#fb4934"
let g:terminal_color_2 = "#fe8019"
let g:terminal_color_3 = "#7c6f64"
let g:terminal_color_4 = "#83a598"
let g:terminal_color_5 = "#8ec07c"
let g:terminal_color_6 = "#8ec07c"
let g:terminal_color_7 = "#7c6f64"
let g:terminal_color_8 = "#ebdbb2"
let g:terminal_color_9 = "#d3869b"
let g:terminal_color_10 = "#b8bb26"
let g:terminal_color_11 = "#b8bb26"
let g:terminal_color_12 = "#fb4934"
let g:terminal_color_13 = "#fabd2f"
let g:terminal_color_14 = "#b8bb26"
let g:terminal_color_15 = "#b8bb26"

augroup GutterColourSet
  autocmd!
  autocmd ColorScheme * highlight SignColumn ctermbg=black guibg=#1d2021
  autocmd ColorScheme * highlight lineNr ctermbg=black guibg=#1d2021
  autocmd ColorScheme * highlight GitGutterAdd ctermbg=black guibg=#1d2021 guifg=#b8bb26
  autocmd ColorScheme * highlight GitGutterChange ctermbg=black guibg=#1d2021 guifg=#83a598
  autocmd ColorScheme * highlight GitGutterDelete ctermbg=black guibg=#1d2021 guifg=#fb4934
  autocmd ColorScheme * highlight GitGutterChangeDelete ctermbg=black guibg=#1d2021 guifg=#fe8019
  autocmd ColorScheme * highlight ModeMsg ctermfg=213 guifg=#b8bb26
  autocmd ColorScheme * highlight StatusLine ctermfg=white ctermbg=236 guibg=#fdf4c1 guifg=#282828
  autocmd ColorScheme * highlight User1 ctermfg=110 ctermbg=236 guifg=#83a598 guibg=#282828
  autocmd ColorScheme * highlight User2 ctermfg=203 ctermbg=236 guibg=#282828 guifg=#fb4934
  autocmd ColorScheme * highlight User3 ctermfg=213 ctermbg=236 guibg=#282828 guifg=#d3869b
  autocmd ColorScheme * highlight StatusLine ctermfg=white ctermbg=236 guifg=#282828 guibg=#fdf4c1
  autocmd ColorScheme * highlight StatusLineNC ctermfg=white ctermbg=236 guifg=#282828 guibg=#504945
  autocmd ColorScheme * highlight VertSplit ctermfg=white ctermbg=236 guibg=#282828
augroup END

