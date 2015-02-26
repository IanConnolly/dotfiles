set nocompatible
let leader=" "
filetype off
syntax on

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'whatyouhide/vim-gotham'
Plugin 'airblade/vim-gitgutter'
Plugin 'kchmck/vim-coffee-script'
Plugin 'wting/rust.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'godlygeek/tabular' 
" tim pope is great, isn't he?
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-endwise'

call vundle#end()

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

let delimitMate_expand_cr = 1
filetype plugin indent on
set laststatus=2
set background=dark
let g:airline_theme='gotham'
let g:solarized_termtrans=1
colorscheme gotham
highlight clear SignColumn

set pastetoggle=<F2>
set cursorline
set relativenumber
set expandtab
set tabstop=4
set shiftwidth=4
set noswapfile
set nowritebackup
set hlsearch
nnoremap <esc> :noh<return><esc>
set ignorecase
set smartcase
map <C-n> :NERDTreeToggle<CR>

function! NumberToggle()
    if (&relativenumber == 1)
        set number
    else
        set relativenumber
    endif
endfunc

function! TrimWhitespace()
    %s/\s\+$//e
endfunc

nnoremap <Leader>rtw :call TrimWhitespace()<CR>
noremap <C-m> :call NumberToggle()<CR>

:au FocusLost * :set number
:au FocusGained * :set relativenumber

autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

command Wq wq
command WQ wq
command W w
command Q q

if exists(":Tabularize")
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:<CR>
    vmap <Leader>a: :Tabularize /:<CR>
endif
