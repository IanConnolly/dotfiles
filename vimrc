set nocompatible
filetype off
runtime macros/matchit.vim

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Manage Vundle with Vundle
Plugin 'gmarik/Vundle.vim'

" Vim layout + window related fun
Plugin 'tpope/vim-vinegar'           " cleanup netrw
Plugin 'bling/vim-airline'           " Lightweight status bar
Plugin 'mbbill/undotree'             " View undo history as tree
Plugin 'troydm/easybuffer.vim'       " Startify-esque buffer nav

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
Plugin 'ecomba/vim-ruby-refactoring'        " Easily refactor ruby code
Plugin 'AndrewRadev/splitjoin.vim'          " gS/gJ to switch single/multiline block

" Typing/Autocomplete support
Plugin 'scrooloose/syntastic'   " Syntax errors!
Plugin 'jiangmiao/auto-pairs'   " Automatically pair quotes, braces etc.
Plugin 'Valloric/YouCompleteMe' " Dropdown with autocompletion
Plugin 'SirVer/ultisnips'       " Snippets engine
Plugin 'honza/vim-snippets'     " Lots of built-in snippets for ultisnips
Plugin 'marijnh/tern_for_vim'   " Integrate with tern for JS omnifunc
Plugin 'tpope/vim-endwise'      " Insert 'end' in ruby as smartly as braces

" Movement/Text-alteration
Plugin 'tpope/vim-surround'          " Easily deal with surrounding quotes
Plugin 'tpope/vim-commentary'        " Comment/uncomment textobjs
Plugin 'tpope/vim-unimpaired'        " Collection of paired commands
Plugin 'tpope/vim-repeat'            " repeat surround/comment/unimpaired actions
Plugin 'kshenoy/vim-signature'       " Show marks in gutter
Plugin 'wellle/targets.vim'          " New text objs
Plugin 'kana/vim-textobj-user'       " User-defined text objs
Plugin 'whatyouhide/vim-textobj-erb' " viE and vaE
Plugin 'tek/vim-textobj-ruby'        " f-unction, c-lass, r -> block
Plugin 'tpope/vim-jdaddy'            " json text objs
Plugin 'unblevable/quick-scope'      " highlight in-line f/F/t/T motions

" Colors
Plugin 'whatyouhide/vim-gotham'           " batman-inspired theme
Plugin 'chriskempson/base16-vim'          " pastel-y theme
Plugin 'junegunn/seoul256.vim'            " low contrast theme
Plugin 'altercation/vim-colors-solarized' " solarized is life

" Languages
Plugin 'kchmck/vim-coffee-script'
Plugin 'othree/html5.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'pangloss/vim-javascript'
Plugin 'cakebaker/scss-syntax.vim'

call vundle#end()

filetype plugin indent on

set rtp+=/usr/local/Cellar/fzf/HEAD " fzf vim setup

" Config for themes/colors/plugins
colorscheme base16-default

let g:airline_theme='base16'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1

let g:WebDevIconsUnicodeGlyphDoubleWidth = 1

let g:SignatureMarkTextHLDynamic = 1

let g:ycm_path_to_python_interpreter = "/usr/local/bin/python"

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_scss_checkers = []
let g:syntastic_disabled_filetype = ['scss']

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']']]

let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<s-c-j>"
let g:UltiSnipsEditSplit="vertical"

" Only enable quick-scope after f/F/t/T

let g:qs_enable = 0
let g:qs_enable_char_list = [ 'f', 'F', 't', 'T' ]

function! Quick_scope_selective(movement)
    let needs_disabling = 0
    if !g:qs_enable
        QuickScopeToggle
        redraw
        let needs_disabling = 1
    endif
    let letter = nr2char(getchar())
    if needs_disabling
        QuickScopeToggle
    endif
    return a:movement . letter
endfunction

" quick_scope maps, operator-pending mode included (can do 'df' with hint)
for i in g:qs_enable_char_list
    execute 'noremap <expr> <silent>' . i . " Quick_scope_selective('". i . "')"
endfor

" Get rid of YCM preview window when we tab
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

if has("persistent_undo")
    set undodir='~/.undodir/'
    set undofile
endif

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
set visualbell
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
set nocursorline

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

" god who uses this
map q: :q

nnoremap <Leader>tw :call TrimWhitespace()<CR>
nnoremap <Leader>num :call NumberToggle()<CR>
nnoremap <Leader>rt :execute "!rtags"<CR>
nnoremap <Leader>ct :execute "!ctags"<CR>
nnoremap <Leader>u :UndotreeToggle<CR>
nnoremap <C-p> :FZF<CR>
nnoremap <Leader>cd :cd %:p:h<CR>
nnoremap <Leader>gb :Gblame<CR>
" copy and paste
vnoremap <Leader>c "*y
nnoremap <Leader>p "0p
nnoremap <Leader>P "0P
nmap <silent> <Leader>d <Plug>DashSearch
" easily get rid of search highlights
noremap <esc> :noh<return><esc>
" cycle through buffers
map <Leader><tab> :bn<CR>
map <Leader>` :bp<CR>
map ` :EasyBuffer<CR>

" Because shift is hard to let go of okay
command! Wq wq
command! WQ wq
command! W w
command! Q q

highlight SignColumn ctermbg=black
highlight lineNr ctermbg=black

highlight GitGutterAdd ctermbg=black
highlight GitGutterChange ctermbg=black
highlight GitGutterDelete ctermbg=black
highlight GitGutterChangeDelete ctermbg=black

hi CursorLineNR ctermbg=black
augroup ColourSet
    autocmd!
    autocmd ColorScheme * hi CursorLineNR ctermbg=black
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
    autocmd BufNewFile,BufRead *.css set filetype=scss
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

" If user has additional vim config, source it
if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif
