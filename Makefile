ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

all:
	@printf "Makefile targets: \n\n"
	@printf "\tinstall\t\t - install all\n"
	@printf "\tvim\t\t - install vim\n"
	@printf "\ttmux\t\t - install tmux\n"
	@printf "\tgit\t\t - install git\n"
	@printf "\tghci\t\t - install ghci\n"
	@printf "\tzsh\t\t - install zsh\n"
	@printf "\thelp\t\t - print this message\n"

install: zsh vim tmux git ghci

vim:
	rm -rf ~/.vim
	ln -sf $(ROOT_DIR)/vimrc $(HOME)/.vimrc
	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	brew update && brew install the_silver_searcher
	vim -c PluginInstall -c quitall
	cd ~/.vim/bundle/YouCompleteMe && ./install.sh --clang-completer
	mkdir -p ~/.vim/ftdetect
	ln -sf ~/.vim/bundle/ultisnips/ftdetect/* ~/.vim/ftdetect

tmux:
	ln -sf $(ROOT_DIR)/tmux.conf $(HOME)/.tmux.conf

git:
	ln -sf $(ROOT_DIR)/gitconfig $(HOME)/.gitconfig

ghci:
	ln -sf $(ROOT_DIR)/ghci $(HOME)/.ghci

zsh:
	ln -sf $(ROOT_DIR)/zshrc $(HOME)/.zshrc

help: all
