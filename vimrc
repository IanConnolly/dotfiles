filetype off
runtime macros/matchit.vim

if has('nvim')
  call plug#begin('~/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif

" Vim layout + window related fun
Plug 'justinmk/vim-dirvish'                        " Dirvish > netrw
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' } " View undo history as tree
Plug 'mhinz/vim-sayonara'                          " Sanely quit buffers/windows etc.
Plug 'kopischke/vim-fetch'                         " GNU line/column format!

" Searching related
Plug 'mhinz/vim-grepper'                           " Async grepprg
Plug 'romainl/vim-qf'                              " Tame quickfix
Plug 'bronson/vim-visual-star-search'              " Search for visual selection with *
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' } | Plug 'junegunn/fzf.vim'

" External integrations
Plug 'IanConnolly/differ'                          " Async git gutter
Plug 'tpope/vim-rails'                             " Helpful rails related shortcuts
Plug 'tpope/vim-rake'                              " The general ruby bits of vim-rails
Plug 'tpope/vim-fugitive'                          " Git command wrappers

" Built-in improvement
Plug 'tpope/vim-characterize'                      " Show unicode info
Plug 'unblevable/quick-scope'                      " highlight in-line f/F/t/T motions

" Tmux
if executable('tmux')
  Plug 'tmux-plugins/vim-tmux-focus-events'        " FocusGained etc. in tmux!
  Plug 'benmills/vimux'                            " Use vimux to open commands in special tmux pane
endif

" Typing/Autocomplete support
Plug 'benekastah/neomake'                          " Neovim async syntax checker
Plug 'jiangmiao/auto-pairs'                        " Automatically pair quotes, braces etc.
Plug 'tpope/vim-endwise'                           " Insert 'end' in ruby as smartly as braces
Plug 'ajh17/VimCompletesMe'                        " Super lightweight smart-tab for ins-completion

" Movement/Text-alteration
Plug 'tpope/vim-surround'                          " Easily deal with surrounding quotes
Plug 'tpope/vim-commentary'                        " Comment/uncomment textobjs
Plug 'tpope/vim-unimpaired'                        " Collection of paired commands
Plug 'tpope/vim-repeat'                            " repeat surround/comment/unimpaired actions
Plug 'AndrewRadev/splitjoin.vim'                   " gS/gJ to switch single/multiline block
Plug 'tommcdo/vim-lion'                            " Alignment motion

" Text objs
Plug 'wellle/targets.vim'                          " New text objs
" User-defined text objs + erb objs + ruby objs
Plug 'kana/vim-textobj-user' | Plug 'tek/vim-textobj-ruby' | Plug 'gaving/vim-textobj-argument' | Plug 'glts/vim-textobj-comment'

" Operators
Plug 'kana/vim-operator-user' | Plug 'kana/vim-operator-replace'

" Colors
Plug 'IanConnolly/gruvbox'                         " gruvbox fork for ruby

" Daily work languages
Plug 'kchmck/vim-coffee-script'
Plug 'othree/html5.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'vim-ruby/vim-ruby'

Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'

Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

call plug#end()

filetype plugin indent on

if filereadable(glob("~/dotfiles/helpers.vim"))
  source ~/dotfiles/helpers.vim
endif

" Config for plugins

" Make vim friendlier for pairing if needed
let g:pair_programming = 0

" Always show sign column
let g:differ_always_show_sign_column = 1

" vim-ruby highlight operators
let ruby_operators = 1

" Namespace FZF commands
let g:fzf_command_prefix = 'Fzf'

" Neomake
let g:neomake_ruby_enabled_makers = ['mri']
let g:neomake_open_list = 0

" Ack.vim style quickfix mappings
let g:qf_mapping_ack_style = 1

" Only enable quick-scope after f/F/t/T
"let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" AutoPairs binds to Meta by default for whatever reason, we don't want that
" on OSX
let g:AutoPairsShortcutFastWrap = '<C-e>'

let g:grepper = {
  \ 'quickfix': 1,
  \ 'open': 1,
  \ 'switch': 1,
  \ 'jump': 0,
  \ 'tools': ['ag'],
  \ }

