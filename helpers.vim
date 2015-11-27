function! Load(path)
  if filereadable(glob(a:path))
    exec "source " . a:path
  endif
endfunction

function! Dotfiles(file)
  if exists("g:dotfiles_path")
    return g:dotfiles_path . a:file
  endif

  return "~/dotfiles/" . a:file
endfunction

function! PluginLoaded(plugin)
  if a:plugin == "vim-plug"
    return exists("$HOME/.vim/autoload/plug.vim")
  else
    return &rtp =~ a:plugin
  endif
endfunction

function! NumberToggle()
  if (&relativenumber == 1)
    set nocursorline
    set norelativenumber
    set number
  else
    set nonumber
    set relativenumber
    set cursorline
  endif
endfunction

" Trim trailing whitespace
function! TrimWhitespace()
  let l = line('.')
  let c = col('.')
  %s/\s\+$//e
  call cursor(l, c)
endfunction

" Deletes the persistent undo file for the current buffer
function! DeleteUndoFile()
  let current_undo_file = undofile(expand("%"))
  call delete(current_undo_file)

  if glob(current_undo_file) == ""
    echohl WarningMsg
    echo 'Undofile "'. fnamemodify(current_undo_file, ":."). '" was deleted!'
    echohl None
  endif
endfunction

function! GenerateSnapshot()
  " TODO: Template this
  let directory = expand('~/dotfiles/snapshots')
  call system('mkdir -p ' . directory)
  let date = strftime("%Y-%m-%d")
  let new_count = substitute(substitute(system('ls ' . directory . ' | grep ' . date . ' | wc -l'), '[^0-9]*', '', ''), '\v\n', '', '') + 1
  let file_name = directory . '/' . date . '-' . new_count . '.sh'

  execute 'PlugSnapshot ' . file_name
endfunction

function! s:try(cmd, default)
  if exists(':' . a:cmd) && !v:count
    let tick = b:changedtick
    execute a:cmd
    if tick == b:changedtick
      execute join(['normal!', a:default])
    endif
  else
    execute join(['normal! ', v:count, a:default], '')
  endif
endfunction
