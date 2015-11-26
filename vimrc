filetype off
runtime macros/matchit.vim

if has('nvim')
  call plug#begin('~/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif

Plug 'tpope/vim-sensible'         " In case I've missed something

" Vim layout + window related fun
Plug 'tpope/vim-vinegar'           " cleanup netrw
Plug 'mbbill/undotree'             " View undo history as tree
Plug 'mhinz/vim-sayonara'          " Sanely quit buffers/windows etc.
Plug 'tpope/vim-capslock'          " Software capslock
Plug 'romainl/vim-qf'              " Tame quickfix
Plug 'junegunn/vim-peekaboo'       " Hijack register mappings
Plug 'mhinz/vim-grepper'           " Async grepprg

" FZF base + FZF vim helpers
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' } | Plug 'junegunn/fzf.vim'

" Integrations
Plug 'IanConnolly/differ'                 " Async git gutter
Plug 'tpope/vim-rails'                    " Helpful rails related shortcuts
Plug 'tpope/vim-rake'                     " The general ruby bits of vim-rails
Plug 'tpope/vim-fugitive'                 " Git command wrappers

if executable('tmux')
  Plug 'tmux-plugins/vim-tmux-focus-events' " FocusGained etc. in tmux!
  Plug 'benmills/vimux'                     " Use vimux to open commands in special tmux pane
endif

if has('mac') && isdirectory('/Applications/Dash.app')
  Plug 'rizzatti/dash.vim'                  " Integrate with Dash.app
endif

" Typing/Autocomplete support
Plug 'benekastah/neomake'                  " Neovim async syntax checker
Plug 'jiangmiao/auto-pairs'                " Automatically pair quotes, braces etc.
Plug 'tpope/vim-endwise'                   " Insert 'end' in ruby as smartly as braces
Plug 'ajh17/VimCompletesMe'                " Super lightweight smart-tab for ins-completion
Plug 'unblevable/quick-scope'              " highlight in-line f/F/t/T motions

" Movement/Text-alteration
Plug 'tpope/vim-surround'          " Easily deal with surrounding quotes
Plug 'tpope/vim-commentary'        " Comment/uncomment textobjs
Plug 'tpope/vim-unimpaired'        " Collection of paired commands
Plug 'tpope/vim-repeat'            " repeat surround/comment/unimpaired actions
Plug 'AndrewRadev/splitjoin.vim'   " gS/gJ to switch single/multiline block

" Text objs
Plug 'wellle/targets.vim'          " New text objs
" User-defined text objs + erb objs + ruby objs
Plug 'kana/vim-textobj-user' | Plug 'whatyouhide/vim-textobj-erb' | Plug 'tek/vim-textobj-ruby'
Plug 'qstrahl/vim-dentures'        " indentation obj

" Colors
Plug 'IanConnolly/gruvbox'              " gruvbox fork for ruby

" Daily work languages
Plug 'kchmck/vim-coffee-script'
Plug 'othree/html5.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'vim-ruby/vim-ruby'

Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

call plug#end()

filetype plugin indent on

function! PluginLoaded(plugin)
  if a:plugin == "vim-plug"
    return exists("$HOME/.vim/autoload/plug.vim")
  else
    return &rtp =~ a:plugin
  endif
endfunction

let g:gruvbox_contrast_dark = 'hard'

" Config for plugins

" vim-ruby highlight operators
let ruby_operators = 1

" Delay the peekaboo window a bit so we can yank without jank
let g:peekaboo_delay = 250

" Neomake
let g:neomake_ruby_enabled_makers = ['mri']
let g:neomake_open_list = 0

" Ack.vim style quickfix mappings
let g:qf_mapping_ack_style = 1

" Only enable quick-scope after f/F/t/T
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" AutoPairs binds to Meta by default for whatever reason, we don't want that
" on OSX
let g:AutoPairsShortcutFastWrap = '<C-e>'

" Hide hidden files + folders
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_bufsettings = 'noma nomod nonu nobl nowrap ro'
let g:netrw_bufsettings .= ' buftype=nofile bufhidden=wipe'

" TODO: remove hardcoded paths
let g:racer_cmd = expand("$HOME/racer/target/release/racer")
let g:cargo_command = "make <subcommand>"
let $RUST_SRC_PATH = expand("$HOME/rust/src/")
let g:syntastic_rust_clippy_post_args = ['--release', '--', '-Dclippy', '-Wclippy_pedantic']

" Vim Settings
let mapleader=" "                   " Space for leader is so satisfying
syntax on
set background=dark

