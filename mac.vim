if has('mac')
  " Search current word in Dash.app
  if isdirectory('/Applications/Dash.app') && PluginLoaded('dash')
    nmap <silent> <Leader>d <Plug>DashSearch
  endif

  " Otherwise vim will get nasty escape codes
  if $TERM == 'xterm-256color' || $TERM == 'screen-256color'
    map <Esc>OP <F1>
    map <Esc>OQ <F2>
    map <Esc>OR <F3>
    map <Esc>OS <F4>
    map <Esc>[16~ <F5>
    map <Esc>[17~ <F6>
    map <Esc>[18~ <F7>
    map <Esc>[19~ <F8>
    map <Esc>[20~ <F9>
    map <Esc>[21~ <F10>
    map <Esc>[23~ <F11>
    map <Esc>[24~ <F12>
  endif
endif
