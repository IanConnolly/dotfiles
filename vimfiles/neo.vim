if has('nvim')
  tnoremap <C-a> <C-\><C-n>
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

  augroup Terminal
    autocmd!
    autocmd TermOpen * setlocal nolist nospell noshowmode
  augroup END
endif
