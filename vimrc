set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Manage Vundle with Vundle
Plugin 'gmarik/Vundle.vim'

" Vim layout + window related fun
Plugin 'scrooloose/nerdtree'         " File tree
Plugin 'ryanoasis/vim-webdevicons'   " Nice icons in NERDTree
Plugin 'ctrlpvim/ctrlp.vim'          " Fuzzy search
Plugin 'majutsushi/tagbar'           " Overview of ctags in current file
Plugin 'mhinz/vim-startify'          " Helpful start page for vim
Plugin 'bling/vim-airline'           " Lightweight status bar
Plugin 'sjl/gundo.vim'               " View undo history as tree
Plugin 'junegunn/goyo.vim'           " Center when typing text, markdown
Plugin 'junegunn/limelight.vim'      " Focus paragraph when in goyo

" Integrations
Plugin 'airblade/vim-gitgutter'             " Show git diff icons in gutter
Plugin 'rizzatti/dash.vim'                  " Integrate with Dash.app
Plugin 'tpope/vim-rails'                    " Helpful rails related shortcuts
Plugin 'tpope/vim-rake'                     " The general ruby bits of vim-rails
Plugin 'tpope/vim-fugitive'                 " Git command wrappers
Plugin 'rking/ag.vim'                       " integrate with ag, a faster grep
Plugin 'justinmk/vim-gtfo'                  " Open a tmux pane with got!
Plugin 'tpope/vim-tbone'                    " Access to tmux commands
Plugin 'tmux-plugins/vim-tmux-focus-events' " FocusGained etc. in tmux!
Plugin 'junegunn/vim-xmark'                 " Markdown preview

" Typing/Autocomplete support
Plugin 'scrooloose/syntastic'   " Syntax errors!
Plugin 'jiangmiao/auto-pairs'   " Automatically pair quotes, braces etc.
Plugin 'Valloric/YouCompleteMe' " Dropdown with autocompletion
Plugin 'SirVer/ultisnips'       " Snippets engine
Plugin 'honza/vim-snippets'     " Lots of built-in snippets for ultisnips
Plugin 'marijnh/tern_for_vim'   " Integrate with tern for JS omnifunc
Plugin 'tpope/vim-endwise'      " Insert 'end' in ruby as smartly as braces

" Movement/Text-alteration
Plugin 'Lokaltog/vim-easymotion'     " Awesome motion movement without numbers
Plugin 'tpope/vim-surround'          " Easily deal with surrounding quotes
Plugin 'tpope/vim-commentary'        " Comment/uncomment textobjs
Plugin 'tpope/vim-unimpaired'        " Collection of paired commands
Plugin 'chrisbra/NrrwRgn'            " Work on blocks w/ global regex
Plugin 'godlygeek/tabular'           " Align blocks on chars
Plugin 'kshenoy/vim-signature'       " Show marks in gutter
Plugin 'kana/vim-textobj-user'       " User-defined text objs
Plugin 'whatyouhide/vim-textobj-erb' " viE and vaE
Plugin 'tek/vim-textobj-ruby'        " f-unction, c-lass, r -> block

" Colors
Plugin 'whatyouhide/vim-gotham'  " batman-inspired theme
Plugin 'chriskempson/base16-vim' " pastel-y theme
Plugin 'junegunn/seoul256.vim'   " low contrast theme

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
let g:ycm_path_to_python_interpreter = "/usr/local/bin/python"
colorscheme base16-default
let g:airline_theme='base16'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
let g:airline_powerline_fonts = 1
let g:SignatureMarkTextHLDynamic = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Get rid of YCM preview window when we tab
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

let mapleader=" "                   " Space for leader is so satisfying
syntax on

set laststatus=2
set background=dark
set autoread
set pastetoggle=<F2>                " paste mode for clipboard pasted
set backspace=indent,eol,start      " backspace everything
set number                          " for easier movements
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4
set shiftround                      " 'h' and 'l' will wrap around lines
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
set scrolloff=10                    " keep cursor relatively centered
set sidescrolloff=10
set tags=./.tags;
set ttyfast                         " probably already set but /shruggie
set listchars=tab:›\ ,eol:¬,trail:⋅ " textmate
set list
set encoding=utf-8
set whichwrap+=<,>,h,l
set wildmenu                        " command auto-completion
set wildmode=longest:list,full
set mouse=a
set complete+=kspell
set hidden

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
nnoremap <Leader>rt :execute "!rtags"<CR>
nnoremap <Leader>ct :execute "!ctags"<CR>
nnoremap <Leader>u :GundoToggle<CR>
nnoremap <Leader>t :CtrlPTag<CR>
vnoremap <Leader>c "*y
vnoremap <Leader>y :Tyank<CR>
nnoremap <Leader>p :Tput<CR>
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a" :Tabularize /"<CR>
vmap <Leader>a" :Tabularize /"<CR>
nmap <silent> <Leader>d <Plug>DashSearch
" easily get rid of search highlights
noremap <esc> :noh<return><esc>
" cycle through buffers
map <Leader><tab> :bn<CR>
" quick taps for opening extra menus
map <F3> :TagbarToggle<CR>
map <F4> :NERDTreeToggle<CR>
imap <F3> <ESC>:TagbarToggle<CR>
imap <F4> <ESC>:NERDTreeToggle<CR>

" Because shift is hard to let go of okay
command Wq wq
command WQ wq
command W w
command Q q

" Highlight > 80 chars
highlight OverLength ctermbg=darkgray guibg=darkgray
match OverLength /\%81v.\+/

highlight SignColumn ctermbg=black
highlight lineNr ctermbg=black

highlight GitGutterAdd ctermbg=black
highlight GitGutterChange ctermbg=black
highlight GitGutterDelete ctermbg=black
highlight GitGutterChangeDelete ctermbg=black

" highlight the line number
hi CursorLineNR ctermfg=red
augroup ColourSet
    autocmd!
    autocmd ColorScheme * hi CursorLineNR ctermfg=red
    autocmd ColorScheme * hi OverLength ctermbg=darkgray guibg=darkgray
    autocmd ColorScheme * hi SignColumn ctermbg=black
    autocmd ColorScheme * hi lineNr ctermbg=black
    autocmd ColorScheme * hi GitGutterAdd ctermbg=black
    autocmd ColorScheme * hi GitGutterChange ctermbg=black
    autocmd ColorScheme * hi GitGutterDelete ctermbg=black
    autocmd ColorScheme * hi GitGutterChangeDelete ctermbg=black
 augroup END

augroup FileTypeSettings
    autocmd!
    autocmd Filetype html setlocal ts=2 sw=2 expandtab
    autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
    " use tern for omnifunc which is used by YouCompleteMe for suggestions
    autocmd FileType javascript setlocal omnifunc=tern#Complete
    " Who uses modula2???
    autocmd BufNewFile,BufRead *.md set filetype=markdown
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

augroup GoyoLight
    autocmd!
    autocmd User GoyoEnter Limelight
    autocmd User GoyoLeave Limelight!
augroup END

augroup NERDCleanup
    autocmd!
    " close vim if only buffer left is NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
augroup END
