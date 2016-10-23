if has('nvim')
  tnoremap <C-a> <C-\><C-n>
  let $FZF_DEFAULT_OPTS .= ' --inline-info'

  augroup Terminal
    autocmd!
    autocmd TermOpen * setlocal nolist nospell noshowmode
  augroup END
endif
