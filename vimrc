set nocompatible
filetype off

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
Plugin 'godlygeek/tabular'
Plugin 'jiangmiao/auto-pairs'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'haya14busa/vim-easyoperator-line'
Plugin 'mhinz/vim-startify'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'sjl/gundo.vim'
" tim pope is great, isn't he?
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-endwise'

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

let mapleader=" "
syntax on
set laststatus=2
set background=dark
let g:airline_theme='gotham'
let g:solarized_termtrans=1
colorscheme gotham
highlight clear SignColumn
set autoread
set pastetoggle=<F2>
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
noremap <Leader>rtw :call TrimWhitespace()<CR>
noremap <Leader>num  :call NumberToggle()<CR>
noremap <Leader>pwd :lcd %:p:h<CR>
noremap <Leader>un :GundoToggle<CR>
nnoremap <esc> :noh<return><esc>
map <C-n> :NERDTreeToggle<CR>

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
highlight OverLength ctermbg=darkred ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
