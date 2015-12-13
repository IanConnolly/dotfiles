if has('nvim')
  tnoremap <esc><esc> <C-\><C-n>

  " don't want to do autocmd unless its async
  if PluginLoaded('neomake')
    augroup Neomake
      autocmd!
      autocmd BufWritePost * Neomake
    augroup END
  endif

  augroup Terminal
    autocmd!
    autocmd TermOpen * setlocal nolist nospell
  augroup END
endif
