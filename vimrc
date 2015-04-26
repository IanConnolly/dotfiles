set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Manage Vundle with Vundle
Plugin 'gmarik/Vundle.vim'

" Vim layout + window related fun
Plugin 'scrooloose/nerdtree'         " File tree
Plugin 'Xuyuanp/nerdtree-git-plugin' " Show git statuses beside files in above
Plugin 'kien/ctrlp.vim'              " Fuzzy search
Plugin 'majutsushi/tagbar'           " Overview of ctags in current file
Plugin 'mhinz/vim-startify'          " Helpful start page for vim
Plugin 'bling/vim-airline'           " Lightweight status bar
Plugin 'sjl/gundo.vim'               " View undo history as tree

" Integrations
Plugin 'airblade/vim-gitgutter' " Show git diff icons in gutter
Plugin 'rizzatti/dash.vim'      " Integrate with Dash.app
Plugin 'tpope/vim-rails'        " Helpful rails related shortcuts
Plugin 'tpope/vim-rake'         " The general ruby bits of vim-rails
Plugin 'tpope/vim-fugitive'     " Git command wrappers
Plugin 'rking/ag.vim'           " integrate with ag, a faster grep

" Typing/Autocomplete support
Plugin 'scrooloose/syntastic'   " Syntax errors!
Plugin 'jiangmiao/auto-pairs'   " Automatically pair quotes, braces etc.
Plugin 'Valloric/YouCompleteMe' " Dropdown with autocompletion
Plugin 'SirVer/ultisnips'       " Snippets engine
Plugin 'honza/vim-snippets'     " Lots of built-in snippets for ultisnips
Plugin 'marijnh/tern_for_vim'   " Integrate with tern for JS omnifunc
Plugin 'tpope/vim-endwise'      " Insert 'end' in ruby as smartly as braces

" Movement/Text-alteration
Plugin 'Lokaltog/vim-easymotion' " Awesome motion movement without numbers
Plugin 'tpope/vim-surround'      " Easily deal with surrounding quotes, braces
Plugin 'tpope/vim-commentary'    " Comment/uncomment textobjs
Plugin 'tpope/vim-unimpaired'    " Collection of paired commands
Plugin 'chrisbra/NrrwRgn'        " Work on highlighted blocks w/ global regex
Plugin 'godlygeek/tabular'       " Align blocks on chars

" Colors
Plugin 'whatyouhide/vim-gotham'  " batman-inspired theme
Plugin 'chriskempson/base16-vim' " pastel-y theme

" Languages
Plugin 'kchmck/vim-coffee-script'
Plugin 'othree/html5.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'pangloss/vim-javascript'

call vundle#end()

filetype plugin indent on

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Config for themes/colors/plugins
let g:airline_theme='base16'
let g:ycm_path_to_python_interpreter = "/usr/local/bin/python"
colorscheme base16-default
highlight clear SignColumn

let mapleader=" " " Space for leader is so much more satisfying
syntax on

set laststatus=2
set background=dark
set autoread
set pastetoggle=<F2> " paste mode for clipboard pasted
set backspace=indent,eol,start
set cursorline
set relativenumber
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4
set noswapfile
set nowritebackup
set hlsearch
set incsearch
set ignorecase
set smartcase
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set splitright
set splitbelow
set scrolloff=10
set sidescrolloff=10
set tags=./.tags;
set ttyfast
set listchars=tab:›\ ,eol:¬,trail:⋅
set list

function! NumberToggle()
    if (&relativenumber == 1)
        set norelativenumber
        set number
    else
        set nonumber
        set relativenumber
    endif
endfunc

function! TrimWhitespace()
    %s/\s\+$//e
endfunc

let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<s-c-j>"
let g:UltiSnipsEditSplit="vertical"
nnoremap <Leader>tw :call TrimWhitespace()<CR>
nnoremap <Leader>num :call NumberToggle()<CR>
nnoremap <Leader>li :set list!<CR>
nnoremap <Leader>pwd :echo expand("%:p:h")<CR>
nnoremap <Leader>rt :execute "!rtags"<CR>
nnoremap <Leader>ct :execute "!ctags"<CR>
nnoremap <Leader>u :GundoToggle<CR>
nnoremap <Leader>t :CtrlPTag<CR>
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <silent> <Leader>d <Plug>DashSearch
noremap <esc> :noh<return><esc>
map <F3> :NERDTreeToggle<CR>
map <F4> :TagbarToggle<CR>
imap <F3> <ESC>:NERDTreeToggle<CR>
imap <F4> <ESC>:TagbarToggle<CR>

" Because shift is hard to let go of okay
command Wq wq
command WQ wq
command W w
command Q q

" Highlight > 80 chars
highlight OverLength ctermbg=darkred ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
" use tern for omnifunc which is used by YouCompleteMe for suggestions
autocmd FileType javascript setlocal omnifunc=tern#Complete

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
