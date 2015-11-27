if has('nvim')
  tnoremap <esc><esc> <C-\><C-n>
endif

" don't want to do autocmd unless its async
if has('nvim') && PluginLoaded('neomake')
  augroup Neomake
    autocmd!
    autocmd BufWritePost * Neomake
  augroup END
endif
