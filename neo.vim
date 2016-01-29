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
endif