" Vim Settings
let mapleader=" " " Space for leader is so satisfying
syntax on

call Load(Dotfiles("pairing.vim"))

" Command behaviour
set noshowcmd
set laststatus=2

" Text-y stuff
set shiftround " 'h' and 'l' will wrap around lines
set whichwrap+=<,>,h,l

" Line/line number
set number
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
set nohlsearch
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
set scrolloff=10 " keep cursor relatively centered
set sidescrolloff=10

" Tagfile
set tags=./.tags;

" Showing invisible characters
set listchars=tab:»\ ,extends:›,eol:¬,trail:⋅ " textmate
set showbreak=›››
set list

" Command tab-completion
set wildmenu " command auto-completion
set wildmode=list:longest,full

set complete+=kspell
set hidden

set completeopt=menu,menuone " Don't show scratch window

set switchbuf=useopen
set updatetime=750

" statusline
if !PluginLoaded('vim-airline')
  " show which mode we're in
  set showmode
  call Load(Dotfiles("statusline.vim"))
endif

if has("persistent_undo")
  let undoDir = expand('$HOME/.undodir')
  call system('mkdir -p ' . undoDir)
  let &undodir = undoDir
  set undofile
endif

if PluginLoaded('splitjoin.vim')
  nnoremap <silent> J :<C-u>call TryWithDefault('SplitjoinJoin', 'J')<CR>
  nnoremap <silent> S :<C-u>call TryWithDefault('SplitjoinSplit', "r\015")<CR>
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

  if PluginLoaded('vim-grepper')
    nmap gs  <plug>(GrepperOperator)
    xmap gs  <plug>(GrepperOperator)

    nnoremap <Leader>s :Grepper! -noswitch -tool ag -query '\b<C-r><C-w>\b'<CR>
    nnoremap <Leader>ag :Grepper! -tool ag -query ''<Left>
    command! -nargs=* Ag Grepper -tool ag -query <args>
    command! Grep Grepper! -tool ag
    command! GRep Grep
  endif
endif

if PluginLoaded('vim-operator-user') && PluginLoaded('vim-operator-replace')
  map r <Plug>(operator-replace)
endif

" Undo mappings
if PluginLoaded('undotree')
  nnoremap <Leader>u :UndotreeToggle<CR>
endif
nnoremap <Leader>du :call DeleteUndoFile()<CR>

" Use Sayonara for quitting
if PluginLoaded('vim-sayonara')
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
  nnoremap <Leader>U :PlugInstall<CR>:PlugUpdate<CR>:PlugClean<CR>
  nnoremap <Leader>S :call GenerateSnapshot()<CR>
endif

command! Reload :so ~/dotfiles/vimrc
nnoremap <Leader>R :Reload<CR>
" Edit the vimrc in a split
command! EV vsplit ~/dotfiles/vimrc
command! ES split ~/dotfiles/vimrc

" no need for this to be mac only; can compile from source
if PluginLoaded('fzf.vim')
  nnoremap <C-p> :FzfFiles<CR>
endif

cnoremap %% <C-R>=expand('%:h').'/'<cr>
nmap - :edit %%<CR>
nmap <Leader>- :edit %%

" vim-fugitive
if PluginLoaded('vim-fugitive')
  nnoremap <Leader>gb :Gblame<CR>
  nnoremap <Leader>gs :Gstatus<CR>
  nnoremap <Leader>gd :Gdiff<CR>
  nnoremap <Leader>gc :Gcommit<CR>
  nnoremap <Leader>gp :Gpush<CR>
  nnoremap <Leader>gl :Glog<CR>:copen<CR>
endif

" FZF
if PluginLoaded('vim-fugitive') && PluginLoaded('fzf.vim')
  nnoremap <Leader>gf :FzfGitFiles<CR>
  nnoremap <Leader>gh :FzfBCommits<CR>
endif

" copy and paste
xnoremap <Leader>c "*y
nnoremap <Leader>p "0p
nnoremap <Leader>P "0P

