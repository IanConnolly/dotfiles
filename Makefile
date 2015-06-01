ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

all:
	@printf "Makefile targets: \n\n"
	@printf "\tinstall\t\t - install all\n"
	@printf "\tvim\t\t - install vim\n"
	@printf "\ttmux\t\t - install tmux\n"
	@printf "\tgit\t\t - install git\n"
	@printf "\tghci\t\t - install ghci\n"
	@printf "\tzsh\t\t - install zsh\n"
	@printf "\tctags\t\t - install ctags\n"
	@printf "\thelp\t\t - print this message\n"

install: zsh vim tmux git ghc tags

vim: vimlinks
	rm -rf ~/.vim
	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	brew update && brew install the_silver_searcher && brew install ctags
	vim -c PluginInstall -c quitall
	cd ~/.vim/bundle/YouCompleteMe && ./install.sh --clang-completer
	cd ~/.vim/bundle/tern_for_vim && npm install
	cd ~/.vim/bundle/vim-xmark && make
	mkdir -p ~/.vim/ftdetect
	ln -sf ~/.vim/bundle/ultisnips/ftdetect/* ~/.vim/ftdetect
	pip install neovim

vimlinks:
	ln -sf $(ROOT_DIR)/vimrc $(HOME)/.vimrc
	ln -sf ~/.vim ~/.nvim
	ln -sf ~/.vimrc ~/.nvimrc

tmux:
	brew update && brew install reattach-to-user-namespace
	ln -sf $(ROOT_DIR)/tmux.conf $(HOME)/.tmux.conf

git:
	ln -sf $(ROOT_DIR)/gitconfig $(HOME)/.gitconfig
	ln -sf $(ROOT_DIR)/gitignore $(HOME)/.gitignore

ghc:
	ln -sf $(ROOT_DIR)/ghci $(HOME)/.ghci

zsh:
	ln -sf $(ROOT_DIR)/zshrc $(HOME)/.zshrc
	ln -sf $(ROOT_DIR)/zshenv $(HOME)/.zshenv

tags:
	ln -sf $(ROOT_DIR)/ctags $(HOME)/.ctags

help: all
