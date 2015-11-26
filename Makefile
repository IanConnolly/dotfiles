ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

all:
	@printf "Makefile targets: \n\n"
	@printf "\tinstall\t\t - install all\n"
	@printf "\tvim\t\t - install vim\n"
	@printf "\tneovim\t\t - install neovim\n"
	@printf "\ttmux\t\t - install tmux\n"
	@printf "\tgit\t\t - install git\n"
	@printf "\tghci\t\t - install ghci\n"
	@printf "\tzsh\t\t - install zsh\n"
	@printf "\tctags\t\t - install ctags\n"
	@printf "\thelp\t\t - print this message\n"

install: zsh vim tmux git ghc tags

vimdeps:
	brew update && brew reinstall the_silver_searcher && brew reinstall ctags && brew reinstall jq

vim: vimlinks vimdeps
	rm -rf ~/.vim
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim -c PlugInstall -c quitall

neovim: vimdeps
	rm -rf $(HOME)/nvim
	mkdir -p $(HOME)/nvim
	ln -sf $(ROOT_DIR)/vimrc $(HOME)/nvim/init.vim
	curl -fLo $(HOME)/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	nvim -c PlugInstall -c quitall

vimlinks:
	ln -sf $(ROOT_DIR)/vimrc $(HOME)/.vimrc

tmux:
	brew update && brew uninstall tmux && brew install brew reinstall https://raw.githubusercontent.com/choppsv1/homebrew-term24/master/tmux.rb && brew reinstall reattach-to-user-namespace
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