" Neomake errors
if PluginLoaded('neomake')
  nnoremap <Leader>e :Neomake<CR>:lopen<CR>
endif

if PluginLoaded('vim-surround')
  " The 'y' mnemonic doesn't really make much sense
  " and we can use the default `s` bind with `cl`
  nmap s  <Plug>Ysurround
  nmap S  <Plug>YSurround
  nmap ss <Plug>Yssurround
  nmap SS <Plug>YSsurround
endif

" arglist
nnoremap <Leader>aa :argadd %<CR>
nnoremap <Leader>ae :argedit %<CR>
nnoremap <Leader>ad :.argd<CR>
nnoremap <Leader>as :args<CR>
nnoremap <Leader>ah :first<CR>
nnoremap <Leader>af :first<CR>
nnoremap <Leader>al :last<CR>

" easily get rid of search highlights
nnoremap <CR> :nohl<CR>

if PluginLoaded('fzf.vim')
  " For fuzzy finding thru buffers
  nnoremap <Leader><Tab> :FzfBuffers<CR>
  " fuzzy tags
  nnoremap <Leader>tb :FzfBTags<CR>
  nnoremap <Leader>ta :FzfTags<CR>
endif

" Switch to last active buffer
noremap <Leader><Leader> :buffer #<CR>

" Quick jump to buffers
nnoremap <Leader>b :ls<cr>:b<space>

" Toggle case
nnoremap <Leader>ct g~iw
nnoremap <Leader>cu gUiw
nnoremap <Leader>cl guiw

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
nnoremap <F1> <Esc>
xnoremap <F1> <Esc>
inoremap <F1> <Esc>

" Change, highlight, repeat
nnoremap <Leader>cw *``cgn

" replace all occurences of current word
nnoremap <Leader>ra :%s/\<<C-r>=expand('<cword>')<CR>\>/

" replace occurrences inside this block
nnoremap <Leader>ri :'{,'}s/\<<C-r>=expand('<cword>')<CR>\>/

" Because un-selecting is dumb
xnoremap > >gv
xnoremap < <gv

" Debug colours
command! SS echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')

" Because shift is hard to let go of okay
command! Wq wq
command! WQ wq
command! W w
command! Q q

augroup FixCRQuickfix
  autocmd!
  autocmd FileType qf nnoremap <buffer> <CR> <CR>
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
  autocmd FileType yaml setlocal ts=2 sw=2 expandtab

  " Who uses modula2???
  autocmd BufNewFile,BufRead *.md set filetype=markdown
  autocmd BufNewFile,BufRead *.css set filetype=scss
  autocmd BufNewFile,BufRead *.q set filetype=sql " Hive

  autocmd BufNewFile,BufRead Fastfile,Appfile,Scanfile,Deliverfile set filetype=ruby

  " spell check git commit messages and markdown files
  autocmd FileType markdown setlocal spell
  autocmd FileType gitcommit setlocal spell
  autocmd FileType text setlocal spell
augroup END

if PluginLoaded('differ')
  augroup Gutter
    autocmd!
    autocmd BufWritePost * call differ#Differ()
    autocmd BufReadPost * call differ#Differ()
  augroup END
endif

if PluginLoaded('vim-dirvish')
  augroup Dirvish
    autocmd!
    autocmd FileType dirvish nnoremap <buffer> v
        \ :vsp <C-R>=fnameescape(getline('.'))<CR><CR>
    autocmd FileType dirvish nnoremap <buffer> s
        \ :sp <C-R>=fnameescape(getline('.'))<CR><CR>
    autocmd FileType dirvish nnoremap <buffer> <C-R> :<C-U>Dirvish %<CR>
    autocmd FileType dirvish nnoremap <buffer> gh 
        \ :set ma<bar>g@\v/\.[^\/]+/?$@d<cr>:set noma<cr>
  augroup END
endif

call Load(Dotfiles("colors.vim"))
call Load(Dotfiles("neo.vim"))
call Load(Dotfiles("mac.vim"))
call Load("~/.vimrc.local")

