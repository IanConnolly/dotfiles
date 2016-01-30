if has('nvim')
  tnoremap <C-a> <C-\><C-n>

  let g:neomake_rust_cargo_maker = {
          \ 'args': ['check'],
          \ 'errorformat':
              \ '%-G%f:%s:,' .
              \ '%f:%l:%c: %trror: %m,' .
              \ '%f:%l:%c: %tarning: %m,' .
              \ '%f:%l:%c: %m,'.
              \ '%f:%l: %trror: %m,'.
              \ '%f:%l: %tarning: %m,'.
              \ '%f:%l: %m',
          \ }
  let g:neomake_rust_enabled_makers = ['cargo']

  let $FZF_DEFAULT_OPTS .= ' --inline-info'

  " don't want to do autocmd unless its async
  if PluginLoaded('neomake')
    augroup Neomake
      autocmd!
      autocmd BufWritePost *.rb Neomake
      autocmd BufWritePost *.rs Neomake! cargo
    augroup END
  endif

  augroup Terminal
    autocmd!
    autocmd TermOpen * setlocal nolist nospell
  augroup END

  " set colors
  let g:terminal_background = "#1d2021"
  let g:terminal_foreground = "#f9f5d7"
  let g:terminal_color_0    = "#7c6f64"
  let g:terminal_color_1    = "#fb4934"
  let g:terminal_color_2    = "#fe8019"
  let g:terminal_color_3    = "#7c6f64"
  let g:terminal_color_4    = "#83a598"
  let g:terminal_color_5    = "#8ec07c"
  let g:terminal_color_6    = "#8ec07c"
  let g:terminal_color_7    = "#7c6f64"
  let g:terminal_color_8    = "#ebdbb2"
  let g:terminal_color_9    = "#d3869b"
  let g:terminal_color_10   = "#b8bb26"
  let g:terminal_color_11   = "#b8bb26"
  let g:terminal_color_12   = "#fb4934"
  let g:terminal_color_13   = "#fabd2f"
  let g:terminal_color_14   = "#b8bb26"
  let g:terminal_color_15   = "#b8bb26"
endif
