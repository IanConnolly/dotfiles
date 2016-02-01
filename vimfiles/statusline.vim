function! NumberSection()
  return ' %3*%n%0*' " buffer number
endfunction

function! LeftSep()
  return '%1* » %0*'
endfunction

function! RightSep()
  return '%1* « %0*'
endfunction

function! FileModes()
  let fm = '%2*'

  if &modified
    let fm.= '  +'
  endif

  if &readonly
    let fm.= '   '
  endif

  if &paste
    let fm.= '  P'
  endif

  if get(b:, 'capslock', 0) > 0
    let fm.= '  '
  endif

  if bufname("%") =~ "scp://"
    let fm.= '  '
  endif

  let fm.= '%0*'

  return fm
endfunction

function! LeftSide()
  let ls = ''
  let ls.= NumberSection()
  let ls.= LeftSep()
  let ls.= '%f' " file name
  let ls.= RightSep()
  let ls.= FileModes()

  return ls
endfunction

function! RightSide()
  let rs = ''

  if get(g:, 'vs_open', 0)
    let rs .= '%5*'
    let rs .= 'TP:Open'
    let rs .= '%0*'
    let rs .= ' '
  elseif bufname("%") =~ '_spec.rb'
    let rs .= '%4*'
    let rs .= 'TP:Closed'
    let rs .= '%0*'
    let rs .= ' '
  endif

  if exists ("neomake#statusline#LoclistStatus")
    let errors = neomake#statusline#LoclistStatus()
    if errors =~ 'E'
      let rs .= "%2*"
      let rs .= errors
    else
      let rs .= "%4*"
      let rs .= errors
    endif
    let rs .= "%0*"
    let rs .= " "
  endif

  if exists('*fugitive#head')
    let head = fugitive#head()

    if !empty(head)
      let rs .= '%1* ' . "" . '%0* ' . head . ' '
    endif
  endif

  return rs
endfunction

function! StatusLine()
  let statusl = LeftSide()
  let statusl.= '%='
  let statusl.= RightSide()

  return statusl
endfunction

set statusline=%!StatusLine()