if PluginLoaded('gruvbox')
  colorscheme gruvbox
else
  colorscheme desert
endif

" Command behaviour
set showcmd
set noshowmode
set laststatus=2

" Text-y stuff
set backspace=indent,eol,start      " backspace everything
set shiftround                      " 'h' and 'l' will wrap around lines
set whichwrap+=<,>,h,l

" Gutter number
set number                          " for easier movements
set norelativenumber
set nocursorline

" Tabs
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4

" File-system
set autoread
set noswapfile
set nowritebackup
set nrformats-=octal

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Terminal errors
set noerrorbells
set visualbell

" Key timeouts
set tm=500
set ttimeoutlen=50

" Split opening positions
set splitright
set splitbelow
set fillchars+=vert:\ 

" Screen scrolling behaviour
set scrolloff=10                    " keep cursor relatively centered
set sidescrolloff=10

" Tagfile
set tags=./.tags;

" Showing invisible characters
set listchars=tab:»\ ,extends:›,eol:¬,trail:⋅ " textmate
set showbreak=›››
set list

" Command tab-completion
set wildmenu                        " command auto-completion
set wildmode=list:longest,full

set complete+=kspell
set hidden

set completeopt=menu,menuone " Don't show scratch window

set switchbuf=useopen

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

" show which mode we're in
set showmode

" statusline
set statusline=%!StatusLine()

set updatetime=750

if has("persistent_undo")
  let undoDir = expand('$HOME/.undodir')
  call system('mkdir -p ' . undoDir)
  let &undodir = undoDir
  set undofile
endif

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

function! RunCargo(subcommand)
  execute substitute(g:cargo_command, "<subcommand>", a:subcommand, '')
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

if PluginLoaded('splitjoin')
  nnoremap <silent> J :<C-u>call <SID>try('SplitjoinJoin', 'J')<CR>
  nnoremap <silent> S :<C-u>call <SID>try('SplitjoinSplit', "r\015")<CR>
endif

" god who uses this
map q: :q
nnoremap Q <NOP>

" Fingers are already there...
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>

" Trim trailing whitespace
nnoremap <Leader>tw :call TrimWhitespace()<CR>

" Toggle between relative and static numbering
nnoremap <Leader>nu :call NumberToggle()<CR>

if executable('ag')
  " Integrate with Ag
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column\ --vimgrep
  set grepformat=%f:%l:%c:%m,%f:%l:%m
  nnoremap <Leader>s :Grepper! -noswitch -tool ag -query '\b<C-r><C-w>\b'<CR>
  nnoremap <Leader>ag :Grepper! -tool ag -query ''<Left>
endif

" Undo mappings
if PluginLoaded('undotree')
  nnoremap <Leader>u :UndotreeToggle<CR>
  nnoremap <Leader>du :call DeleteUndoFile()<CR>
endif

" Use Sayonara for quitting
if PluginLoaded('sayonara')
  nnoremap <Leader>x :Sayonara<CR>y<CR>
  nnoremap <Leader>q :w<CR>:Sayonara<CR>
else
  nnoremap <Leader>x :q!<CR>
  nnoremap <Leader>q :wq<CR>
endif

nnoremap <Leader>w :w<CR>
nnoremap <Leader>Q :q!<CR>

" Easily make changes to vimrc
if PluginLoaded('vim-plug')
  nnoremap <Leader>R :so ~/.vimrc<CR>
  nnoremap <Leader>U :PlugInstall<CR>:PlugUpdate<CR>:PlugClean<CR>
  nnoremap <Leader>S :call GenerateSnapshot()<CR>
else
  nnoremap <Leader>R :mapclear!<CR>:so ~/.vimrc<CR>
endif

" Edit the vimrc in a split
command! EV vsplit ~/.vimrc
command! ES split ~/.vimrc

" no need for this to be mac only; can compile from source
if PluginLoaded('fzf')
  nnoremap <C-p> :FZF<CR>
endif

cnoremap %% <C-R>=expand('%:h').'/'<cr>
nmap <Leader>- :edit %%

" vim-fugitive
if PluginLoaded('fugitive')
  nnoremap <Leader>gb :Gblame<CR>
  nnoremap <Leader>gs :Gstatus<CR>
  nnoremap <Leader>gd :Gdiff<CR>
  nnoremap <Leader>gc :Gcommit<CR>
  nnoremap <Leader>gp :Gpush<CR>
  nnoremap <Leader>gl :Glog<CR>:copen<CR>
endif

