function! Load(path)
  if filereadable(glob(a:path))
    exec "source " . a:path
  endif
endfunction

function! Vimfiles(file)
  if exists("g:vimfiles_path")
    return g:vimfiles_path . a:file
  endif

  return "~/dotfiles/vimfiles/" . a:file
endfunction

function! PluginLoaded(plugin)
  if a:plugin == 'vim-plug'
    if has('nvim')
      return exists("$HOME/nvim/autoload/plug.vim")
    else
      return exists("$HOME/.vim/autoload/plug.vim")
    end
  elseif PluginLoaded('vim-plug')
    return has_key(g:plugs, a:plugin) && PluginInstalled(a:plugin)
  else
    return &rtp =~ a:plugin && PluginInstalled(a:plugin)
  endif
endfunction

function! PluginInstalled(plugin)
  return isdirectory(glob(g:plugin_path . '/' . a:plugin))
endfunction

function! PluginDirectory(plugin)
  let directories = split(&rtp, ",")

  for dir in directories
    if dir =~ a:plugin
      return dir
    endif
  endfor

  return ""
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

function! TryWithDefault(cmd, default)
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
