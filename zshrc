export ZSH=$HOME/.oh-my-zsh
export EDITOR=/usr/local/bin/vim
ZSH_THEME="ys"

plugins=(vi-mode git python pip brew bundler rake ruby rails zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

export KEYTIMEOUT=1

export PATH="$HOME/Library/Haskell/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.rvm/bin:$PATH"

alias vim=nvim
alias v=nvim
alias nv=nvim
alias nvi=nvim
alias vi=nvim