" FZF
if PluginLoaded('fugitive') && PluginLoaded('fzf.vim')
  nnoremap <Leader>gf :GitFiles<CR>
  nnoremap <Leader>gh :BCommits<CR>
endif

" copy and paste
xnoremap <Leader>c "*y
nnoremap <Leader>p "0p
nnoremap <Leader>P "0P

" Neomake errors
if PluginLoaded('neomake')
  nnoremap <Leader>e :Neomake<CR>:lopen<CR>
endif

set pastetoggle=<F2>
" Don't allow paste mode in normal/visual modes
nnoremap <F2> <NOP>
xnoremap <F2> <NOP>

" Search current word in Dash.app
if has('mac') && isdirectory('/Applications/Dash.app') && PluginLoaded('dash')
  nmap <silent> <Leader>d <Plug>DashSearch
endif

" easily get rid of search highlights
noremap <Esc> :noh<CR><Esc>

" For fuzzy finding thru buffers
if PluginLoaded('fzf.vim')
  nnoremap <Leader><Tab> :Buffers<CR>
endif

" Switch to last active buffer
noremap <Leader><Space> :buffer #<CR>

" Quick jump to buffers
nnoremap <Leader>b :ls<cr>:b<space>

" Quick Esc
inoremap ;; <Esc>:noh<CR>

" Toggle case
nnoremap <Leader>tc g~iw

" More logical
map Y y$

" Use matchit more (unbinds <C-i> as they're the same key)
nmap <Tab> %
xmap <Tab> %

" Be able to jump 'in' jumplist after remap ^
nnoremap <Leader>i <C-i>
" Bind <C-o> for symmetry
nnoremap <Leader>o <C-o>

" Move up and down visual lines, not real (but not when given a count)
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Select last edited/pasted text
nnoremap gV `[v`]

" Select current line char-wise
nnoremap vv ^vg_

" Buhbye accidental help
nnoremap <F1> :nohl<CR><Esc>
xnoremap <F1> :nohl<CR><Esc>
inoremap <F1> :nohl<CR><Esc>

" Change, highlight, repeat
nnoremap ,, *``cgn

" replace all occurences of current word
nnoremap <Leader>ra :%s/\<<C-r>=expand('<cword>')<CR>\>/

" replace occurrences inside this block
nnoremap <Leader>ri :'{,'}s/\<<C-r>=expand('<cword>')<CR>\>/

" Because un-selecting is dumb
xnoremap > >gv
xnoremap < <gv

nnoremap <Leader>l :echo line('.') . "/" . line('$')<CR>

if has('nvim')
  tnoremap <esc><esc> <C-\><C-n>
endif

" Debug colours
command! SS echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')

" Because shift is hard to let go of okay
command! Wq wq
command! WQ wq
command! W w
command! Q q

"Gutter colours
highlight SignColumn ctermbg=black guibg=#1d2021
highlight lineNr ctermbg=black guibg=#1d2021
highlight GitGutterAdd ctermbg=black guibg=#1d2021 guifg=#b8bb26
highlight GitGutterChange ctermbg=black guibg=#1d2021 guifg=#83a598
highlight GitGutterDelete ctermbg=black guibg=#1d2021 guifg=#fb4934
highlight GitGutterChangeDelete ctermbg=black guibg=#1d2021 guifg=#fe8019
highlight ModeMsg ctermfg=213 guifg=#b8bb26

highlight StatusLine ctermfg=white ctermbg=236 guibg=#fdf4c1 guifg=#282828
highlight StatusLineNC ctermfg=white ctermbg=236 guibg=#504945 guifg=#282828
highlight VertSplit ctermfg=white ctermbg=236 guibg=#282828

highlight User1 ctermfg=110 ctermbg=236 guifg=#83a598 guibg=#282828
highlight User2 ctermfg=203 ctermbg=236 guibg=#282828 guifg=#fb4934
highlight User3 ctermfg=213 ctermbg=236 guibg=#282828 guifg=#d3869b
highlight User4 guibg=#282828 guifg=#fe8019

let g:terminal_background = "#1d2021"
let g:terminal_foreground = "#f9f5d7"
let g:terminal_color_0 = "#7c6f64"
let g:terminal_color_1 = "#fb4934"
let g:terminal_color_2 = "#fe8019"
let g:terminal_color_3 = "#7c6f64"
let g:terminal_color_4 = "#83a598"
let g:terminal_color_5 = "#8ec07c"
let g:terminal_color_6 = "#8ec07c"
let g:terminal_color_7 = "#7c6f64"
let g:terminal_color_8 = "#ebdbb2"
let g:terminal_color_9 = "#d3869b"
let g:terminal_color_10 = "#b8bb26"
let g:terminal_color_11 = "#b8bb26"
let g:terminal_color_12 = "#fb4934"
let g:terminal_color_13 = "#fabd2f"
let g:terminal_color_14 = "#b8bb26"
let g:terminal_color_15 = "#b8bb26"

