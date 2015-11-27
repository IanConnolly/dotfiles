if get(g:, "pair_programming", 0)
  set backspace=indent,eol,start
  set mouse=a

  for modeprefix in ['i', 'n', 'v']
    for arrowkey in ['<Up>', '<Down>', '<Left>', '<Right>']
      execute modeprefix . "unmap " . arrowkey
    endfor
  endfor
else
  set backspace=indent,eol
  set mouse=

  for modeprefix in ['i', 'n', 'v']
    for arrowkey in ['<Up>', '<Down>', '<Left>', '<Right>']
      execute modeprefix . "noremap " . arrowkey . " <Nop>"
    endfor
  endfor
endif
