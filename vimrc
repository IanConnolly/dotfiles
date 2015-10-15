set nocompatible
filetype off
runtime macros/matchit.vim

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'         " In case I've missed something

" Vim layout + window related fun
Plug 'tpope/vim-vinegar'           " cleanup netrw
Plug 'bling/vim-airline'           " Lightweight status bar
Plug 'mbbill/undotree'             " View undo history as tree
Plug 'mhinz/vim-sayonara'          " Sanely quit buffers/windows etc.

" FZF base + FZF vim helpers
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' } | Plug 'junegunn/fzf.vim'

" Integrations
Plug 'airblade/vim-gitgutter'             " Show git diff icons in gutter
Plug 'tpope/vim-rails'                    " Helpful rails related shortcuts
Plug 'tpope/vim-rake'                     " The general ruby bits of vim-rails
Plug 'tpope/vim-fugitive'                 " Git command wrappers

if executable('tmux')
  Plug 'justinmk/vim-gtfo'                  " Open a tmux pane with got!
  Plug 'tmux-plugins/vim-tmux-focus-events' " FocusGained etc. in tmux!
  Plug 'benmills/vimux'                     " Use vimux to open commands in special tmux pane
endif

if has('mac') && isdirectory('/Applications/Dash.app')
  Plug 'rizzatti/dash.vim'                  " Integrate with Dash.app
endif

" Typing/Autocomplete support
Plug 'scrooloose/syntastic'                " Syntax errors!
Plug 'jiangmiao/auto-pairs'                " Automatically pair quotes, braces etc.
Plug 'tpope/vim-endwise'                   " Insert 'end' in ruby as smartly as braces
Plug 'ajh17/VimCompletesMe'                " Super lightweight smart-tab for ins-completion
Plug 'unblevable/quick-scope'              " highlight in-line f/F/t/T motions

" Movement/Text-alteration
Plug 'tpope/vim-surround'          " Easily deal with surrounding quotes
Plug 'tpope/vim-commentary'        " Comment/uncomment textobjs
Plug 'tpope/vim-unimpaired'        " Collection of paired commands
Plug 'tpope/vim-repeat'            " repeat surround/comment/unimpaired actions
Plug 'kshenoy/vim-signature'       " Show marks in gutter
Plug 'AndrewRadev/splitjoin.vim'   " gS/gJ to switch single/multiline block

" Text objs
Plug 'wellle/targets.vim'          " New text objs
" User-defined text objs + erb objs + ruby objs
Plug 'kana/vim-textobj-user' | Plug 'whatyouhide/vim-textobj-erb' | Plug 'tek/vim-textobj-ruby'

" Colors
Plug 'chriskempson/base16-vim'          " pastel-y theme
Plug 'altercation/vim-colors-solarized' " solarized is life

" Daily work languages
Plug 'kchmck/vim-coffee-script'
Plug 'othree/html5.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'vim-ruby/vim-ruby'

" Non-daily work
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

" Non-work
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }

call plug#end()

filetype plugin indent on

" Config for plugins

" Airline
if filereadable(expand("$HOME/.vim/plugged/vim-airline/autoload/airline/themes/ianline.vim"))
  let g:airline_theme='ianline'
endif

let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#whitespace#enabled = 0
let g:airline_section_y=''
let g:airline_section_z='%#__accent_bold#%4l%#__restore__#:%3v'

" vim-signature - highlight gutter marks
let g:SignatureMarkTextHLDynamic = 1

" Syntastic
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_scss_checkers = []
let g:syntastic_disabled_filetype = ['scss']

" Only enable quick-scope after f/F/t/T
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Vim Settings
let mapleader=" "                   " Space for leader is so satisfying
syntax on
set background=dark
silent! colorscheme base16-default

" Command behaviour
set showcmd
set noshowmode
set laststatus=2

" Text-y stuff
set backspace=indent,eol,start      " backspace everything
set shiftround                      " 'h' and 'l' will wrap around lines
set whichwrap+=<,>,h,l

" Gutter number
set nonumber                          " for easier movements
set relativenumber
set cursorline

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
set t_vb=

" Key timeouts
set tm=500
set ttimeoutlen=50

" Split opening positions
set splitright
set splitbelow

" Screen scrolling behaviour
set scrolloff=10                    " keep cursor relatively centered
set sidescrolloff=10

" Tagfile
set tags=./.tags;

" Showing invisible characters
set listchars=tab:»\ ,extends:›,eol:¬,trail:⋅ " textmate
set showbreak=›››\
set list

" Command tab-completion
set wildmenu                        " command auto-completion
set wildmode=list:longest,full

" Misc
set ttyfast                         " probably already set but /shruggie
set encoding=utf-8
set complete+=kspell
set hidden

set completeopt=menu,menuone " Don't show scratch window

set switchbuf=useopen

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

" Global variable for Vimux test pane
let g:vs_open = 0

function! VimuxScribd()
  if (g:vs_open == 0)
    call VimuxRunCommand("ssh -A devbox.lo")
    call VimuxRunCommand("cd /var/www/apps/scribd/current")
    call VimuxRunCommand("clear")
    let g:vs_open = 1
  endif
endfunction

function! VimuxRuby()
  if (g:vs_open == 0)
    call VimuxScribd()
  endif
  let buffername = bufname("%")
  let testfile = buffername
  if buffername =~ '^app/.*'
    let testfile = substitute(testfile, 'app/', 'spec/', '')
    let testfile = substitute(testfile, '.rb$', '_spec.rb', '')
  endif
  call VimuxRunCommand("clear; bundle exec spring rspec --no-profile " . testfile)
endfunction