augroup GutterColourSet
  autocmd!
  autocmd ColorScheme * highlight SignColumn ctermbg=black guibg=#1d2021
  autocmd ColorScheme * highlight lineNr ctermbg=black guibg=#1d2021
  autocmd ColorScheme * highlight GitGutterAdd ctermbg=black guibg=#1d2021 guifg=#b8bb26
  autocmd ColorScheme * highlight GitGutterChange ctermbg=black guibg=#1d2021 guifg=#83a598
  autocmd ColorScheme * highlight GitGutterDelete ctermbg=black guibg=#1d2021 guifg=#fb4934
  autocmd ColorScheme * highlight GitGutterChangeDelete ctermbg=black guibg=#1d2021 guifg=#fe8019
  autocmd ColorScheme * highlight ModeMsg ctermfg=213 guifg=#b8bb26
  autocmd ColorScheme * highlight StatusLine ctermfg=white ctermbg=236 guibg=#fdf4c1 guifg=#282828
  autocmd ColorScheme * highlight User1 ctermfg=110 ctermbg=236 guifg=#83a598 guibg=#282828
  autocmd ColorScheme * highlight User2 ctermfg=203 ctermbg=236 guibg=#282828 guifg=#fb4934
  autocmd ColorScheme * highlight User3 ctermfg=213 ctermbg=236 guibg=#282828 guifg=#d3869b
  autocmd ColorScheme * highlight StatusLine ctermfg=white ctermbg=236 guifg=#282828 guibg=#fdf4c1
  autocmd ColorScheme * highlight StatusLineNC ctermfg=white ctermbg=236 guifg=#282828 guibg=#504945
  autocmd ColorScheme * highlight VertSplit ctermfg=white ctermbg=236 guibg=#282828
augroup END

augroup NoPaste
  autocmd!
  autocmd InsertLeave * set nopaste
augroup END

augroup FileTypeSettings
  autocmd!
  autocmd FileType html setlocal ts=2 sw=2 expandtab
  autocmd FileType ruby setlocal ts=2 sw=2 expandtab
  autocmd FileType vim setlocal ts=2 sw=2 expandtab keywordprg=:help
  autocmd FileType haskell setlocal ts=2 sw=2 expandtab
  autocmd FileType python setlocal ts=4 sw=4 expandtab
  autocmd FileType javascript setlocal ts=2 sw=2 expandtab
  autocmd FileType coffee setlocal ts=2 sw=2 expandtab
  autocmd FileType sh,zsh setlocal ts=2 sw=2 expandtab
  autocmd FileType go setlocal ts=2 sw=2 noexpandtab
  autocmd FileType rust setlocal ts=4 sw=4 expandtab makeprg=cargo
  autocmd BufEnter *.rs iunmap ;;
  autocmd BufLeave *.rs inoremap ;; <Esc>:noh<CR>

  " Who uses modula2???
  autocmd BufNewFile,BufRead *.md set filetype=markdown
  autocmd BufNewFile,BufRead *.css set filetype=scss
  autocmd BufNewFile,BufRead Cargo.toml,Cargo.lock set filetype=rust
  autocmd BufNewFile,BufRead *.q set filetype=sql " Hive

  " spell check git commit messages and markdown files
  autocmd FileType markdown setlocal spell
  autocmd FileType gitcommit setlocal spell
  autocmd FileType text setlocal spell
augroup END

if has('nvim') 
  augroup Neomake
    autocmd!
    autocmd BufWritePost * Neomake
  augroup END
endif

augroup Gutter
  autocmd!
  autocmd BufWritePost * call Differ()
  autocmd BufReadPost * call Differ()
augroup END

" Otherwise vim will get nasty escape codes
if has('mac') && ($TERM == 'xterm-256color' || $TERM == 'screen-256color')
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

for modeprefix in ['i', 'n', 'v']
  for arrowkey in ['<Up>', '<Down>', '<Left>', '<Right>']
    execute modeprefix . "noremap " . arrowkey . " <Nop>"
  endfor
endfor

" If user has additional vim config, source it
if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif
