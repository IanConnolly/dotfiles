ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

all:
	@printf "Makefile targets: \n\n"	
	@printf "\tinstall\t\t - install all\n"
	@printf "\tvim\t\t - install vim\n"
	@printf "\ttmux\t\t - install tmux\n"
	@printf "\thelp\t\t - print this message\n"

install: vim tmux

vim: 
	ln -sf $(ROOT_DIR)/vimrc $(HOME)/.vimrc

tmux:
	ln -sf $(ROOT_DIR)/tmux.conf $(HOME)/.tmux.conf

help: all