function! VimuxRubyNearest()
  if (g:vs_open == 0)
    call VimuxScribd()
  endif
  let buffername = bufname("%")
  let testfile = buffername
  if buffername =~ '^spec/.*'
    let testfile = substitute(testfile, '$', ':' . line("."), '')
  elseif buffername =~ '^app/.*'
    let testfile = substitute(testfile, 'app/', 'spec/', '')
    let testfile = substitute(testfile, '.rb$', '_spec.rb', '')
  endif
  call VimuxRunCommand("clear; bundle exec spring rspec --no-profile " . testfile)
endfunction

function! VimuxScribdClose()
  if (g:vs_open == 1)
    call VimuxCloseRunner()
    let g:vs_open = 0
  endif
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

" Prompt for a term; search for it; populate loclist with it
function! CurFileSearchLocList()
  call inputsave()
  let search_term = input('Search: ')
  call inputrestore()
  execute 'lvim "' . search_term . '" %'
  execute 'lopen'
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

" Run current file specs in tmux
if exists('$TMUX')
  nnoremap <Leader>vs :call VimuxScribd()<CR>
  nnoremap <Leader>vr :call VimuxRuby()<CR>
  nnoremap <Leader>vn :call VimuxRubyNearest()<CR>
  nnoremap <Leader>vc :call VimuxScribdClose()<CR>
end

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
  command! -nargs=+ -complete=file_in_path -bar Show silent grep! <args>|cwindow|redraw!
  nnoremap <Leader>s :silent! grep! "\b<C-r><C-w>\b"<CR>:cwindow<CR>:redraw!<CR>
  nnoremap <Leader>ag :Show ''<Left>
endif

" Undo mappings
nnoremap <Leader>u :UndotreeToggle<CR>
nnoremap <Leader>du :call DeleteUndoFile()<CR>

" Use Sayonara for quitting
nnoremap <Leader>x :Sayonara<CR>y<CR>
nnoremap <Leader>q :w<CR>:Sayonara<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>Q :q!<CR>

" Easily make changes to vimrc
nnoremap <Leader>R :mapclear!<CR>:so ~/.vimrc<CR>:AirlineRefresh<CR>:PlugInstall<CR>
nnoremap <Leader>U :PlugUpdate<CR>:PlugClean<CR>
nnoremap <Leader>S :call GenerateSnapshot()<CR>

" Opens all current marks in loclist
nnoremap <Leader>m :call signature#mark#List("buf_curr")<CR>

" no need for this to be mac only; can compile from source
nnoremap <C-p> :FZF<CR>

" vim-fugitive
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gp :Gpush<CR>
nnoremap <Leader>gl :Glog<CR>:copen<CR>

" copy and paste
xnoremap <Leader>c "*y
nnoremap <Leader>p "0p
nnoremap <Leader>P "0P

" Syntastic errors
nnoremap <Leader>e :SyntasticCheck<CR>:Errors<CR>

" Search for a term and put it in the loclist
nnoremap <Leader>/ :call CurFileSearchLocList()<CR>

set pastetoggle=<F2>
" Don't allow paste mode in normal/visual modes
nnoremap <F2> <NOP>
xnoremap <F2> <NOP>

" Search current word in Dash.app
if has('mac') && isdirectory('/Applications/Dash.app')
  nmap <silent> <Leader>d <Plug>DashSearch
endif

" easily get rid of search highlights
noremap <Esc> :noh<CR><Esc>

" For fuzzy finding thru buffers
nnoremap <Leader><Tab> :Buffers<CR>

" Switch to last active buffer
noremap <Leader><Space> :buffer #<CR>

" Quick jump to buffers
nnoremap <leader>b :ls<cr>:b<space>

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

" Debug colours
command! SS echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
"
" Because shift is hard to let go of okay
command! Wq wq
command! WQ wq
command! W w
command! Q q

" Gutter colours
highlight CursorLineNR ctermfg=red
highlight SignColumn ctermbg=black
highlight lineNr ctermbg=black
highlight GitGutterAdd ctermbg=black
highlight GitGutterChange ctermbg=black
highlight GitGutterDelete ctermbg=black
highlight GitGutterChangeDelete ctermbg=black

augroup GutterColourSet
  autocmd!
  autocmd ColorScheme * hi CursorLineNR ctermfg=black
  autocmd ColorScheme * hi SignColumn ctermbg=black
  autocmd ColorScheme * hi lineNr ctermbg=black
  autocmd ColorScheme * hi GitGutterAdd ctermbg=black
  autocmd ColorScheme * hi GitGutterChange ctermbg=black
  autocmd ColorScheme * hi GitGutterDelete ctermbg=black
  autocmd ColorScheme * hi GitGutterChangeDelete ctermbg=black
augroup END

if exists('$TMUX')
  " Cleanup after ourselves, close the tmux pane when closing Vim
  augroup Vimux
    autocmd!
    autocmd VimLeave * :call VimuxScribdClose()
  augroup END
endif

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
  autocmd FileType rust setlocal ts=4 sw=4 expandtab
  autocmd FileType javascript setlocal ts=2 sw=2 expandtab
  autocmd FileType coffee setlocal ts=2 sw=2 expandtab
  " Who uses modula2???
  autocmd BufNewFile,BufRead *.md set filetype=markdown
  autocmd BufNewFile,BufRead *.css set filetype=scss
  " Hive
  autocmd BufNewFile,BufRead *.q set filetype=sql
  " spell check git commit messages and markdown files!
  autocmd FileType markdown setlocal spell
  autocmd FileType gitcommit setlocal spell
  autocmd FileType text setlocal spell
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
